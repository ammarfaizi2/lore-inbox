Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265000AbUGBVmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265000AbUGBVmS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 17:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUGBVlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 17:41:08 -0400
Received: from mail.kroah.org ([65.200.24.183]:33426 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265000AbUGBVkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 17:40:36 -0400
Date: Fri, 2 Jul 2004 14:38:16 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] More PCI fixes for 2.6.7
Message-ID: <20040702213816.GA31384@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more small PCI patches for 2.6.7.  They have some more pci
id fixes, pci express #defines for drivers to use, and some more ppc64
pci hotplug driver bugfixes.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 drivers/pci/hotplug/rpaphp.h     |    4 +--
 drivers/pci/hotplug/rpaphp_pci.c |   15 ++++++++++---
 drivers/pci/pci.ids              |    1 
 drivers/pci/probe.c              |    5 ++--
 include/linux/pci.h              |   45 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h          |    3 ++
 6 files changed, 66 insertions(+), 7 deletions(-)
-----

<buytenh:wantstofly.org>:
  o PCI: New PCI vendor/device ID for Radisys ENP-2611 board

Linas Vepstas:
  o PCI Hotplug: RPAPHP structure size/performance
  o PCI Hotplug: rpaphp null pointer deref

Linda Xie:
  o PCI: export pci_scan_child_bus for the pci hotplug drivers to use

Roland Dreier:
  o PCI: Add some PCI Express constants to pci.h

