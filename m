Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbUJaKk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbUJaKk4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 05:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbUJaKki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 05:40:38 -0500
Received: from nl-ams-slo-l4-01-pip-3.chellonetwork.com ([213.46.243.17]:14133
	"EHLO amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261547AbUJaKEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:04:31 -0500
Date: Sun, 31 Oct 2004 11:03:38 +0100
Message-Id: <200410311003.i9VA3cEr009596@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 492] HP300 SCSI chip is 98265A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HP300: Fix typos in the DIO output. The SCSI chip is a 98265A, not a 98625A.
NetBSD has this already fixed.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/include/linux/dio.h       15 Jul 2004 20:07:31 -0000      1.4
+++ linux-m68k-2.6.10-rc1/include/linux/dio.h       21 Sep 2004 21:03:43 -0000
@@ -99,14 +99,14 @@
 #define DIO_DESC_FHPIB "98625A/98625B fast HPIB"
 #define DIO_ID_NHPIB    0x01 /* 98624A HP-IB (normal ie slow) */
 #define DIO_DESC_NHPIB "98624A HPIB"
-#define DIO_ID_SCSI0    0x07 /* 98625A SCSI */
-#define DIO_DESC_SCSI0 "98625A SCSI0"
+#define DIO_ID_SCSI0    0x07 /* 98265A SCSI */
+#define DIO_DESC_SCSI0 "98265A SCSI0"
 #define DIO_ID_SCSI1    0x27 /* ditto */
-#define DIO_DESC_SCSI1 "98625A SCSI1"
+#define DIO_DESC_SCSI1 "98265A SCSI1"
 #define DIO_ID_SCSI2    0x47 /* ditto */
-#define DIO_DESC_SCSI2 "98625A SCSI2"
+#define DIO_DESC_SCSI2 "98265A SCSI2"
 #define DIO_ID_SCSI3    0x67 /* ditto */
-#define DIO_DESC_SCSI3 "98625A SCSI3"
+#define DIO_DESC_SCSI3 "98265A SCSI3"
 #define DIO_ID_FBUFFER  0x39 /* framebuffer: flavour is distinguished by secondary ID */
 #define DIO_DESC_FBUFFER "bitmapped display"
 /* the NetBSD kernel source is a bit unsure as to what these next IDs actually do :-> */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
