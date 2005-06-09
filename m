Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVFIQnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVFIQnw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 12:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVFIQnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 12:43:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:4789 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261533AbVFIQnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 12:43:50 -0400
Date: Thu, 9 Jun 2005 09:43:45 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB bugfixes and a PCI one too for 2.6.12-rc6
Message-ID: <20050609164345.GA9538@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some two USB patches and one PCI Hotplug patch for the
2.6.12-rc6 tree.  They are all bugfixes.  I've put them all in one repo
to make it easier for you to pull from :)

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

Full patches will be sent to the linux-usb-devel and linux-kernel
mailing lists, if anyone wants to see them.

thanks,

greg k-h

 drivers/block/ub.c                      |   10 -
 drivers/pci/hotplug/cpci_hotplug_core.c |    4 
 drivers/pci/hotplug/cpci_hotplug_pci.c  |   10 +
 drivers/usb/serial/ftdi_sio.c           |  236 ++++++++++++++++++++++++--------
 4 files changed, 198 insertions(+), 62 deletions(-)
-------------

Ian Abbott:
  USB: ftdi_sio: avoid losing received data in tty-ldisc

Pete Zaitcev:
  USB: fix ub issues

Scott Murray:
  PCI Hotplug: fix CPCI reference counting bug


