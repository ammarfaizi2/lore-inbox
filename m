Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265801AbUFXWkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265801AbUFXWkb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbUFXWd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:33:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:36790 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265777AbUFXVrY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:47:24 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.7
User-Agent: Mutt/1.5.6i
In-Reply-To: <10881135682230@kroah.com>
Date: Thu, 24 Jun 2004 14:46:08 -0700
Message-Id: <1088113568457@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1823.1.8, 2004/06/22 16:57:48-07:00, shemminger@osdl.org

[PATCH] PCI: remove duplicate in pci_ids.h

Get rid of duplicate entry, one is in the middle of the file with duplicate
at the end

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/pci_ids.h |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2004-06-24 13:50:01 -07:00
+++ b/include/linux/pci_ids.h	2004-06-24 13:50:01 -07:00
@@ -2272,6 +2272,3 @@
 #define PCI_DEVICE_ID_MICROGATE_SCC	0x0020
 #define PCI_DEVICE_ID_MICROGATE_SCA	0x0030
 #define PCI_DEVICE_ID_MICROGATE_USC2	0x0210
-
-#define PCI_VENDOR_ID_HINT		0x3388
-#define PCI_DEVICE_ID_HINT_VXPROII_IDE	0x8013

