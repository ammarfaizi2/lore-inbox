Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423458AbWJaO4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423458AbWJaO4q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 09:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423461AbWJaO4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 09:56:46 -0500
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:47749 "EHLO
	outbound1-blu-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1423458AbWJaO4o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 09:56:44 -0500
X-BigFish: V
Content-class: urn:content-classes:message
Subject: PCI CLASS: SATA should be added
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Date: Tue, 31 Oct 2006 22:56:16 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <FFECF24D2A7F6D418B9511AF6F358602F2CE97@shacnexch2.atitech.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI CLASS: SATA should be added
Thread-Index: Acb8/LdmtHTgfao/S9+lCQTW87fguQ==
From: "Conke Hu" <conke.hu@amd.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 31 Oct 2006 14:56:21.0783 (UTC) FILETIME=[BA845270:01C6FCFC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, 
	The PCI class code of SATA controller is 0x0106, and it should
be added to pci_ids.h.

[PATCH]
diff -Nur linux-2.6.17/include/linux/pci_ids.h
linux-2.6.17-sata-id/include/linux/pci_ids.h
--- linux-2.6.17/include/linux/pci_ids.h	2006-06-18
09:49:35.000000000 +0800
+++ linux-2.6.17-sata-id/include/linux/pci_ids.h	2006-10-31
22:42:48.000000000 +0800
@@ -15,6 +15,7 @@
 #define PCI_CLASS_STORAGE_FLOPPY	0x0102
 #define PCI_CLASS_STORAGE_IPI		0x0103
 #define PCI_CLASS_STORAGE_RAID		0x0104
+#define PCI_CLASS_STORAGE_SATA		0x0106
 #define PCI_CLASS_STORAGE_SAS		0x0107
 #define PCI_CLASS_STORAGE_OTHER		0x018



Best regards,
Conke @ AMD, Inc.




