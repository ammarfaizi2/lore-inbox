Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423189AbWF1FZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423189AbWF1FZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423177AbWF1FTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:19:14 -0400
Received: from terminus.zytor.com ([192.83.249.54]:3534 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423167AbWF1FTA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:19:00 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 21/31] Simple test suite for klibc
Date: Tue, 27 Jun 2006 22:17:21 -0700
Message-Id: <klibc.200606272217.21@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[klibc] Simple test suite for klibc

A very simple handful of tests for klibc.  This is not by any
means an exhaustive test suite, nor are most of the tests
auto-verifying, but they are very useful to spot common porting
problems.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 24b7d25b39c484b6d39bc39003c1c1e315a04398
tree eb533c6e9ab6bbfeb94b4d82d299655e816f01b2
parent d82530df7a105851818935b622e20165f994d3f1
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:51:04 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:51:04 -0700

 usr/klibc/tests/Kbuild        |   47 
 usr/klibc/tests/environ.c     |   24 
 usr/klibc/tests/fcntl.c       |   50 
 usr/klibc/tests/getopttest.c  |   32 
 usr/klibc/tests/getpagesize.c |   10 
 usr/klibc/tests/hello.c       |    7 
 usr/klibc/tests/idtest.c      |   14 
 usr/klibc/tests/malloctest.c  | 4146 +++++++++++++++++++++++++++++++++++++++++
 usr/klibc/tests/malloctest2.c |   62 +
 usr/klibc/tests/memstrtest.c  |   28 
 usr/klibc/tests/microhello.c  |    9 
 usr/klibc/tests/minihello.c   |    7 
 usr/klibc/tests/mmaptest.c    |   73 +
 usr/klibc/tests/opentest.c    |   15 
 usr/klibc/tests/pipetest.c    |   39 
 usr/klibc/tests/rtsig.c       |   12 
 usr/klibc/tests/setenvtest.c  |   39 
 usr/klibc/tests/setjmptest.c  |   38 
 usr/klibc/tests/sigint.c      |   53 +
 usr/klibc/tests/stat.c        |   63 +
 usr/klibc/tests/statfs.c      |   42 
 usr/klibc/tests/strlcpycat.c  |  111 +
 usr/klibc/tests/strtoimax.c   |   23 
 usr/klibc/tests/strtotime.c   |   25 
 usr/klibc/tests/testrand48.c  |   19 
 usr/klibc/tests/testvsnp.c    |  119 +
 usr/klibc/tests/vfork.c       |   45 
 27 files changed, 5152 insertions(+), 0 deletions(-)

Patch suppressed due to size (64 K), available at:
http://www.kernel.org/pub/linux/kernel/people/hpa/klibc-patchset/21-simple-test-suite-for-klibc.patch
