Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbVLAXvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbVLAXvR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 18:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVLAXvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 18:51:17 -0500
Received: from mail0.lsil.com ([147.145.40.20]:52719 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932091AbVLAXvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 18:51:17 -0500
Message-ID: <91888D455306F94EBD4D168954A9457C051F36BF@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] pci_ids.h - adding subclass code for SAS Controllers
Date: Thu, 1 Dec 2005 16:51:02 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C5F6D2.15D07D60"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C5F6D2.15D07D60
Content-Type: text/plain

Adding new subclass code for SAS controllers.

Signed-off-by: Eric Moore <Eric.Moore@lsil.com>


------_=_NextPart_000_01C5F6D2.15D07D60
Content-Type: application/octet-stream;
	name="pci_class_sas.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pci_class_sas.patch"

--- b/include/linux/pci_ids.h	2005-12-01 09:20:26.000000000 -0700=0A=
+++ a/include/linux/pci_ids.h	2005-12-01 16:41:15.673729728 -0700=0A=
@@ -15,6 +15,7 @@=0A=
 #define PCI_CLASS_STORAGE_FLOPPY	0x0102=0A=
 #define PCI_CLASS_STORAGE_IPI		0x0103=0A=
 #define PCI_CLASS_STORAGE_RAID		0x0104=0A=
+#define PCI_CLASS_STORAGE_SAS		0x0107=0A=
 #define PCI_CLASS_STORAGE_OTHER		0x0180=0A=
 =0A=
 #define PCI_BASE_CLASS_NETWORK		0x02=0A=

------_=_NextPart_000_01C5F6D2.15D07D60--
