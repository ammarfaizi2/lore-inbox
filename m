Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbTANWKC>; Tue, 14 Jan 2003 17:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265400AbTANWKB>; Tue, 14 Jan 2003 17:10:01 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:17673 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265396AbTANWKB>;
	Tue, 14 Jan 2003 17:10:01 -0500
Date: Tue, 14 Jan 2003 14:18:40 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI hotplug changes for 2.5.58
Message-ID: <20030114221839.GC17226@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a minor PCI hotplug fix for 2.5.58

Please pull from:  bk://linuxusb.bkbits.net/pci_hp-2.5

thanks,

greg k-h


 drivers/hotplug/acpiphp_glue.c |   45 ++++++++++-------------------------------
 1 files changed, 11 insertions(+), 34 deletions(-)
-----

ChangeSet@1.1025, 2003-01-14 11:30:32-08:00, willy@debian.org
  [PATCH] acpi_bus_register_driver patch
  
  The current ACPI code searches for a _HID of PNP0A03.  This is wrong,
  it needs to check _CID too.  But we already have generic code for doing
  that, so this patch converts the ACPI pcihp code to do this.

 drivers/hotplug/acpiphp_glue.c |   45 ++++++++++-------------------------------
 1 files changed, 11 insertions(+), 34 deletions(-)
------

