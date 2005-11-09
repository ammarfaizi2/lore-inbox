Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbVKIWgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbVKIWgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbVKIWgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:36:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:34707 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751546AbVKIWgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:36:12 -0500
Date: Wed, 9 Nov 2005 14:28:08 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, mdharm-usb@one-eyed-alien.net
Subject: Re: [-mm patch] USB_LIBUSUAL shouldn't be user-visible
Message-ID: <20051109222808.GG9182@kroah.com>
References: <20051107215226.GA25104@kroah.com> <Pine.LNX.4.44L0.0511071725220.5165-100000@iolanthe.rowland.org> <20051107222840.GB26417@kroah.com> <20051108004716.GJ3847@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108004716.GJ3847@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 01:47:16AM +0100, Adrian Bunk wrote:
> On Mon, Nov 07, 2005 at 02:28:40PM -0800, Greg KH wrote:
> > On Mon, Nov 07, 2005 at 05:26:10PM -0500, Alan Stern wrote:
> > > On Mon, 7 Nov 2005, Greg KH wrote:
> > > 
> > > > On Mon, Nov 07, 2005 at 10:10:28PM +0100, Adrian Bunk wrote:
> > > > > On Sun, Nov 06, 2005 at 06:24:47PM -0800, Andrew Morton wrote:
> > > > > >...
> > > > > > Changes since 2.6.14-rc5-mm1:
> > > > > >...
> > > > > > +gregkh-usb-usb-libusual.patch
> > > > > > 
> > > > > >  USB tree updates
> > > > > >...
> > > > > 
> > > > > IMHO, CONFIG_USB_LIBUSUAL shouldn't be a user-visible variable but 
> > > > > should be automatically enabled when it makes sense.
> > > > 
> > > > The trick is, when does it "make sense"?
> > > > 
> > > > Anyone have any ideas?
> > > 
> > > The simplest answer is to configure it whenever usb-storage and ub are 
> > > both configured.  libusual has no purpose otherwise.
> > 
> > Ok, care to write up the Kconfig for that?
> 
> 
> Patch below.
> 
> 
> The more I think about it, the more I think that this might be a bit too 
> complicated.
> 
> What about letting the two drivers always use libusual?

Pete?  What do you think about this patch?

thanks,

greg k-h
