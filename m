Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263620AbVBCSVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbVBCSVB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263652AbVBCR5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:57:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:58279 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262634AbVBCRk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:40:58 -0500
Date: Thu, 3 Feb 2005 09:20:56 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.6.11-rc3
Message-ID: <20050203172056.GA23680@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a few usb bugfixes 2.6.11-rc3.  All of these patches have been
in the past few -mm releases.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/2.6.11-rc3/usb

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 Documentation/usb/silverlink.txt    |   78 ------------------------------------
 Documentation/kernel-parameters.txt |    3 -
 MAINTAINERS                         |    7 ---
 drivers/usb/class/cdc-acm.c         |   19 ++++++--
 drivers/usb/core/devio.c            |   15 ++++++
 drivers/usb/core/hcd.c              |    2 
 drivers/usb/input/hid-core.c        |    9 ++--
 drivers/usb/net/usbnet.c            |    4 +
 drivers/usb/serial/Kconfig          |    2 
 drivers/usb/serial/ftdi_sio.c       |    2 
 drivers/usb/serial/garmin_gps.c     |    2 
 drivers/usb/storage/unusual_devs.h  |   10 ++++
 12 files changed, 50 insertions(+), 103 deletions(-)
-----


<hkneissel:gmx.de>:
  o USB: garmin_gps tweak

<krautz:gmail.com>:
  o TIGLUSB Cleanups 3/3
  o TIGLUSB Cleanups 2/3
  o TIGLUSB Cleanups 1/3

Alan Stern:
  o USB: unusual_devs.h update
  o USB: Fix EHCI boot oops on AMD

David Brownell:
  o USB: another usbnet ax8817x device (goodway docking station)

David Woodhouse:
  o USB: fix libusb endian issues

Nico Huber:
  o USB: Logitech Cordeless Desktop Keyboard fails to report class descriptor

Oliver Neukum:
  o USB: fix for open/disconnect race in acm

Randy Dunlap:
  o USB: hid-core: possible buffer overflow in hid-core.c

Rogier Wolff:
  o Re: Bug when using custom baud rates

