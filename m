Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbUJaKSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbUJaKSa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 05:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbUJaKR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 05:17:57 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:9807 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S261532AbUJaKDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:03:40 -0500
Date: Sun, 31 Oct 2004 11:03:39 +0100
Message-Id: <200410311003.i9VA3dxx009621@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 501] Sun-3 Makefile: join short multi-line
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun-3 Makefile: join short multi-line

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/arch/m68k/sun3/Makefile	2004-04-27 20:36:38.000000000 +0200
+++ linux-m68k-2.6.10-rc1/arch/m68k/sun3/Makefile	2004-10-17 17:47:16.000000000 +0200
@@ -4,5 +4,4 @@
 
 obj-y	:= sun3_ksyms.o sun3ints.o sun3dvma.o sbus.o idprom.o
 
-obj-$(CONFIG_SUN3) += config.o mmu_emu.o leds.o dvma.o \
-			intersil.o
+obj-$(CONFIG_SUN3) += config.o mmu_emu.o leds.o dvma.o intersil.o

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
