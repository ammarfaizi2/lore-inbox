Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWFWDNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWFWDNs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 23:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWFWDNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 23:13:48 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:42118 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751125AbWFWDNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 23:13:47 -0400
Message-ID: <449B5C6A.8050908@garzik.org>
Date: Thu, 22 Jun 2006 23:13:46 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Chew <achew@nvidia.com>
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] Add MCP65 support for sata_nv driver
References: <1150961925.5109.6.camel@achew-linux> <449B5AF2.9090104@garzik.org>
In-Reply-To: <449B5AF2.9090104@garzik.org>
Content-Type: multipart/mixed;
 boundary="------------000706030403060506000205"
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000706030403060506000205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I just committed the abbreviated version of the sata_nv patch (see 
attached)...  that will get things going at least.

	Jeff




--------------000706030403060506000205
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

c57c064994f1544a5ed2e9b319ebd0bc087ea540
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index be8650f..d18e7e0 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -135,6 +135,10 @@ static const struct pci_device_id nv_pci
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, 0x045c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, 0x045d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, 0x045e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, 0x045f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },

--------------000706030403060506000205--
