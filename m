Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263487AbRFFFhp>; Wed, 6 Jun 2001 01:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263488AbRFFFhf>; Wed, 6 Jun 2001 01:37:35 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:8718 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263487AbRFFFhV>;
	Wed, 6 Jun 2001 01:37:21 -0400
Date: Tue, 5 Jun 2001 22:36:18 -0700
From: Greg KH <greg@kroah.com>
To: John Chris Wren <jcwren@jcwren.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USBDEVFS_URB_TYPE_INTERRUPT
Message-ID: <20010605223618.A3743@kroah.com>
In-Reply-To: <NDBBKBJHGFJMEMHPOPEGGEIBCIAA.jcwren@jcwren.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NDBBKBJHGFJMEMHPOPEGGEIBCIAA.jcwren@jcwren.com>; from jcwren@jcwren.com on Wed, Jun 06, 2001 at 01:31:41AM -0400
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 01:31:41AM -0400, John Chris Wren wrote:
> 
> 	I was designing a USB based device and was looking through the 2.4.5 kernel
> code, and noticed that while it supports bulk, iso, and control types, there
> is no support for interrupt types.  A grep through the entire kernel source
> code reveals that USBDEVFS_URB_TYPE_INTERRUPT defined in
> linux/usbdevice_fs.h, but no where is it used.  Any thoughts as to why that
> might be?
> 
> 	A google search didn't seem to turn up any answers either.

Try this thread for why it is not supported:

	http://marc.theaimsgroup.com/?l=linux-usb-devel&m=99004006207974&w=2

If you still have questions about this, the linux-usb-devel mailing list
is the better place to discuss it.

greg k-h
