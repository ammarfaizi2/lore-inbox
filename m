Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266156AbUGTTQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266156AbUGTTQS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266130AbUGTTPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:15:00 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:52768 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S266156AbUGTSjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:39:49 -0400
Date: Tue, 20 Jul 2004 20:39:47 +0200
Message-Id: <200407201839.i6KIdlXN015530@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-dvb-maintainer@linuxtv.org
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] depends on PCI: Technisat Skystar2 PCI
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Technisat Skystar2 PCI unconditionally depends on PCI

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/media/dvb/b2c2/Kconfig	2003-07-29 18:18:57.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/media/dvb/b2c2/Kconfig	2004-07-19 18:26:07.000000000 +0200
@@ -1,6 +1,6 @@
 config DVB_B2C2_SKYSTAR
 	tristate "Technisat Skystar2 PCI"
-	depends on DVB_CORE
+	depends on DVB_CORE && PCI
 	help
 	  Support for the Skystar2 PCI DVB card by Technisat, which
 	  is equipped with the FlexCopII chipset by B2C2.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
