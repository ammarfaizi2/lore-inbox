Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbUKULiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUKULiq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 06:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUKULip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 06:38:45 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.23]:27180 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261704AbUKULih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 06:38:37 -0500
Date: Sun, 21 Nov 2004 12:38:35 +0100
Message-Id: <200411211138.iALBcZ6l032381@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 534] M68k: Update HP300 defconfig (enable DIO and HP Lance Ethernet)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Update HP300 defconfig (enable DIO and HP Lance Ethernet)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc2/arch/m68k/configs/hp300_defconfig	2004-11-18 21:46:29.000000000 +0100
+++ linux-m68k-2.6.10-rc2/arch/m68k/configs/hp300_defconfig	2004-11-21 11:18:26.000000000 +0100
@@ -65,7 +65,7 @@
 # CONFIG_APOLLO is not set
 # CONFIG_VME is not set
 CONFIG_HP300=y
-# CONFIG_DIO is not set
+CONFIG_DIO=y
 # CONFIG_SUN3X is not set
 # CONFIG_Q40 is not set
 
@@ -404,7 +404,7 @@
 #
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=m
-# CONFIG_HPLANCE is not set
+CONFIG_HPLANCE=y
 
 #
 # Ethernet (1000 Mbit)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
