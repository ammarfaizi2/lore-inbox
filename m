Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbVKGW0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbVKGW0M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 17:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbVKGW0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 17:26:12 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:62407 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S964972AbVKGW0M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 17:26:12 -0500
Date: Mon, 7 Nov 2005 17:26:10 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Pete Zaitcev <zaitcev@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>,
       <mdharm-usb@one-eyed-alien.net>
Subject: Re: [linux-usb-devel] Re: 2.6.14-mm1: Why is USB_LIBUSUAL user-visible?
In-Reply-To: <20051107215226.GA25104@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0511071725220.5165-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2005, Greg KH wrote:

> On Mon, Nov 07, 2005 at 10:10:28PM +0100, Adrian Bunk wrote:
> > On Sun, Nov 06, 2005 at 06:24:47PM -0800, Andrew Morton wrote:
> > >...
> > > Changes since 2.6.14-rc5-mm1:
> > >...
> > > +gregkh-usb-usb-libusual.patch
> > > 
> > >  USB tree updates
> > >...
> > 
> > IMHO, CONFIG_USB_LIBUSUAL shouldn't be a user-visible variable but 
> > should be automatically enabled when it makes sense.
> 
> The trick is, when does it "make sense"?
> 
> Anyone have any ideas?

The simplest answer is to configure it whenever usb-storage and ub are 
both configured.  libusual has no purpose otherwise.

Alan Stern

