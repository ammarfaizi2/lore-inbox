Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262961AbUKRUzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbUKRUzp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbUKRUw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 15:52:27 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.21]:11058 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S261153AbUKRUoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 15:44:04 -0500
Date: Thu, 18 Nov 2004 21:43:55 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "James E.J. Bottomley" <James.Bottomley@SteelEye.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] SCSI_QLOGIC_1280_1040 depends on SCSI_QLOGIC_1280
Message-ID: <Pine.LNX.4.61.0411182143150.6824@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


SCSI_QLOGIC_1280_1040 depends on SCSI_QLOGIC_1280

--- linux-2.6.10-rc2/drivers/scsi/Kconfig	2004-11-15 11:05:37.000000000 +0100
+++ linux-m68k-2.6.10-rc2/drivers/scsi/Kconfig	2004-11-15 12:42:58.000000000 +0100
@@ -1288,6 +1288,7 @@
 
 config SCSI_QLOGIC_1280_1040
 	bool "Qlogic QLA 1020/1040 SCSI support"
+	depends on SCSI_QLOGIC_1280
 	help
 	  Say Y here if you have a QLogic ISP1020/1040 SCSI host adapter and
 	  do not want to use the old driver.  This option enables support in

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
