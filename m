Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264839AbUDWPMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264839AbUDWPMM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 11:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264837AbUDWPKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 11:10:55 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:19258 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S264838AbUDWPKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 11:10:38 -0400
Date: Fri, 23 Apr 2004 17:10:36 +0200
Message-Id: <200404231510.i3NFAak5022634@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 153] Amiga A2065 Ethernet debug
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga A2065 Ethernet: Add missing variable in debug code

--- linux-2.4.26/drivers/net/a2065.c	13 Jun 2003 21:43:18 -0000	1.3.2.3
+++ linux-m68k-2.4.26/drivers/net/a2065.c	16 Apr 2004 11:37:36 -0000
@@ -284,6 +284,7 @@
 	struct sk_buff *skb = 0;	/* XXX shut up gcc warnings */
 
 #ifdef TEST_HITS
+	int i;
 	printk ("[");
 	for (i = 0; i < RX_RING_SIZE; i++) {
 		if (i == lp->rx_new)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
