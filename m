Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272515AbTGaQRV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 12:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274814AbTGaQRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 12:17:08 -0400
Received: from mail.kroah.org ([65.200.24.183]:34253 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S274811AbTGaQQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 12:16:57 -0400
Date: Thu, 31 Jul 2003 08:58:56 -0700
From: Greg KH <greg@kroah.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Grant Miner <mine0057@mrs.umn.edu>, linux-kernel@vger.kernel.org
Subject: Re: Zio! compactflash doesn't work
Message-ID: <20030731155856.GE3202@kroah.com>
References: <3F26F009.4090608@mrs.umn.edu> <20030730231753.GB5491@kroah.com> <20030731011450.GA2772@win.tue.nl> <20030731041103.GA7668@kroah.com> <20030731005213.B7207@one-eyed-alien.net> <20030731100901.GB2772@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731100901.GB2772@win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 12:09:01PM +0200, Andries Brouwer wrote:
> On Thu, Jul 31, 2003 at 12:52:13AM -0700, Matthew Dharm wrote:
> 
> > > > > > I have a Microtech CompactFlash ZiO! USB
> > > > > > P:  Vendor=04e6 ProdID=1010 Rev= 0.05
> > > > > > S:  Manufacturer=SHUTTLE
> > > > > > S:  Product=SCM Micro USBAT-02
> > > > > > 
> > > > > > but it does not show up in /dev; this is in 2.6.0-pre1.  (It never 
> > > > > > worked in 2.4 either.)  config is attached.  Any ideas?
> > > > > 
> > > > > Linux doesn't currently support this device, sorry.
> > > > 
> > > > Hmm. I think I recall seeing people happily using that.
> > > > Do I misremember?
> > > > 
> > > > Google gives
> > > >   http://www.scm-pc-card.de/service/linux/zio-cf.html
> > > > and
> > > >   http://usbat2.sourceforge.net/
> > > 
> > > In looking at the kernel source, I don't see support for this device.  I
> > > do see support for others like it, but with different product ids.
> > 
> > Zio! apparently makes multiple CF readers.  Some of them are supported, but
> > this particular one is not, and likely never will be.
> 
> This particular one has support on the place indicated.
> Do you mean that that driver will never get into the vanilla kernel?
> And no other driver ever will? Funny.

No, I'm not saying that :)
In looking at the patch, if Matt agrees that it's ok to apply I will.  I
didn't see anything too bad in there.

thanks,

greg k-h
