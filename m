Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbWFZA75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbWFZA75 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 20:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWFZA7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:59:54 -0400
Received: from terminus.zytor.com ([192.83.249.54]:25999 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965091AbWFZA7d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:59:33 -0400
Date: Sun, 25 Jun 2006 17:58:08 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 38/43] Simple test suite for klibc
Message-Id: <klibc.200606251757.38@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[klibc] Simple test suite for klibc

A very simple handful of tests for klibc.  This is not by any
means an exhaustive test suite, nor are most of the tests
auto-verifying, but they are very useful to spot common porting
problems.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit b64a5142ab2aa6c030b2a254eb94384161f93f0c
tree 84a5bea0d108e9365018d4698548764be7dc68ea
parent f889dd04bef1aed36ba18161c727af47338e167a
author H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:55 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:55 -0700

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
http://www.kernel.org/pub/linux/kernel/people/hpa/klibc-patchset/38-simple-test-suite-for-klibc.patch
