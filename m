Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWKMWYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWKMWYd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 17:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbWKMWYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 17:24:33 -0500
Received: from dxa01.wellsfargo.com ([151.151.65.117]:31183 "EHLO
	dxa01.wellsfargo.com") by vger.kernel.org with ESMTP
	id S932479AbWKMWYc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 17:24:32 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: [PATCH 1/1] drivers/block/Kconfig text update.
Date: Mon, 13 Nov 2006 16:24:22 -0600
Message-ID: <E8C008223DD5F64485DFBDF6D4B7F71D022358D6@msgswbmnmsp25.wellsfargo.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] drivers/block/Kconfig text update.
Thread-Index: AccHcnLbcyYv4+eRS9ma0spAOF+Ppg==
From: <Greg.Chandler@wellsfargo.com>
To: <linux-kernel@vger.kernel.org>
Cc: <torvalds@osdl.org>
X-OriginalArrivalTime: 13 Nov 2006 22:24:22.0715 (UTC) FILETIME=[782BC8B0:01C70772]
X-WFMX: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The second line of the drivers/block/cciss.c file says:

" *    Disk Array driver for HP SA 5xxx and 6xxx Controllers"

I couldn't find the 6 series anywhere in the menu, and I ended up
finding it in the code...





--- drivers/block/Kconfig.old   2006-11-13 14:20:12.000000000 -0800
+++ drivers/block/Kconfig       2006-11-13 14:20:32.000000000 -0800
@@ -155,10 +155,10 @@
          this driver.

 config BLK_CPQ_CISS_DA
-       tristate "Compaq Smart Array 5xxx support"
+       tristate "Compaq Smart Array 5xxx/6xxx support"
        depends on PCI
        help
-         This is the driver for Compaq Smart Array 5xxx controllers.
+         This is the driver for Compaq Smart Array 5xxx/6xxx
controllers.
          Everyone using these boards should say Y here.
          See <file:Documentation/cciss.txt> for the current list of
          boards supported by this driver, and for further information
