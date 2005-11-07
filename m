Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965582AbVKGWn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965582AbVKGWn7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 17:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965583AbVKGWn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 17:43:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:27627 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965582AbVKGWn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 17:43:58 -0500
Date: Mon, 7 Nov 2005 14:28:40 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, mdharm-usb@one-eyed-alien.net
Subject: Re: [linux-usb-devel] Re: 2.6.14-mm1: Why is USB_LIBUSUAL user-visible?
Message-ID: <20051107222840.GB26417@kroah.com>
References: <20051107215226.GA25104@kroah.com> <Pine.LNX.4.44L0.0511071725220.5165-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0511071725220.5165-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 05:26:10PM -0500, Alan Stern wrote:
> On Mon, 7 Nov 2005, Greg KH wrote:
> 
> > On Mon, Nov 07, 2005 at 10:10:28PM +0100, Adrian Bunk wrote:
> > > On Sun, Nov 06, 2005 at 06:24:47PM -0800, Andrew Morton wrote:
> > > >...
> > > > Changes since 2.6.14-rc5-mm1:
> > > >...
> > > > +gregkh-usb-usb-libusual.patch
> > > > 
> > > >  USB tree updates
> > > >...
> > > 
> > > IMHO, CONFIG_USB_LIBUSUAL shouldn't be a user-visible variable but 
> > > should be automatically enabled when it makes sense.
> > 
> > The trick is, when does it "make sense"?
> > 
> > Anyone have any ideas?
> 
> The simplest answer is to configure it whenever usb-storage and ub are 
> both configured.  libusual has no purpose otherwise.

Ok, care to write up the Kconfig for that?

thanks,

greg k-h
