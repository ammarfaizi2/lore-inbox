Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265798AbUGDVqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265798AbUGDVqz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 17:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbUGDVqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 17:46:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50684 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265798AbUGDVqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 17:46:53 -0400
Date: Sun, 4 Jul 2004 23:46:45 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Cc: Adam Belay <ambx1@neo.rr.com>, perex@suse.cz
Subject: [2.6 patch] remove allowdma0 documentation (fwd)
Message-ID: <20040704214645.GY28324@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The trivial patch forwarded below (already ACK'ed by Adam Belay) still 
applies against 2.6.7-mm5.

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Mon, 22 Sep 2003 14:34:32 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Adam Belay <ambx1@neo.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove allowdma0 documentation

allowdma0 is gone in 2.6, the patch below removes the mentionings of 
this option in the documentation.

cu
Adrian

--- linux-2.6.0-test5-mm4-no-smp-2.95/Documentation/kernel-parameters.txt.old	2003-09-22 14:31:50.000000000 +0200
+++ linux-2.6.0-test5-mm4-no-smp-2.95/Documentation/kernel-parameters.txt	2003-09-22 14:32:06.000000000 +0200
@@ -123,8 +123,6 @@
 	aic79xx=	[HW,SCSI]
 			See Documentation/scsi/aic79xx.txt.
 
-	allowdma0	[ISAPNP]
-
 	AM53C974=	[HW,SCSI]
 			Format: <host-scsi-id>,<target-scsi-id>,<max-rate>,<max-offset>
 			See also header of drivers/scsi/AM53C974.c.
--- linux-2.6.0-test5-mm4-no-smp-2.95/Documentation/pnp.txt.old	2003-09-22 14:32:39.000000000 +0200
+++ linux-2.6.0-test5-mm4-no-smp-2.95/Documentation/pnp.txt	2003-09-22 14:32:51.000000000 +0200
@@ -83,7 +83,6 @@
 dma 2
 
 also there are a series of kernel parameters:
-allowdma0
 pnp_reserve_irq=irq1[,irq2] ....
 pnp_reserve_dma=dma1[,dma2] ....
 pnp_reserve_io=io1,size1[,io2,size2] ....

----- End forwarded message -----
