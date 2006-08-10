Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161032AbWHJFXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbWHJFXL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 01:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbWHJFXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 01:23:11 -0400
Received: from mail.suse.de ([195.135.220.2]:47576 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161032AbWHJFXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 01:23:10 -0400
Subject: patch pci-remove-dead-hotplug_pci_shpc_phprm_legacy-option.patch added to gregkh-2.6 tree
To: davej@redhat.com, gregkh@suse.de, linux-kernel@vger.kernel.org
From: <gregkh@suse.de>
Date: Wed, 09 Aug 2006 22:22:56 -0700
In-Reply-To: <20060809192509.GK10930@redhat.com>
Message-Id: <20060810052308.1F5508320E0@imap.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: PCI: remove dead HOTPLUG_PCI_SHPC_PHPRM_LEGACY option.

to my gregkh-2.6 tree.  Its filename is

     pci-remove-dead-hotplug_pci_shpc_phprm_legacy-option.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From davej@redhat.com Wed Aug  9 12:25:29 2006
Date: Wed, 9 Aug 2006 15:25:09 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: greg@kroah.com
Subject: PCI: remove dead HOTPLUG_PCI_SHPC_PHPRM_LEGACY option.
Message-ID: <20060809192509.GK10930@redhat.com>
Content-Disposition: inline

Nothing in the tree references this config option.

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/hotplug/Kconfig |    7 -------
 1 file changed, 7 deletions(-)

--- gregkh-2.6.orig/drivers/pci/hotplug/Kconfig
+++ gregkh-2.6/drivers/pci/hotplug/Kconfig
@@ -153,13 +153,6 @@ config HOTPLUG_PCI_SHPC_POLL_EVENT_MODE
 
 	  When in doubt, say N.
 
-config HOTPLUG_PCI_SHPC_PHPRM_LEGACY
-	bool "For AMD SHPC only: Use $HRT for resource/configuration"
-	depends on HOTPLUG_PCI_SHPC && !ACPI 
-	help
-	  Say Y here for AMD SHPC. You have to select this option if you are 
-	  using this driver on platform with AMD SHPC.
-
 config HOTPLUG_PCI_RPA
 	tristate "RPA PCI Hotplug driver"
 	depends on HOTPLUG_PCI && PPC_PSERIES && PPC64 && !HOTPLUG_PCI_FAKE


Patches currently in gregkh-2.6 which might be from davej@redhat.com are

pci/pci-remove-dead-hotplug_pci_shpc_phprm_legacy-option.patch
