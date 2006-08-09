Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWHITZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWHITZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 15:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWHITZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 15:25:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62175 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750854AbWHITZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 15:25:26 -0400
Date: Wed, 9 Aug 2006 15:25:09 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: greg@kroah.com
Subject: remove dead HOTPLUG_PCI_SHPC_PHPRM_LEGACY option.
Message-ID: <20060809192509.GK10930@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing in the tree references this config option.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.17.noarch/drivers/pci/hotplug/Kconfig~	2006-08-09 15:23:16.000000000 -0400
+++ linux-2.6.17.noarch/drivers/pci/hotplug/Kconfig	2006-08-09 15:24:23.000000000 -0400
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

-- 
http://www.codemonkey.org.uk
