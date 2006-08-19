Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422715AbWHSCD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422715AbWHSCD2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 22:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422712AbWHSCD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 22:03:28 -0400
Received: from mail0.lsil.com ([147.145.40.20]:45445 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751477AbWHSCD0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 22:03:26 -0400
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC][PATCH 39/75] scsi: drivers/scsi/megaraid/megaraid_sas.c pci_module_init to pci_register_driver conversion
Date: Fri, 18 Aug 2006 20:03:26 -0600
Message-ID: <0631C836DBF79F42B5A60C8C8D4E8229674EA3@NAMAIL2.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH 39/75] scsi: drivers/scsi/megaraid/megaraid_sas.c pci_module_init to pci_register_driver conversion
Thread-Index: AcbCBGfXeqQrC36WQ9iX4wkr1W8Z5wBLq1iQ
From: "Patro, Sumant" <Sumant.Patro@lsil.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       "Bagalkote, Sreenivas" <Sreenivas.Bagalkote@engenio.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 19 Aug 2006 02:03:24.0795 (UTC) FILETIME=[A785CCB0:01C6C333]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ack.

Thank you.

--Sumant

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Michal
Piotrowski
Sent: Thursday, August 17, 2006 6:28 AM
To: Bagalkote, Sreenivas
Cc: linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org
Subject: [RFC][PATCH 39/75] scsi: drivers/scsi/megaraid/megaraid_sas.c
pci_module_init to pci_register_driver conversion


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff
linux-work-clean/drivers/scsi/megaraid/megaraid_sas.c
linux-work2/drivers/scsi/megaraid/megaraid_sas.c
--- linux-work-clean/drivers/scsi/megaraid/megaraid_sas.c
2006-08-16 22:41:01.000000000 +0200
+++ linux-work2/drivers/scsi/megaraid/megaraid_sas.c	2006-08-17
05:21:09.000000000 +0200
@@ -2854,7 +2854,7 @@ static int __init megasas_init(void)
 	/*
 	 * Register ourselves as PCI hotplug module
 	 */
-	rval = pci_module_init(&megasas_pci_driver);
+	rval = pci_register_driver(&megasas_pci_driver);
 
 	if (rval) {
 		printk(KERN_DEBUG "megasas: PCI hotplug regisration
failed \n");
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
