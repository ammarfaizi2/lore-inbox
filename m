Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267639AbTAHBqh>; Tue, 7 Jan 2003 20:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267640AbTAHBqh>; Tue, 7 Jan 2003 20:46:37 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:17417 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267639AbTAHBqg>;
	Tue, 7 Jan 2003 20:46:36 -0500
Date: Tue, 7 Jan 2003 17:55:01 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI hotplug changes for 2.5.54
Message-ID: <20030108015500.GA30924@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some minor PCI hotplug changes for 2.5.54.

Please pull from:  bk://linuxusb.bkbits.net/pci_hp-2.5

thanks,

greg k-h


 drivers/hotplug/ibmphp_core.c      |   10 ++++-----
 drivers/hotplug/pci_hotplug_core.c |   41 ++++++++++++++++++-------------------
 drivers/pci/hotplug.c              |    2 -
 3 files changed, 26 insertions(+), 27 deletions(-)
-----

ChangeSet@1.896, 2003-01-07 16:41:22-08:00, greg@kroah.com
  PCI hotplug: clean up the try_module_get() logic a bit.

 drivers/hotplug/pci_hotplug_core.c |   41 ++++++++++++++++++-------------------
 1 files changed, 20 insertions(+), 21 deletions(-)
------

ChangeSet@1.895, 2003-01-07 16:29:23-08:00, greg@kroah.com
  PCI: properly unregister a PCI device if it is removed.
  
  This is only used by pci hotplug and cardbus systems.

 drivers/pci/hotplug.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.894, 2003-01-07 16:24:14-08:00, greg@kroah.com
  IBM PCI Hotplug: fix compile time error due to find_bus() function name.

 drivers/hotplug/ibmphp_core.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)
------

