Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbVCUUuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVCUUuJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVCUUse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:48:34 -0500
Received: from amsfep18-int.chello.nl ([213.46.243.20]:27672 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S261875AbVCUUqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:46:25 -0500
Date: Mon, 21 Mar 2005 21:46:08 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Airlie <airlied@linux.ie>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       dri-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] 3dfx DRM depends on PCI
Message-ID: <Pine.LNX.4.62.0503212144570.768@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


3dfx DRM depends on PCI

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.12-rc1/drivers/char/drm/Kconfig	2005-01-22 09:28:00.000000000 +0100
+++ linux-m68k-2.6.12-rc1/drivers/char/drm/Kconfig	2005-01-17 22:51:02.000000000 +0100
@@ -18,7 +18,7 @@ config DRM
 
 config DRM_TDFX
 	tristate "3dfx Banshee/Voodoo3+"
-	depends on DRM
+	depends on DRM && PCI
 	help
 	  Choose this option if you have a 3dfx Banshee or Voodoo3 (or later),
 	  graphics card.  If M is selected, the module will be called tdfx.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
