Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272445AbTGaKJG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 06:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272965AbTGaKJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 06:09:06 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:19730 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S272445AbTGaKJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 06:09:04 -0400
Date: Thu, 31 Jul 2003 12:09:01 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Greg KH <greg@kroah.com>, Grant Miner <mine0057@mrs.umn.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Zio! compactflash doesn't work
Message-ID: <20030731100901.GB2772@win.tue.nl>
References: <3F26F009.4090608@mrs.umn.edu> <20030730231753.GB5491@kroah.com> <20030731011450.GA2772@win.tue.nl> <20030731041103.GA7668@kroah.com> <20030731005213.B7207@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731005213.B7207@one-eyed-alien.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 12:52:13AM -0700, Matthew Dharm wrote:

> > > > > I have a Microtech CompactFlash ZiO! USB
> > > > > P:  Vendor=04e6 ProdID=1010 Rev= 0.05
> > > > > S:  Manufacturer=SHUTTLE
> > > > > S:  Product=SCM Micro USBAT-02
> > > > > 
> > > > > but it does not show up in /dev; this is in 2.6.0-pre1.  (It never 
> > > > > worked in 2.4 either.)  config is attached.  Any ideas?
> > > > 
> > > > Linux doesn't currently support this device, sorry.
> > > 
> > > Hmm. I think I recall seeing people happily using that.
> > > Do I misremember?
> > > 
> > > Google gives
> > >   http://www.scm-pc-card.de/service/linux/zio-cf.html
> > > and
> > >   http://usbat2.sourceforge.net/
> > 
> > In looking at the kernel source, I don't see support for this device.  I
> > do see support for others like it, but with different product ids.
> 
> Zio! apparently makes multiple CF readers.  Some of them are supported, but
> this particular one is not, and likely never will be.

This particular one has support on the place indicated.
Do you mean that that driver will never get into the vanilla kernel?
And no other driver ever will? Funny.

Andries

