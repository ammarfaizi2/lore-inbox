Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268355AbUI2MxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268355AbUI2MxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 08:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268365AbUI2MxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 08:53:09 -0400
Received: from mail.renesas.com ([202.234.163.13]:55205 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S268355AbUI2MwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 08:52:05 -0400
Date: Wed, 29 Sep 2004 21:51:54 +0900 (JST)
Message-Id: <20040929.215154.1025206099.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.9-rc2-mm4] [m32r] Update comments for Renesas
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a patch to update comments for Renesas.
The M32R processor is a product of Renesas Technology Corporation now.

Thank you.

	* arch/m32r/kernel/setup.c:
	- Change from "MITSUBISHI" to "Renesas"
	- Remove RCS ID.
	* arch/m32r/kernel/setup_m32700ut.c: ditto.
	* arch/m32r/kernel/setup_mappi.c: ditto.

	* arch/m32r/kernel/setup_mappi2.c: 
	- Remove RCS ID.
	* arch/m32r/kernel/setup_oaks32r.c: ditto.
	* arch/m32r/kernel/setup_opsput.c: ditto.
	* arch/m32r/kernel/setup_usrv.c: ditto.

	* include/asm-m32r/m32102.h:
	- Add copyright statement of Renesas
	- Remove RCS ID.
	* include/asm-m32r/m32r.h: ditto.
	* include/asm-m32r/m32r_mp_fpga.h: ditto.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/setup.c          |    2 +-
 arch/m32r/kernel/setup_m32700ut.c |    4 +---
 arch/m32r/kernel/setup_mappi.c    |    6 +-----
 arch/m32r/kernel/setup_mappi2.c   |    4 ----
 arch/m32r/kernel/setup_oaks32r.c  |    4 ----
 arch/m32r/kernel/setup_opsput.c   |    2 --
 arch/m32r/kernel/setup_usrv.c     |    4 ----
 include/asm-m32r/m32102.h         |    7 ++++---
 include/asm-m32r/m32r.h           |    7 +++----
 include/asm-m32r/m32r_mp_fpga.h   |    8 ++++----
 10 files changed, 14 insertions(+), 34 deletions(-)


diff -ruNp a/arch/m32r/kernel/setup.c b/arch/m32r/kernel/setup.c
--- a/arch/m32r/kernel/setup.c	2004-09-28 10:19:10.000000000 +0900
+++ b/arch/m32r/kernel/setup.c	2004-09-28 12:38:23.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  *  linux/arch/m32r/kernel/setup.c
  *
- *  Setup routines for MITSUBISHI M32R
+ *  Setup routines for Renesas M32R
  *
  *  Copyright (c) 2001, 2002  Hiroyuki Kondo, Hirokazu Takata,
  *                            Hitoshi Yamamoto
diff -ruNp a/arch/m32r/kernel/setup_m32700ut.c b/arch/m32r/kernel/setup_m32700ut.c
--- a/arch/m32r/kernel/setup_m32700ut.c	2004-09-28 10:19:10.000000000 +0900
+++ b/arch/m32r/kernel/setup_m32700ut.c	2004-09-28 12:38:23.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  *  linux/arch/m32r/kernel/setup_m32700ut.c
  *
- *  Setup routines for MITSUBISHI M32700UT Board
+ *  Setup routines for Renesas M32700UT Board
  *
  *  Copyright (c) 2002 	Hiroyuki Kondo, Hirokazu Takata,
  *                      Hitoshi Yamamoto, Takeo Takahashi
@@ -9,8 +9,6 @@
  *  This file is subject to the terms and conditions of the GNU General
  *  Public License.  See the file "COPYING" in the main directory of this
  *  archive for more details.
- *
- *  $Id: setup_m32700ut.c,v 1.6 2003/11/27 10:18:49 takeo Exp $
  */
 
 #include <linux/config.h>
diff -ruNp a/arch/m32r/kernel/setup_mappi.c b/arch/m32r/kernel/setup_mappi.c
--- a/arch/m32r/kernel/setup_mappi.c	2004-09-28 10:19:10.000000000 +0900
+++ b/arch/m32r/kernel/setup_mappi.c	2004-09-28 12:38:23.000000000 +0900
@@ -1,16 +1,12 @@
 /*
  *  linux/arch/m32r/kernel/setup_mappi.c
  *
- *  Setup routines for MITSUBISHI MAPPI Board
+ *  Setup routines for Renesas MAPPI Board
  *
  *  Copyright (c) 2001, 2002  Hiroyuki Kondo, Hirokazu Takata,
  *                            Hitoshi Yamamoto
  */
 
-static char *rcsid =
-"$Id$";
-static void use_rcsid(void) {rcsid = rcsid; use_rcsid();}
-
 #include <linux/config.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
diff -ruNp a/arch/m32r/kernel/setup_mappi2.c b/arch/m32r/kernel/setup_mappi2.c
--- a/arch/m32r/kernel/setup_mappi2.c	2004-09-28 10:19:10.000000000 +0900
+++ b/arch/m32r/kernel/setup_mappi2.c	2004-09-28 12:38:23.000000000 +0900
@@ -7,10 +7,6 @@
  *                            Hitoshi Yamamoto, Mamoru Sakugawa
  */
 
-static char *rcsid =
-"$Id$";
-static void use_rcsid(void) {rcsid = rcsid; use_rcsid();}
-
 #include <linux/config.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
diff -ruNp a/arch/m32r/kernel/setup_oaks32r.c b/arch/m32r/kernel/setup_oaks32r.c
--- a/arch/m32r/kernel/setup_oaks32r.c	2004-09-28 10:19:10.000000000 +0900
+++ b/arch/m32r/kernel/setup_oaks32r.c	2004-09-28 12:38:23.000000000 +0900
@@ -7,10 +7,6 @@
  *                            Hitoshi Yamamoto, Mamoru Sakugawa
  */
 
-static char *rcsid =
-"$Id: setup_oaks32r.c,v 1.1 2004/03/31 05:06:18 sakugawa Exp $";
-static void use_rcsid(void) {rcsid = rcsid; use_rcsid();}
-
 #include <linux/config.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
diff -ruNp a/arch/m32r/kernel/setup_opsput.c b/arch/m32r/kernel/setup_opsput.c
--- a/arch/m32r/kernel/setup_opsput.c	2004-09-28 10:19:10.000000000 +0900
+++ b/arch/m32r/kernel/setup_opsput.c	2004-09-28 12:38:23.000000000 +0900
@@ -10,8 +10,6 @@
  *  This file is subject to the terms and conditions of the GNU General
  *  Public License.  See the file "COPYING" in the main directory of this
  *  archive for more details.
- *
- *  $Id: setup_opsput.c,v 1.1 2004/07/27 06:54:20 sakugawa Exp $
  */
 
 #include <linux/config.h>
diff -ruNp a/arch/m32r/kernel/setup_usrv.c b/arch/m32r/kernel/setup_usrv.c
--- a/arch/m32r/kernel/setup_usrv.c	2004-09-28 10:19:10.000000000 +0900
+++ b/arch/m32r/kernel/setup_usrv.c	2004-09-28 12:38:23.000000000 +0900
@@ -7,10 +7,6 @@
  *                                  Hitoshi Yamamoto
  */
 
-static char *rcsid =
-"$Id$";
-static void use_rcsid(void) {rcsid = rcsid; use_rcsid();}
-
 #include <linux/config.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
diff -ruNp a/include/asm-m32r/m32102.h b/include/asm-m32r/m32102.h
--- a/include/asm-m32r/m32102.h	2004-09-28 10:19:53.000000000 +0900
+++ b/include/asm-m32r/m32102.h	2004-09-29 10:28:05.000000000 +0900
@@ -2,10 +2,11 @@
 #define _M32102_H_
 
 /*
- * Mitsubishi M32R 32102 group
- * Copyright (c) 2001 [Hitoshi Yamamoto] All rights reserved.
+ * Renesas M32R 32102 group
+ *
+ * Copyright (c) 2001  Hitoshi Yamamoto
+ * Copyright (c) 2003, 2004  Renesas Technology Corp.
  */
-/* $Id$ */
 
 /*======================================================================*
  * Special Function Register
diff -ruNp a/include/asm-m32r/m32r.h b/include/asm-m32r/m32r.h
--- a/include/asm-m32r/m32r.h	2004-09-28 10:19:53.000000000 +0900
+++ b/include/asm-m32r/m32r.h	2004-09-29 10:46:50.000000000 +0900
@@ -2,12 +2,11 @@
 #define _ASM_M32R_M32R_H_
 
 /*
- * Mitsubishi M32R processor
- * Copyright (C) 1997-2002, Mitsubishi Electric Corporation
+ * Renesas M32R processor
+ *
+ * Copyright (C) 2003, 2004  Renesas Technology Corp.
  */
 
-/* $Id$ */
-
 #include <linux/config.h>
 
 /* Chip type */
diff -ruNp a/include/asm-m32r/m32r_mp_fpga.h b/include/asm-m32r/m32r_mp_fpga.h
--- a/include/asm-m32r/m32r_mp_fpga.h	2004-09-28 10:19:53.000000000 +0900
+++ b/include/asm-m32r/m32r_mp_fpga.h	2004-09-28 12:38:24.000000000 +0900
@@ -2,12 +2,12 @@
 #define _ASM_M32R_M32R_MP_FPGA_
 
 /*
- * Mitsubishi M32R-MP-FPGA
- * Copyright (c) 2002 [Hitoshi Yamamoto] All rights reserved.
+ * Renesas M32R-MP-FPGA
+ *
+ * Copyright (c) 2002  Hitoshi Yamamoto
+ * Copyright (c) 2003, 2004  Renesas Technology Corp.
  */
 
-/* $Id$ */
-
 /*
  * ========================================================
  * M32R-MP-FPGA Memory Map

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
