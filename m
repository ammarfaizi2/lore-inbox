Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTI1Vll (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 17:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbTI1Vll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 17:41:41 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:53063 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S262763AbTI1Vli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 17:41:38 -0400
Date: Sun, 28 Sep 2003 14:55:31 +0200
Message-Id: <200309281255.h8SCtVE1005594@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 320] Macintosh CS89x0 Ethernet is broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Macintosh CS89x0 Ethernet is broken (needs netif updates)

--- linux-2.6.0-test6/drivers/net/Kconfig	Tue Sep  9 10:12:56 2003
+++ linux-m68k-2.6.0-test6/drivers/net/Kconfig	Fri Sep 19 14:25:48 2003
@@ -351,7 +351,7 @@
 
 config MAC89x0
 	tristate "Macintosh CS89x0 based ethernet cards"
-	depends on NETDEVICES && MAC
+	depends on NETDEVICES && MAC && BROKEN
 	---help---
 	  Support for CS89x0 chipset based Ethernet cards.  If you have a
 	  Nubus or LC-PDS network (Ethernet) card of this type, say Y and

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
