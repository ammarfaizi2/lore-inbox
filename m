Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318614AbSHUSZI>; Wed, 21 Aug 2002 14:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318602AbSHUSZI>; Wed, 21 Aug 2002 14:25:08 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:46596 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318614AbSHUSZH>;
	Wed, 21 Aug 2002 14:25:07 -0400
Date: Wed, 21 Aug 2002 11:23:46 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI Hotplug changes for 2.4.20-pre4
Message-ID: <20020821182346.GA1553@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This includes a fix for the oops people are having when they access
pcihpfs and a Configure.help update for the ACPI PCI Hotplug driver.

	Pull from:  bk://linuxusb.bkbits.net/pci_hp-2.4

Patches will follow.

thanks,

greg k-h

 Documentation/Configure.help       |   10 ++++++++++
 drivers/hotplug/pci_hotplug_core.c |    8 +-------
 2 files changed, 11 insertions(+), 7 deletions(-)
-----

ChangeSet@1.589, 2002-08-20 17:23:01-07:00, greg@kroah.com
  PCI Hotplug: fixed oops when accessing pcihpfs.

 drivers/hotplug/pci_hotplug_core.c |    8 +-------
 1 files changed, 1 insertion(+), 7 deletions(-)
------

ChangeSet@1.588, 2002-08-20 17:22:04-07:00, greg@kroah.com
  added Configure.help entry for the ACPI PCI Hotplug driver.

 Documentation/Configure.help |   10 ++++++++++
 1 files changed, 10 insertions(+)
------

