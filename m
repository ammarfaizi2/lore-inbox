Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136901AbREJTOP>; Thu, 10 May 2001 15:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136902AbREJTOF>; Thu, 10 May 2001 15:14:05 -0400
Received: from hood.tvd.be ([195.162.196.21]:7363 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S136901AbREJTNv>;
	Thu, 10 May 2001 15:13:51 -0400
Date: Thu, 10 May 2001 21:10:41 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "H. Peter Anvin" <device@lanana.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] /dev/fb* docu fixes
Message-ID: <Pine.LNX.4.05.10105102108240.21744-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

This patch brings the documentation for /dev/fb* in sync with the
implementation.

The implementation behaves like this since nearly ca. 1.5 years.
This patch is in Alan's tree since nearly 6 months.

Thanks for applying!

diff -urN linux-2.4.5-pre1/Documentation/devices.txt fbdev-2.4.4/Documentation/devices.txt
--- linux-2.4.5-pre1/Documentation/devices.txt	Sat Dec 30 20:26:10 2000
+++ fbdev-2.4.4/Documentation/devices.txt	Mon Feb 26 09:02:13 2001
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

