Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbUBYCCD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 21:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbUBYCBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 21:01:51 -0500
Received: from mail.kroah.org ([65.200.24.183]:34993 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262571AbUBYCAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 21:00:22 -0500
Date: Tue, 24 Feb 2004 18:00:01 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: usb-uhci rmmod fun
Message-ID: <20040225020001.GA4265@kroah.com>
References: <20040225005241.GB11203@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225005241.GB11203@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 12:52:41AM +0000, Dave Jones wrote:
> Greg,
>  wtf is going on here ?
> 
> (00:52:08:root@mindphaser:davej)# lsmod | grep floppy
> (00:52:39:root@mindphaser:davej)# modprobe usb-uhci
> (00:52:48:root@mindphaser:davej)# lsmod | grep floppy
> (00:53:02:root@mindphaser:davej)# rmmod uhci_hcd
> (00:53:11:root@mindphaser:davej)# lsmod | grep floppy
> floppy                 58260  0
> (00:53:13:root@mindphaser:davej)#
> 
> Unloading the usb controller loads the floppy controller!?

Heh, I have no idea why that happens.  I can't duplicate that here.
What version of your hotplug scripts are you using?
What kernel version?
Do you have kmod enabled?

thanks,

greg k-h
