#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

# Create package archive and install globally
npm pack --ignore-scripts
npm install -ddd \
    --global \
    --build-from-source \
    ${SRC_DIR}/xo-${PKG_VERSION}.tgz

# Create license report for dependencies
pnpm install
pnpm-licenses generate-disclaimer --prod --output-file=third-party-licenses.txt

tee ${PREFIX}/bin/xo.cmd << EOF
call %CONDA_PREFIX%\bin\node %CONDA_PREFIX%\bin\xo %*
EOF
