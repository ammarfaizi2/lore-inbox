Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbUAAU7N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265056AbUAAUzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:55:36 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:5218 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S264880AbUAAUDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:03:00 -0500
Date: Thu, 1 Jan 2004 21:02:58 +0100
Message-Id: <200401012002.i01K2wGo031829@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 366] BVME6000 SCSI
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BVME6000 SCSI: Fix typos

--- linux-2.6.0/drivers/scsi/bvme6000.c	2003-07-29 18:19:09.000000000 +0200
+++ linux-m68k-2.6.0/drivers/scsi/bvme6000.c	2003-11-03 21:47:55.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * Detection routine for the NCR53c710 based MVME16x SCSI Controllers for Linux.
+ * Detection routine for the NCR53c710 based BVME6000 SCSI Controllers for Linux.
  *
  * Based on work by Alan Hourihane
  */
@@ -51,7 +48,7 @@
     return 1;
 }
 
-static int mvme6000_scsi_release(struct Scsi_Host *shost)
+static int bvme6000_scsi_release(struct Scsi_Host *shost)
 {
 	if (shost->irq)
 		free_irq(shost->irq, NULL);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
