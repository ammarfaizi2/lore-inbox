Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263718AbUE1WEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbUE1WEm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbUE1Vke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:40:34 -0400
Received: from mail.kroah.org ([65.200.24.183]:35507 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263898AbUE1ViE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:38:04 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.7-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <10857801154003@kroah.com>
Date: Fri, 28 May 2004 14:35:16 -0700
Message-Id: <1085780116326@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1758, 2004/05/28 13:36:07-07:00, trimmer@infiniconsys.com

[PATCH] PCI: Add InfiniCon PCI ID to pci_ids.h

We would like to have the InfiniCon PCI Vendor ID added to pci_ids.h
Below is a context diff, which would would greatly appreciate if you
applied and included in future kernel releases.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/pci_ids.h |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Fri May 28 14:28:59 2004
+++ b/include/linux/pci_ids.h	Fri May 28 14:28:59 2004
@@ -1910,6 +1910,8 @@
 #define	PCI_DEVICE_ID_S2IO_WIN		0x5731
 #define	PCI_DEVICE_ID_S2IO_UNI		0x5831
 
+#define PCI_VENDOR_ID_INFINICON		0x1820
+
 #define PCI_VENDOR_ID_TOPSPIN		0x1867
 
 #define PCI_VENDOR_ID_ARC               0x192E

