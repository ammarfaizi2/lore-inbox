Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUDMIki (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 04:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbUDMIjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 04:39:09 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:28201 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S263211AbUDMIiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 04:38:12 -0400
Date: Tue, 13 Apr 2004 10:38:10 +0200
Message-Id: <200404130838.i3D8cANA018461@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 430] M68k vector definitions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Add remaining CPU vector definitions

--- linux-2.6.5-rc2/include/asm-m68k/traps.h	2001-01-04 22:00:55.000000000 +0100
+++ linux-m68k-2.6.5-rc2/include/asm-m68k/traps.h	2004-03-21 20:38:12.000000000 +0100
@@ -19,6 +19,8 @@
 
 #endif
 
+#define VEC_RESETSP (0)
+#define VEC_RESETPC (1)
 #define VEC_BUSERR  (2)
 #define VEC_ADDRERR (3)
 #define VEC_ILLEGAL (4)
@@ -29,10 +31,18 @@
 #define VEC_TRACE   (9)
 #define VEC_LINE10  (10)
 #define VEC_LINE11  (11)
-#define VEC_RESV1   (12)
+#define VEC_RESV12  (12)
 #define VEC_COPROC  (13)
 #define VEC_FORMAT  (14)
 #define VEC_UNINT   (15)
+#define VEC_RESV16  (16)
+#define VEC_RESV17  (17)
+#define VEC_RESV18  (18)
+#define VEC_RESV19  (19)
+#define VEC_RESV20  (20)
+#define VEC_RESV21  (21)
+#define VEC_RESV22  (22)
+#define VEC_RESV23  (23)
 #define VEC_SPUR    (24)
 #define VEC_INT1    (25)
 #define VEC_INT2    (26)
@@ -65,8 +75,14 @@
 #define VEC_FPOVER  (53)
 #define VEC_FPNAN   (54)
 #define VEC_FPUNSUP (55)
+#define VEC_MMUCFG  (56)
+#define VEC_MMUILL  (57)
+#define VEC_MMUACC  (58)
+#define VEC_RESV59  (59)
 #define	VEC_UNIMPEA (60)
 #define	VEC_UNIMPII (61)
+#define VEC_RESV62  (62)
+#define VEC_RESV63  (63)
 #define VEC_USER    (64)
 
 #define VECOFF(vec) ((vec)<<2)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
