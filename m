Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272517AbTGZOlH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272524AbTGZOj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:39:58 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:50225 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S272525AbTGZOct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:49 -0400
Date: Sat, 26 Jul 2003 16:51:56 +0200
Message-Id: <200307261451.h6QEpusD002436@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Fbdev <linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] MIPS DEC/SGI Linux logo
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MIPS: Show the correct logo on DEC and SGI machines.

--- linux-2.6.x/drivers/video/logo/logo.c	Tue May 27 19:03:30 2003
+++ linux-m68k-2.6.x/drivers/video/logo/logo.c	Sat Jun 28 14:54:12 2003
@@ -66,7 +66,7 @@
 #endif
 #ifdef CONFIG_LOGO_DEC_CLUT224
 		/* DEC Linux logo on MIPS/MIPS64 */
-		if (mips_machgroup == MACH_GROUP_SGI)
+		if (mips_machgroup == MACH_GROUP_DEC)
 			logo = &logo_dec_clut224;
 #endif
 #ifdef CONFIG_LOGO_MAC_CLUT224

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
