Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272512AbTGZOmg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272508AbTGZOfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:35:31 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:29745 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S272512AbTGZOch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:37 -0400
Date: Sat, 26 Jul 2003 16:51:41 +0200
Message-Id: <200307261451.h6QEpfB3002316@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Atari ksyms
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atari ksyms: Kill obsolete symbol exports

--- linux-2.6.x/arch/m68k/atari/atari_ksyms.c	Tue Apr  7 16:52:04 1998
+++ linux-m68k-2.6.x/arch/m68k/atari/atari_ksyms.c	Sun Jun  8 12:11:33 2003
@@ -28,16 +28,8 @@
 EXPORT_SYMBOL(atari_stram_alloc);
 EXPORT_SYMBOL(atari_stram_free);
 
-EXPORT_SYMBOL(atari_mouse_buttons);
-EXPORT_SYMBOL(atari_mouse_interrupt_hook);
-EXPORT_SYMBOL(atari_MIDI_interrupt_hook);
 EXPORT_SYMBOL(atari_MFP_init_done);
 EXPORT_SYMBOL(atari_SCC_init_done);
 EXPORT_SYMBOL(atari_SCC_reset_done);
-EXPORT_SYMBOL(ikbd_write);
-EXPORT_SYMBOL(ikbd_mouse_y0_top);
-EXPORT_SYMBOL(ikbd_mouse_thresh);
-EXPORT_SYMBOL(ikbd_mouse_rel_pos);
-EXPORT_SYMBOL(ikbd_mouse_disable);
 
 EXPORT_SYMBOL(atari_microwire_cmd);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
