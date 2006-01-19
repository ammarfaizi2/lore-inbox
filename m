Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161318AbWASFDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161318AbWASFDi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 00:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161323AbWASFDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 00:03:38 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:10180
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1161318AbWASFDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 00:03:37 -0500
Date: Wed, 18 Jan 2006 21:03:27 -0800
From: Greg KH <greg@kroah.com>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: clarity on kref needed.
Message-ID: <20060119050327.GA21823@kroah.com>
References: <3AEC1E10243A314391FE9C01CD65429B28BF0D@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B28BF0D@mail.esn.co.in>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 10:15:51AM +0530, Mukund JB. wrote:
> 
> > > I have gone through kref and am planning to implement then 
> > in my usb driver.
> > 
> > What kind of usb driver?
> It is a finger print authentication USB driver. it doesn ot do the
> authgentication but transports data to the application which really
> does some processing.

You shouldn't need a kernel driver for this, it can be done in userspace
with libusb/usbfs, right?

> No, I did not find any Documentation/kref.txt.
> But I have read about kred in the link below:
> http://developer.osdl.org/dev/robustmutexes/src/fusyn.hg/Documentation/kref.txt
> 
> Is kref depricated because I find nothing related to it in linux/Documentation/?

What kernel version are you looking at?  Look in the kernel source tree
from kernel.org.  What kernel tree are you building your driver against.

And no, it's not depreciated at all.

thanks,

greg k-h
