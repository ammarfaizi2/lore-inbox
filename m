Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbUJaKkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbUJaKkW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 05:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbUJaKjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 05:39:54 -0500
Received: from amsfep18-int.chello.nl ([213.46.243.13]:57391 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S261543AbUJaKDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:03:48 -0500
Date: Sun, 31 Oct 2004 11:03:46 +0100
Message-Id: <200410311003.i9VA3kww009724@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 523] M68k: Remove duplicate includes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Remove duplicate includes (from Adrian Bunk)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/arch/m68k/q40/config.c	2004-08-04 12:13:35.000000000 +0200
+++ linux-m68k-2.6.10-rc1/arch/m68k/q40/config.c	2004-10-30 15:00:26.000000000 +0200
@@ -33,7 +33,6 @@
 #include <asm/setup.h>
 #include <asm/irq.h>
 #include <asm/traps.h>
-#include <asm/rtc.h>
 #include <asm/machdep.h>
 #include <asm/q40_master.h>
 
--- linux-2.6.10-rc1/drivers/char/amiserial.c	2004-10-23 15:31:12.000000000 +0200
+++ linux-m68k-2.6.10-rc1/drivers/char/amiserial.c	2004-10-31 10:25:17.000000000 +0100
@@ -84,7 +84,6 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/delay.h>
 #include <linux/bitops.h>
 
 #include <asm/setup.h>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
