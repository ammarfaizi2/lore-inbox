Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966918AbWKUHfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966918AbWKUHfH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 02:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966917AbWKUHfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 02:35:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:64170 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S966918AbWKUHfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 02:35:05 -0500
Date: Mon, 20 Nov 2006 09:52:09 -0800
From: Greg KH <gregkh@suse.de>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kobject_add failed with -EEXIST
Message-ID: <20061120175209.GA27255@suse.de>
References: <4561E290.7060100@gmail.com> <20061120172733.GA26713@suse.de> <4561E68E.7040007@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4561E68E.7040007@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 06:31:58PM +0100, Jiri Slaby wrote:
> Greg KH wrote:
> > On Mon, Nov 20, 2006 at 06:14:56PM +0100, Jiri Slaby wrote:
> >> DEV: Unregistering device. ID = 'cls_device'
> >> PM: Removing info for No Bus:cls_device
> >> device_create_release called for cls_device
> >> device class 'cls_class': unregistering
> >> class 'cls_class': release.
> >> class_create_release called for cls_class
> >> cls_exit
> > 
> > What does sysfs look like at this point in time?  Does
> > /sys/class/cls_class exist?
> 
> No, there is no such dir (it disappears).
> 
> > Also, which kernel version are you using here?
> 
> 2.6.19-rc6, 2.6.19-rc5-mm2

I can't duplicate this here at all with your example code.  Check
userspace to see if HAL or your udev scripts are doing something
"odd"...

What distro is this, and what version of HAL and udev are you using?

thanks,

greg k-h
