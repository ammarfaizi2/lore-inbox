Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274961AbTHAToN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 15:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270927AbTHATiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 15:38:46 -0400
Received: from mail.kroah.org ([65.200.24.183]:9151 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270861AbTHATc2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 15:32:28 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1059766327227@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test2
In-Reply-To: <10597663273174@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Aug 2003 12:32:07 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1547.13.3, 2003/08/01 10:13:46-07:00, mitch@sfgoth.com

[PATCH] PCI: add 2 entries to pci_ids.h

These have been in the pci.ids file for awhile but not in <linux/pci_ids.h>
They're used by my drivers/atm/lanai.c driver that has been in tree for
some time now (it provides its own copy of these #define's protected by
an #ifndef - I'll remove that once this patch goes into the mainline)


 include/linux/pci_ids.h |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Fri Aug  1 12:17:29 2003
+++ b/include/linux/pci_ids.h	Fri Aug  1 12:17:29 2003
@@ -1205,6 +1205,8 @@
 #define PCI_VENDOR_ID_EF		0x111a
 #define PCI_DEVICE_ID_EF_ATM_FPGA	0x0000
 #define PCI_DEVICE_ID_EF_ATM_ASIC	0x0002
+#define PCI_VENDOR_ID_EF_ATM_LANAI2	0x0003
+#define PCI_VENDOR_ID_EF_ATM_LANAIHB	0x0005
 
 #define PCI_VENDOR_ID_IDT		0x111d
 #define PCI_DEVICE_ID_IDT_IDT77201	0x0001

