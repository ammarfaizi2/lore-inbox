Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262955AbVAQWn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbVAQWn0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbVAQWWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:22:32 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:43493 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262932AbVAQWCM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:02:12 -0500
Cc: jason.d.gaston@intel.com
Subject: [PATCH] PCI: pci_ids.h correction for Intel ICH7 - 2.6.10-bk13
In-Reply-To: <1105999312534@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 17 Jan 2005 14:01:52 -0800
Message-Id: <11059993122424@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2329.2.3, 2005/01/14 15:57:26-08:00, jason.d.gaston@intel.com

[PATCH] PCI: pci_ids.h correction for Intel ICH7 - 2.6.10-bk13

This patch corrects the ICH7 LPC controller DID in pci_ids.h from x27B0
to x27B8.  This patch was build against 2.6.10-bk13.

Signed-off-by: Jason Gaston <Jason.d.gaston@intel.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/pci_ids.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2005-01-17 13:56:18 -08:00
+++ b/include/linux/pci_ids.h	2005-01-17 13:56:18 -08:00
@@ -2244,7 +2244,7 @@
 #define PCI_DEVICE_ID_INTEL_ICH6_17	0x266d
 #define PCI_DEVICE_ID_INTEL_ICH6_18	0x266e
 #define PCI_DEVICE_ID_INTEL_ICH6_19	0x266f
-#define PCI_DEVICE_ID_INTEL_ICH7_0	0x27b0
+#define PCI_DEVICE_ID_INTEL_ICH7_0	0x27b8
 #define PCI_DEVICE_ID_INTEL_ICH7_1	0x27b1
 #define PCI_DEVICE_ID_INTEL_ICH7_2	0x27c0
 #define PCI_DEVICE_ID_INTEL_ICH7_3	0x27c1

