Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbUKSWAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbUKSWAK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbUKSV7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:59:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:64406 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261606AbUKSV4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:56:43 -0500
Date: Fri, 19 Nov 2004 13:56:18 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI fixes for 2.6.10-rc2
Message-ID: <20041119215618.GA15863@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some small PCI and PCI hotplug fixes for 2.6.10-rc2.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 drivers/pci/hotplug/pciehp_sysfs.c   |  143 -----------------------------------
 Documentation/pci.txt                |    8 -
 drivers/pci/hotplug/Makefile         |    1 
 drivers/pci/hotplug/cpcihp_generic.c |    2 
 drivers/pci/hotplug/pciehp.h         |    3 
 drivers/pci/hotplug/rpaphp_pci.c     |    9 --
 6 files changed, 8 insertions(+), 158 deletions(-)
-----

Adrian Bunk:
  o PCI Hotplug: remove unused drivers/pci/hotplug/pciehp_sysfs.c

Randy Dunlap:
  o PCI Hotplug: cpcihp_generic: fix module_param data type

Rolf Eike Beer:
  o PCI: fix Documentation/pci.txt inconsistency
  o PCI Hotplug: clean up rpaphp_pci.c::rpaphp_find_pci_dev

