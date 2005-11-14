Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbVKNUXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVKNUXA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVKNUWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:22:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:32712 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932095AbVKNUWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:22:46 -0500
Date: Mon, 14 Nov 2005 12:09:24 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [patch 00/12] USB patches for 2.6.15-rc1
Message-ID: <20051114200924.GA2531@kroah.com>
References: <20051114200456.GA2319@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114200456.GA2319@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 12:04:56PM -0800, Greg Kroah-Hartman wrote:
> Here are a few USB patches against your latest git tree, they have all
> been in the past few -mm releases just fine.  They fix some build bugs,
> add some new device ids, and add a new simple usb-serial driver.

Oh, forgot the combined diffstat of the whole series, sorry about that:

 Documentation/devices.txt            |   12 
 Documentation/usb/bluetooth.txt      |   45 --
 drivers/usb/core/devio.c             |    5 
 drivers/usb/core/inode.c             |    8 
 drivers/usb/core/message.c           |    4 
 drivers/usb/gadget/dummy_hcd.c       |    5 
 drivers/usb/input/hid-core.c         |   13 
 drivers/usb/input/wacom.c            |  134 +++++-
 drivers/usb/serial/ChangeLog.history |  730 ++++++++++++++++++++++++++++++++++
 drivers/usb/serial/ChangeLog.old     |  731 -----------------------------------
 drivers/usb/serial/Kconfig           |    9 
 drivers/usb/serial/Makefile          |    1 
 drivers/usb/serial/anydata.c         |  123 +++++
 drivers/usb/serial/cp2101.c          |    2 
 drivers/usb/serial/generic.c         |    2 
 drivers/usb/storage/Kconfig          |    3 
 drivers/usb/storage/unusual_devs.h   |    6 
 17 files changed, 1000 insertions(+), 833 deletions(-)


thanks,

greg k-h
