Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbTIVMej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 08:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTIVMej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 08:34:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50428 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263128AbTIVMeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 08:34:37 -0400
Date: Mon, 22 Sep 2003 14:34:32 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Adam Belay <ambx1@neo.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove allowdma0 documentation
Message-ID: <20030922123432.GV6325@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
