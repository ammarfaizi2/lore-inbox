Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVFLI6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVFLI6B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 04:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVFLI6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 04:58:00 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.21]:1835 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S261918AbVFLI5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 04:57:44 -0400
Date: Sun, 12 Jun 2005 10:57:40 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: [PATCH] IrDA: IrDA: Fix CONFIG_VIA_FIR typo (double `those')
Message-ID: <Pine.LNX.4.62.0506121056560.29365@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IrDA: Fix CONFIG_VIA_FIR typo (double `those')

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

---
 Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.12-rc5/drivers/net/irda/Kconfig	2005-05-07 09:50:36.000000000 +0200
+++ linux-m68k-2.6.12-rc5/drivers/net/irda/Kconfig	2005-05-07 11:01:31.000000000 +0200
@@ -389,7 +389,7 @@ config VIA_FIR
 	help
 	  Say Y here if you want to build support for the VIA VT8231
 	  and VIA VT1211 IrDA controllers, found on the motherboards using
-	  those those VIA chipsets. To use this controller, you will need
+	  those VIA chipsets. To use this controller, you will need
 	  to plug a specific 5 pins FIR IrDA dongle in the specific
 	  motherboard connector. The driver provides support for SIR, MIR
 	  and FIR (4Mbps) speeds.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
