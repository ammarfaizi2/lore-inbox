Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265652AbUFTRkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265652AbUFTRkx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265879AbUFTRat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:30:49 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:21859 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S265652AbUFTR0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:26:17 -0400
Date: Sun, 20 Jun 2004 19:26:18 +0200
Message-Id: <200406201726.i5KHQIVW001520@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 455] Mac Sonic Ethernet
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac Sonic Ethernet: Kill duplicate `MODULE_LICENSE("GPL");' (already defined in
included sonic.c) which causes a compile failure

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.7/drivers/net/macsonic.c	2004-04-28 15:48:24.000000000 +0200
+++ linux-m68k-2.6.7/drivers/net/macsonic.c	2004-05-04 22:42:38.000000000 +0200
@@ -613,7 +613,6 @@ static struct net_device *dev_macsonic;
 
 MODULE_PARM(sonic_debug, "i");
 MODULE_PARM_DESC(sonic_debug, "macsonic debug level (1-4)");
-MODULE_LICENSE("GPL");
 
 int
 init_module(void)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
