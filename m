Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272245AbRILWua>; Wed, 12 Sep 2001 18:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272322AbRILWuU>; Wed, 12 Sep 2001 18:50:20 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:5643 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S272245AbRILWuL>;
	Wed, 12 Sep 2001 18:50:11 -0400
Date: Wed, 12 Sep 2001 15:48:38 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Hotplug PCI driver for 2.4.10-pre8
Message-ID: <20010912154838.A14658@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Another release of the Compaq Hotplug PCI driver is available at:
	http://www.kroah.com/linux/hotplug/pci-hotplug-2001_09_12-2.4.10-pre8.patch.gz

This is a _unstable_ release, you have been warned :)

Changes since the last release:
	- forward ported to 2.4.10-pre8
	- first cut at moving the driver into two separate pieces.

I'm actively working on splitting the driver up into a "generic" hotplug
pci controller code, and a Compaq specific hotplug pci driver.  Right
now only the character driver piece has been split out.  Because of
the changes that were done to the ioctl interface, the existing
userspace tools will not work.  A version of the GTK+ tool that works
with this patch can be found in the cvs tree at sourceforge:
	http://sourceforge.net/cvs/?group_id=32538

Any comments on the current interface from groups that are working with
other hotplug pci controllers is very welcome.

thanks,

greg k-h
