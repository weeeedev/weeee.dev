#!/bin/bash

set -eEuo pipefail

function cleanup {
    rm -rf deployment/
}

trap cleanup EXIT

echo "Deploying to GitHub pages"

git clone -b master https://github.com/weeeedev/weeeedev.github.io.git deployment
rsync -av --delete --exclude ".git" public/ deployment

cd deployment
git add --all
git commit -m "Built on $(date), commit ${TRAVIS_COMMIT} by job ${TRAVIS_JOB_NUMBER}" || true
git push
