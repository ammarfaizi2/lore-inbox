Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUFYGas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUFYGas (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 02:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUFYG3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 02:29:31 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:49146 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S266257AbUFYG3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 02:29:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Remove bogus __ARCH_WANT_ macro defs on v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20040625062901.108533F0@mctpc71>
Date: Fri, 25 Jun 2004 15:29:01 +0900 (JST)
From: miles@mctpc71.ucom.lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 include/asm-v850/unistd.h |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -ruN -X../cludes linux-2.6.7-uc0/include/asm-v850/unistd.h linux-2.6.7-uc0-v850-20040625/include/asm-v850/unistd.h
--- linux-2.6.7-uc0/include/asm-v850/unistd.h	2004-06-24 17:08:12.000000000 +0900
+++ linux-2.6.7-uc0-v850-20040625/include/asm-v850/unistd.h	2004-06-25 13:56:41.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/unistd.h -- System call numbers and invocation mechanism
  *
- *  Copyright (C) 2001,02,03  NEC Electronics Corporation
- *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03,04  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03,04  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -389,7 +389,6 @@
 #ifdef __KERNEL__
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
-#define __ARCH_WANT_OLD_STAT
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
@@ -404,7 +403,6 @@
 #define __ARCH_WANT_SYS_GETPGRP
 #define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
-#define __ARCH_WANT_SYS_OLD_GETRLIMIT
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
