Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUBBQIy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 11:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265695AbUBBQIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 11:08:54 -0500
Received: from witte.sonytel.be ([80.88.33.193]:30130 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265691AbUBBQIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 11:08:51 -0500
Date: Mon, 2 Feb 2004 17:08:46 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       R.E.Wolff@BitWizard.nl
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] Specialix compile fix
Message-ID: <Pine.GSO.4.58.0402021707570.19699@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compile fix: add missing #include <linux/init.h>

--- linux-2.6.2-rc3/drivers/char/specialix.c	2003-09-28 09:35:59.000000000 +0200
+++ linux-m68k-2.6.2-rc3/drivers/char/specialix.c	2004-01-10 04:21:35.000000000 +0100
@@ -92,6 +92,7 @@
 #include <linux/delay.h>
 #include <linux/version.h>
 #include <linux/pci.h>
+#include <linux/init.h>
 #include <asm/uaccess.h>

 #include "specialix_io8.h"

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
