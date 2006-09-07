Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWIGW1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWIGW1R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 18:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWIGW1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 18:27:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:42644 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932129AbWIGW1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 18:27:16 -0400
Date: Thu, 7 Sep 2006 15:27:06 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB fixes for 2.6.18-rc6
Message-ID: <20060907222706.GA8886@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a some fixes for USB against 2.6.18-rc6.  They do the
following:
	- build warning fix in the usbhid driver
	- usb touchscreen bugfix
	- new device id added to the ftdi_sio driver
	- new device id added to the sisusbvga driver

Please pull from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 drivers/usb/input/hid-core.c        |    4 ++--
 drivers/usb/input/usbtouchscreen.c  |    2 +-
 drivers/usb/misc/sisusbvga/sisusb.c |    2 ++
 drivers/usb/serial/ftdi_sio.c       |    1 +
 drivers/usb/serial/ftdi_sio.h       |    5 +++++
 5 files changed, 11 insertions(+), 3 deletions(-)

---------------

Adrian Bunk:
      USB: hid-core.c: fix duplicate USB_DEVICE_ID_GTCO_404

Kai Lindhom:
      usbtouchscreen: fix ITM data reading

Nobuhiro Iwamatsu:
      USB: Support for USB20SVGA-WH & USB20SVGA-DG

Ralf Schlatterbeck:
      USB: New device ID for ftdi_sio usb serial driver

