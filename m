Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbUKULkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUKULkx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 06:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbUKULjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 06:39:42 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:60193 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261937AbUKULih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 06:38:37 -0500
Date: Sun, 21 Nov 2004 12:38:35 +0100
Message-Id: <200411211138.iALBcZl3032386@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 535] M68k: Update Atari defconfig (enable Ethernet and MII)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Update Atari defconfig (enable Ethernet and MII)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc2/arch/m68k/configs/atari_defconfig	2004-11-18 21:46:29.000000000 +0100
+++ linux-m68k-2.6.10-rc2/arch/m68k/configs/atari_defconfig	2004-11-21 12:10:48.000000000 +0100
@@ -430,7 +430,8 @@
 #
 # Ethernet (10 or 100Mbit)
 #
-# CONFIG_NET_ETHERNET is not set
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=m
 CONFIG_ATARILANCE=m
 
 #

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
