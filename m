Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131283AbRCHGtk>; Thu, 8 Mar 2001 01:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131284AbRCHGta>; Thu, 8 Mar 2001 01:49:30 -0500
Received: from mail.sonytel.be ([193.74.243.200]:24309 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S131283AbRCHGtQ>;
	Thu, 8 Mar 2001 01:49:16 -0500
Date: Thu, 8 Mar 2001 07:48:03 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] /dev/fb*
Message-ID: <Pine.GSO.4.10.10103080741340.11907-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

This patch fixes the /dev/fb* entries in devices.txt to conform to the actual
code (which has been there since at least one year).

PLEASE apply this patch! MANY thanks!

--- linux-2.4.3-pre3/Documentation/devices.txt	Sat Dec 30 20:26:10 2000
+++ linux-2.4.2-ac14/Documentation/devices.txt	Thu Mar  8 07:27:30 2001
@@ -660,6 +660,12 @@
 
  29 char	Universal frame buffer
 		  0 = /dev/fb0		First frame buffer
+		  1 = /dev/fb1		Second frame buffer
+		    ...
+		 31 = /dev/fb31		32nd frame buffer
+
+		Backward compatibility aliases {2.6}
+
 		 32 = /dev/fb1		Second frame buffer
 		    ...
 		224 = /dev/fb7		Eighth frame buffer

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

