Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272526AbTGZOlM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272502AbTGZOeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:34:22 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:38951 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S272503AbTGZOcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:31 -0400
Date: Sat, 26 Jul 2003 16:51:39 +0200
Message-Id: <200307261451.h6QEpd48002304@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Atari pamsnet
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atari pamsnet: Fix typo

--- linux-2.6.x/drivers/net/atari_pamsnet.c	Fri May  9 10:21:32 2003
+++ linux-m68k-2.6.x/drivers/net/atari_pamsnet.c	Sat Jun  7 19:59:37 2003
@@ -169,7 +169,7 @@
 
 static irqreturn_t pamsnet_intr(int irq, void *data, struct pt_regs *fp);
 
-static struct timer_list pamsnet_timer = TIMER_INITIALIZER(amsnet_tick, 0, 0);
+static struct timer_list pamsnet_timer = TIMER_INITIALIZER(pamsnet_tick, 0, 0);
 
 #define STRAM_ADDR(a)	(((a) & 0xff000000) == 0)
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
