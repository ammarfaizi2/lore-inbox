Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317494AbSGXTGY>; Wed, 24 Jul 2002 15:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317497AbSGXTGY>; Wed, 24 Jul 2002 15:06:24 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:27655 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317494AbSGXTGX>;
	Wed, 24 Jul 2002 15:06:23 -0400
Date: Wed, 24 Jul 2002 12:09:22 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI Hotplug changes for 2.5.27
Message-ID: <20020724190922.GA11015@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pull from:  bk://linuxusb.bkbits.net/pci_hp-2.5


 drivers/hotplug/cpqphp_core.c      |   36 ++++++++---------
 drivers/hotplug/cpqphp_pci.c       |    8 +--
 drivers/hotplug/ibmphp_core.c      |   32 +++++++--------
 drivers/hotplug/pci_hotplug_core.c |    3 +
 drivers/hotplug/pci_hotplug_util.c |    2 
 drivers/hotplug/pcihp_skeleton.c   |   18 ++++----
 drivers/hotplug/pci_hotplug_core.c |   74 +++++++++++++++++------------------
 7 files changed, 88 insertions(+), 85 deletions(-)
------

ChangeSet@1.403.159.2, 2002-07-24 10:31:53-07:00, rusty@rustcorp.com.au
  [PATCH] drivers/hotplug designated initializers
  
   The old form of designated initializers are obsolete: we need to
   replace them with the ISO C forms before 2.6.  Gcc has always supported
   both forms anyway.

 drivers/hotplug/cpqphp_core.c      |   36 +++++++++---------
 drivers/hotplug/cpqphp_pci.c       |    8 ++--
 drivers/hotplug/ibmphp_core.c      |   32 ++++++++--------
 drivers/hotplug/pci_hotplug_core.c |   72 ++++++++++++++++++-------------------
 drivers/hotplug/pcihp_skeleton.c   |   18 ++++-----
 5 files changed, 83 insertions(+), 83 deletions(-)
------

ChangeSet@1.403.129.7, 2002-07-07 11:32:52-07:00, greg@kroah.com
  PCI Hotplug: fix the dbg() macro to work properly on older versions of gcc

 drivers/hotplug/pci_hotplug_core.c |    2 +-
 drivers/hotplug/pci_hotplug_util.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.403.129.6, 2002-07-07 11:28:15-07:00, greg@kroah.com
  PCI Hotplug: fix i_nlink for root inode in pcihpfs

 drivers/hotplug/pci_hotplug_core.c |    3 +++
 1 files changed, 3 insertions(+)
------

