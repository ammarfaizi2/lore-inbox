Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265146AbUAHRTZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 12:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265371AbUAHRTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 12:19:25 -0500
Received: from lightning.hereintown.net ([141.157.132.3]:57812 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S265146AbUAHRTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 12:19:22 -0500
Subject: [PATCH] LSI Logic MegaRAID3 PCI ID [Was: MegaRAID on AMD64 under
	2.6.1]
From: Chris Meadors <clubneon@hereintown.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20040108165545.A12313@infradead.org>
References: <1073512887.8211.39.camel@clubneon.priv.hereintown.net>
	 <20040108121227.B8987@infradead.org>
	 <1073580718.8870.45.camel@clubneon.priv.hereintown.net>
	 <20040108165545.A12313@infradead.org>
Content-Type: multipart/mixed; boundary="=-4RzaEXckK3sLhgm6+l13"
Message-Id: <1073582360.8870.65.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 08 Jan 2004 12:19:21 -0500
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1AedoX-0004pS-Cp*oOAqIqmGfME*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4RzaEXckK3sLhgm6+l13
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-01-08 at 11:55, Christoph Hellwig wrote:
> On Thu, Jan 08, 2004 at 11:51:58AM -0500, Chris Meadors wrote:
> > i.e. PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_AMI_MEGARAID3
> > 
> > When I added the lines for that combination to megaraid_pci_tbl[], the
> > driver found the card.  So, I'm cool now.
> 
> Care to send a patch to Linus to add it?  And my apologies for losing
> that entry. 

Sure thing, it is attatched, as I fear the white space mangling
abilities of my MUA.

-- 
Chris

--=-4RzaEXckK3sLhgm6+l13
Content-Disposition: attachment; filename=LSI_MEGARAID3.patch
Content-Type: text/x-patch; name=LSI_MEGARAID3.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.6.1-rc2.orig/drivers/scsi/megaraid.c	2004-01-08 12:14:51.000000000 -0500
+++ linux-2.6.1-rc2/drivers/scsi/megaraid.c	2004-01-08 12:01:24.000000000 -0500
@@ -5095,6 +5095,8 @@
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_AMI_MEGARAID,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_AMI_MEGARAID3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, megaraid_pci_tbl);

--=-4RzaEXckK3sLhgm6+l13--

