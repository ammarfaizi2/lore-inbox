Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbTI1PEz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 11:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTI1PEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 11:04:55 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:50493 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S262607AbTI1PEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 11:04:53 -0400
Date: Sun, 28 Sep 2003 14:55:25 +0200
Message-Id: <200309281255.h8SCtPZ3005546@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 312] Macintosh SWIM IOP floppy is broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Macintosh SWIM IOP floppy is broken (needs bio updates)

--- linux-2.6.0-test6/drivers/block/Kconfig	Tue Jul 29 18:18:44 2003
+++ linux-m68k-2.6.0-test6/drivers/block/Kconfig	Thu Sep 18 04:27:49 2003
@@ -37,7 +37,7 @@
 
 config BLK_DEV_SWIM_IOP
 	bool "Macintosh IIfx/Quadra 900/Quadra 950 floppy support (EXPERIMENTAL)"
-	depends on MAC && EXPERIMENTAL
+	depends on MAC && EXPERIMENTAL && BROKEN
 	help
 	  Say Y here to support the SWIM (Super Woz Integrated Machine) IOP
 	  floppy controller on the Macintosh IIfx and Quadra 900/950.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
