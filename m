Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUCDNmc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 08:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUCDNlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 08:41:35 -0500
Received: from mail.math.uni-mannheim.de ([134.155.89.179]:14286 "EHLO
	mail.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261902AbUCDNk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 08:40:58 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix typo in drivers/scsi/sata_svw.c
Date: Thu, 4 Mar 2004 09:20:22 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403040920.22925.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a missing ')'.

--- linux-2.6.0-test10-eike/drivers/scsi/sata_svw.c	2003-11-26 15:25:07.000000000 +0100
+++ linux-2.6.0-test10/drivers/scsi/sata_svw.c	2003-11-26 15:30:22.000000000 +0100
@@ -317,7 +317,7 @@
 
 	/* Clear a magic bit in SCR1 according to Darwin, those help
 	 * some funky seagate drives (though so far, those were already
-	 * set by the firmware on the machines I had access to
+	 * set by the firmware on the machines I had access to)
 	 */
 	writel(readl(mmio_base + 0x80) & ~0x00040000, mmio_base + 0x80);
 
