Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbUBWCDW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 21:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbUBWCDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 21:03:22 -0500
Received: from mail.kroah.org ([65.200.24.183]:37044 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261227AbUBWCDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 21:03:19 -0500
Date: Sun, 22 Feb 2004 18:02:31 -0800
From: Greg KH <greg@kroah.com>
To: Robert Gadsdon <robert@gadsdon.giointernet.co.uk>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>
Subject: Re: 2.6.x support for prism2 USB wireless adapter?
Message-ID: <20040223020230.GA14833@kroah.com>
References: <40395346.3040300@gadsdon.giointernet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40395346.3040300@gadsdon.giointernet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 01:11:34AM +0000, Robert Gadsdon wrote:
> I had my Linksys prism2 USB wireless adapter (WUSB11 v2.5) working 
> reasonably well with kernel 2.4.23, but with kernel 2.6.3 (and udev 018) 
> I get:
> 
> usb 1-1: new full speed USB device using address 5
> drivers/usb/core/config.c: invalid interface number (1/1)
> usb 1-1: can't read configurations, error -22
> 
> #modprobe prism2_usb     gives:
> prism2usb_init: prism2_usb.o: 0.2.1-pre20 Loaded
> prism2usb_init: dev_info is: prism2_usb
> drivers/usb/core/usb.c: registered new driver prism2_usb
> 
> #lsusb     does not show the device at all...
> 
> Is this still 'work in progress'?

I don't see this driver in the kernel tree.  Where did you find it?

thanks,

greg k-h
