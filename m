Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbTDHJRr (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 05:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbTDHJQU (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 05:16:20 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:51357 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261242AbTDHJQP (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 05:16:15 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Include <asm/string.h> in v850 simcons.c
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030408092742.87F6B3731@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue,  8 Apr 2003 18:27:42 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.67-moo.orig/arch/v850/kernel/simcons.c linux-2.5.67-moo/arch/v850/kernel/simcons.c
--- linux-2.5.67-moo.orig/arch/v850/kernel/simcons.c	2002-11-28 10:24:54.000000000 +0900
+++ linux-2.5.67-moo/arch/v850/kernel/simcons.c	2003-04-08 10:39:41.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/simcons.c -- Console I/O for GDB v850e simulator
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 
 #include <asm/poll.h>
+#include <asm/string.h>
 #include <asm/simsyscall.h>
 
 
