Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbTDHJRw (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 05:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbTDHJQW (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 05:16:22 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:50589 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261191AbTDHJQP (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 05:16:15 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Define __kernel_timer_t and __kernel_clockid_t on v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030408092741.68C8D374A@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue,  8 Apr 2003 18:27:41 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.67-moo.orig/include/asm-v850/posix_types.h linux-2.5.67-moo/include/asm-v850/posix_types.h
--- linux-2.5.67-moo.orig/include/asm-v850/posix_types.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.5.67-moo/include/asm-v850/posix_types.h	2003-04-08 10:39:42.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/posix_types.h -- Kernel versions of standard types
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -31,6 +31,8 @@
 typedef long		__kernel_time_t;
 typedef long		__kernel_suseconds_t;
 typedef long		__kernel_clock_t;
+typedef int		__kernel_timer_t;
+typedef int		__kernel_clockid_t;
 typedef int		__kernel_daddr_t;
 typedef char *		__kernel_caddr_t;
 typedef unsigned short	__kernel_uid16_t;
