Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWDFLJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWDFLJD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 07:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWDFLJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 07:09:03 -0400
Received: from sorrow.cyrius.com ([65.19.161.204]:16147 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751039AbWDFLJC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 07:09:02 -0400
Date: Thu, 6 Apr 2006 13:08:51 +0200
From: Martin Michlmayr <tbm@cyrius.com>
To: Tim Waugh <twaugh@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] parport: remove duplicate entry for NETMOS_9835
Message-ID: <20060406110851.GA13756@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060330
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a duplicated entry from parport_serial_pci_tbl.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index d121644..98b83a8 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -100,8 +100,6 @@ static struct pci_device_id parport_seri
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9xx5_combo },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9xx5_combo },
-	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9xx5_combo },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9845,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9xx5_combo },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9855,

-- 
Martin Michlmayr
http://www.cyrius.com/
