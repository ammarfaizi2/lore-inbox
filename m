Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314393AbSEIVmP>; Thu, 9 May 2002 17:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314394AbSEIVmP>; Thu, 9 May 2002 17:42:15 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:31241 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S314393AbSEIVmN>;
	Thu, 9 May 2002 17:42:13 -0400
Date: Thu, 9 May 2002 13:42:06 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI Hotplug changes for 2.5.14
Message-ID: <20020509204205.GA18958@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pull from:  bk://linuxusb.bkbits.net/pci_hp-2.5


 drivers/hotplug/ibmphp.h           |   18 ++-
 drivers/hotplug/ibmphp_core.c      |  208 ++++++++++++++++++++++++++++---------
 drivers/hotplug/ibmphp_ebda.c      |   65 +++++++----
 drivers/hotplug/ibmphp_hpc.c       |   29 +----
 drivers/hotplug/pci_hotplug_core.c |    8 -
 5 files changed, 226 insertions(+), 102 deletions(-)
------

ChangeSet@1.558, 2002-05-09 13:44:44-07:00, greg@kroah.com
  PCI Hotplug core
  
  removed pcihpfs_statfs(), as it's not used anymore.

 drivers/hotplug/pci_hotplug_core.c |    8 --------
 1 files changed, 8 deletions(-)
------

ChangeSet@1.557, 2002-05-09 13:15:51-07:00, greg@kroah.com
  IBM PCI Hotplug driver
  
  update the ibm pci hotplug driver to the latest version.  Contains lots of
  small bugfixes and added features for new hardware.

 drivers/hotplug/ibmphp.h      |   18 ++-
 drivers/hotplug/ibmphp_core.c |  208 ++++++++++++++++++++++++++++++++----------
 drivers/hotplug/ibmphp_ebda.c |   65 ++++++++-----
 drivers/hotplug/ibmphp_hpc.c  |   29 ++---
 4 files changed, 226 insertions(+), 94 deletions(-)
------

