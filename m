Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272543AbTGZOod (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272541AbTGZOms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:42:48 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:41541 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S272540AbTGZOdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:33:04 -0400
Date: Sat, 26 Jul 2003 16:52:00 +0200
Message-Id: <200307261452.h6QEq0x8002484@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dmasound re-resurrection
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resurrect dmasound: Re-re-add dmasound to the build process (it got removed
again in 2.5.71)

--- linux-2.6.x/sound/Makefile	Sun Jun 15 09:39:18 2003
+++ linux-m68k-2.6.x/sound/Makefile	Mon Jul 21 23:47:42 2003
@@ -3,6 +3,7 @@
 
 obj-$(CONFIG_SOUND) += soundcore.o
 obj-$(CONFIG_SOUND_PRIME) += oss/
+obj-$(CONFIG_DMASOUND) += oss/
 obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/
 
 ifeq ($(CONFIG_SND),y)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
