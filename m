Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbUKULky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUKULky (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 06:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUKULj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 06:39:28 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.16]:45897 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S261730AbUKULih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 06:38:37 -0500
Date: Sun, 21 Nov 2004 12:38:35 +0100
Message-Id: <200411211138.iALBcZpK032376@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 533] M68k HP Lance Ethernet depends on DIO bus support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HP Lance Ethernet depends on DIO bus support

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc2/drivers/net/Kconfig	2004-11-15 11:05:35.000000000 +0100
+++ linux-m68k-2.6.10-rc2/drivers/net/Kconfig	2004-11-21 10:55:23.000000000 +0100
@@ -429,7 +429,7 @@
 
 config HPLANCE
 	bool "HP on-board LANCE support"
-	depends on NET_ETHERNET && HP300
+	depends on NET_ETHERNET && DIO
 	select CRC32
 	help
 	  If you want to use the builtin "LANCE" Ethernet controller on an

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
