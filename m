Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbTI1NDv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTI1NDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:03:50 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:49172 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S262553AbTI1NCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:02:52 -0400
Date: Sun, 28 Sep 2003 14:55:26 +0200
Message-Id: <200309281255.h8SCtQL2005552@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 313] Atari ACSI is broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atari ACSI is broken (needs bio updates)

--- linux-2.6.0-test6/drivers/block/Kconfig	Tue Jul 29 18:18:44 2003
+++ linux-m68k-2.6.0-test6/drivers/block/Kconfig	Thu Sep 18 04:32:49 2003
@@ -68,7 +68,7 @@
 
 config ATARI_ACSI
 	tristate "Atari ACSI support"
-	depends on ATARI
+	depends on ATARI && BROKEN
 	---help---
 	  This enables support for the Atari ACSI interface. The driver
 	  supports hard disks and CD-ROMs, which have 512-byte sectors, or can

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
