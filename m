Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUB0JQN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 04:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbUB0JQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 04:16:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51106 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261752AbUB0JQG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 04:16:06 -0500
Message-ID: <403F0AC6.4000001@pobox.com>
Date: Fri, 27 Feb 2004 04:15:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix piix IDE driver build
Content-Type: multipart/mixed;
 boundary="------------010002070106030507040302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010002070106030507040302
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Yours truly, with the brown paper bag...  this patch will be needed to 
compile tonight's BK snapshot most likely.

	Jeff




--------------010002070106030507040302
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/ide/pci/piix.h 1.11 vs edited =====
--- 1.11/drivers/ide/pci/piix.h	Fri Feb 27 01:01:47 2004
+++ edited/drivers/ide/pci/piix.h	Fri Feb 27 03:26:53 2004
@@ -274,7 +274,6 @@
 		.init_chipset	= init_chipset_piix,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
@@ -288,7 +287,6 @@
 		.init_chipset	= init_chipset_piix,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},

--------------010002070106030507040302--

