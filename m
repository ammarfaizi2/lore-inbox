Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbTLAU2X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 15:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbTLAU2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 15:28:23 -0500
Received: from witte.sonytel.be ([80.88.33.193]:49393 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263937AbTLAU2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 15:28:22 -0500
Date: Mon, 1 Dec 2003 21:28:03 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Andre M. Hedrick" <andre@linux-ide.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.23 IDE warning
Message-ID: <Pine.GSO.4.21.0312012125050.25040-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kill warning about unused definition of unknown_chipset[].

--- linux-ppc-2.4.23/drivers/ide/pci/generic.h.orig	Sun Nov 30 11:48:22 2003
+++ linux-ppc-2.4.23/drivers/ide/pci/generic.h	Sun Nov 30 12:18:36 2003
@@ -148,6 +148,8 @@
 	}
 };
 
+#if 0
+/* Logic to add back later on */
 static ide_pci_device_t unknown_chipset[] __devinitdata = {
 	{	/* 0 */
 		.vendor		= 0,
@@ -170,5 +172,6 @@
 	}
 
 };
+#endif
 
 #endif /* IDE_GENERIC_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

