Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290291AbSAXIL7>; Thu, 24 Jan 2002 03:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290292AbSAXILu>; Thu, 24 Jan 2002 03:11:50 -0500
Received: from bs1.dnx.de ([213.252.143.130]:38568 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S290291AbSAXILf>;
	Thu, 24 Jan 2002 03:11:35 -0500
Date: Thu, 24 Jan 2002 09:09:50 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: <marcelo@conectiva.com.br>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: New version of AMD Elan patch
In-Reply-To: <Pine.LNX.4.33.0201210821570.21377-100000@callisto.local>
Message-ID: <Pine.LNX.4.33.0201240905010.893-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

thanks for applying the Elan patch. Unfortunately, I've discovered a typo,
patch below.

For the list: the remaining stuff against -pre7 is as usual on

  http://www.pengutronix.de/software/elan_en.wml

Changelog:

01/24/2002      Robert Schwebel <robert@schwebel.de>

                - Revision 2.4.18-pre7.1 released.
                - Marcelo has integrated everything but the serial
                  driver stuff into the latest pre-patch. I'll have
                  to send the rest to tytso...
                - striped out the applied stuff
                - typo in arch/i386/kernel/setup.c

Robert

----------8<----------
diff -urN -X kernel-patches/dontdiff linux-2.4.18-pre7/arch/i386/kernel/setup.c linux-2.4.18-pre7-elan/arch/i386/kernel/setup.c
--- linux-2.4.18-pre7/arch/i386/kernel/setup.c	Thu Jan 24 07:36:14 2002
+++ linux-2.4.18-pre7-elan/arch/i386/kernel/setup.c	Thu Jan 24 08:51:01 2002
@@ -329,7 +329,7 @@
 	{ "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
 	{ "fpu", 0xf0, 0xff, IORESOURCE_BUSY }
 };
-#ifdef CONFIG_ELAN
+#ifdef CONFIG_MELAN
 standard_io_resources[1] = { "pic1", 0x20, 0x21, IORESOURCE_BUSY };
 standard_io_resources[5] = { "pic2", 0xa0, 0xa1, IORESOURCE_BUSY };
 #endif
----------8<----------
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+

