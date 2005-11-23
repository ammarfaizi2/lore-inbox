Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030527AbVKWXrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030527AbVKWXrW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVKWXqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:46:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:21954 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751326AbVKWXqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:30 -0500
Date: Wed, 23 Nov 2005 15:45:04 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       rdunlap@xenotime.net
Subject: [patch 12/22] PCI: kernel-doc fix for pci-acpi.c
Message-ID: <20051123234504.GM527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pci-kernel-doc-fix-for-pci-acpi.c.patch"
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix kernel-doc warning in pci/pci-acpi.c.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/pci/pci-acpi.c |    1 +
 1 file changed, 1 insertion(+)

--- usb-2.6.orig/drivers/pci/pci-acpi.c
+++ usb-2.6/drivers/pci/pci-acpi.c
@@ -178,6 +178,7 @@ EXPORT_SYMBOL(pci_osc_support_set);
 
 /**
  * pci_osc_control_set - commit requested control to Firmware
+ * @handle: acpi_handle for the target ACPI object
  * @flags: driver's requested control bits
  *
  * Attempt to take control from Firmware on requested control bits.

--
