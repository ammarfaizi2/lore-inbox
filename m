Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278687AbRJSWZU>; Fri, 19 Oct 2001 18:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278688AbRJSWZL>; Fri, 19 Oct 2001 18:25:11 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:56073 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S278685AbRJSWY5>;
	Fri, 19 Oct 2001 18:24:57 -0400
Date: Fri, 19 Oct 2001 15:16:05 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Hotplug PCI driver for 2.4.13-pre5
Message-ID: <20011019151605.A1093@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Another release of the PCI Hotplug core and the Compaq PCI Hotplug
driver for 2.4.13-pre5 is at:
 	http://www.kroah.com/linux/hotplug/pci-hotplug-2001_10_19-2.4.13-pre5.patch.gz
With a full changelog at:
 	http://www.kroah.com/linux/hotplug/pci-hotplug-Changelog

modutils >= 2.4.10 is required to use this version of the driver.

Changes since the last release:
 	- forward ported to 2.4.13-pre5
	- no longer needs ddfs.  The PCI Hotplug core is now the pcihpfs
	  filesystem.
	- some source code renames to the Compaq driver.
	- added spinlock to protect the list of hotplug slots.

TODO:
 	- Port the Linux PPC hotplug pci controller driver to the
	  hotplug pci core interface, whenever Anton sends me an
	  updated file...

thanks,

greg k-h
