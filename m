Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262950AbVDBANJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262950AbVDBANJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbVDBALO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:11:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:40412 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262951AbVDAXsS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:18 -0500
Cc: jason.d.gaston@intel.com
Subject: [PATCH] pci_ids.h correction for Intel ICH7M
In-Reply-To: <11123992723300@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:52 -0800
Message-Id: <1112399272178@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.14, 2005/03/17 14:32:07-08:00, jason.d.gaston@intel.com

[PATCH] pci_ids.h correction for Intel ICH7M

This patch corrects the ICH7M LPC controller DID in pci_ids.h from x27B1
to x27B9.


Signed-off-by: Jason Gaston <Jason.d.gaston@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 include/linux/pci_ids.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2005-04-01 15:35:30 -08:00
+++ b/include/linux/pci_ids.h	2005-04-01 15:35:30 -08:00
@@ -2383,7 +2383,7 @@
 #define PCI_DEVICE_ID_INTEL_ICH6_18	0x266e
 #define PCI_DEVICE_ID_INTEL_ICH6_19	0x266f
 #define PCI_DEVICE_ID_INTEL_ICH7_0	0x27b8
-#define PCI_DEVICE_ID_INTEL_ICH7_1	0x27b1
+#define PCI_DEVICE_ID_INTEL_ICH7_1	0x27b9
 #define PCI_DEVICE_ID_INTEL_ICH7_2	0x27c0
 #define PCI_DEVICE_ID_INTEL_ICH7_3	0x27c1
 #define PCI_DEVICE_ID_INTEL_ICH7_4	0x27c2

