Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266130AbUGTTQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266130AbUGTTQT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbUGTTOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:14:53 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.20]:15953 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S266130AbUGTSju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:39:50 -0400
Date: Tue, 20 Jul 2004 20:39:47 +0200
Message-Id: <200407201839.i6KIdlMi015535@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       apdim@grecian.net
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] depends on PCI: Guillemot MAXI Radio FM 2000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillemot MAXI Radio FM 2000 unconditionally depends on PCI

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/media/radio/Kconfig	2004-04-15 11:44:12.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/media/radio/Kconfig	2004-07-19 18:26:53.000000000 +0200
@@ -145,7 +145,7 @@
 
 config RADIO_MAXIRADIO
 	tristate "Guillemot MAXI Radio FM 2000 radio"
-	depends on VIDEO_DEV
+	depends on VIDEO_DEV && PCI
 	---help---
 	  Choose Y here if you have this radio card.  This card may also be
 	  found as Gemtek PCI FM.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
