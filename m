Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272514AbTGZOmg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272512AbTGZOfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:35:41 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:3401 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S272514AbTGZOcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:41 -0400
Date: Sat, 26 Jul 2003 16:51:48 +0200
Message-Id: <200307261451.h6QEpmPH002364@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Mac8390 typo
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac8390: Fix typo (from Etsushi Kato)

--- linux-2.6.x/drivers/net/mac8390.c	Tue Mar 18 11:27:34 2003
+++ linux-m68k-2.6.x/drivers/net/mac8390.c	Mon Jun  9 21:51:42 2003
@@ -378,7 +378,7 @@
 #ifdef MODULE
 MODULE_AUTHOR("David Huggins-Daines <dhd@debian.org> and others");
 MODULE_DESCRIPTION("Macintosh NS8390-based Nubus Ethernet driver");
-MODUEL_LICENSE("GPL");
+MODULE_LICENSE("GPL");
 
 int init_module(void)
 {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
