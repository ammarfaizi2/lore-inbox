Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbTEBPZD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 11:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbTEBPZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 11:25:02 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:61483 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262934AbTEBPY7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 11:24:59 -0400
Subject: [PATCH] pci.ids 2.5.68 (and question)
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "torvalds@transmeta.com" <torvalds@transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1051889846.1718.9.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 02 May 2003 10:37:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new PCI IDs to the drivers/pci/pci.ids file.

I've also submitted a (different) patch to pci-ids@ucw.cz 

I noticed that the kernel 2.5.68 pci.ids file is significantly
out of date with the latest at pciids.sourceforge.net
so I generated this patch for the current kernel.

Is this the correct thing to do, or should I just wait for
the pciids.sourceforge.net copy to eventually trickle
into the latest kernel source?

--- linux-2.5.68/drivers/pci/pci.ids	2003-04-07 12:31:24.000000000 -0500
+++ linux-2.5.68-mg/drivers/pci/pci.ids	2003-05-01 15:41:38.000000000 -0500
@@ -4815,7 +4815,10 @@
 13be  Miroku Jyoho Service Co. Ltd
 13bf  Sharewave Inc
 13c0  Microgate Corporation
-	0010  SyncLink WAN Adapter
+	0010  SyncLink Adapter v1
+	0020  SyncLink SCC Adapter
+	0030  SyncLink Multiport Adapter
+	0210  SyncLink Adapter v2
 13c1  3ware Inc
 	1000  3ware ATA-RAID
 	1001  3ware 7000-series ATA-RAID


-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


