Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267611AbSLSLjW>; Thu, 19 Dec 2002 06:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267617AbSLSLjW>; Thu, 19 Dec 2002 06:39:22 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43794
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267611AbSLSLjV>; Thu, 19 Dec 2002 06:39:21 -0500
Date: Thu, 19 Dec 2002 03:45:03 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133
 Promise ctrlr, or...
In-Reply-To: <20021219111450.GD17201@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.10.10212190314260.8350-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2002, Tomas Szepe wrote:

> > > > > So.  I /think/ that somehow the Promise controller isn't being
> > > > > initialized properly by the Linux kernel, UNLESS the mobo's BIOS
> > > > > inits it first?
> > > >
> > > > In some situations yes. The BIOS does stuff including fixups we mere
> > > > mortals arent permitted to know about.
> > > 
> > > OTOH mere mortals are allowed to make full dump of PCI config ;)
> > > 
> > > "D.A.M. Revok" <marvin@synapse.net>, can you send lspci -vvvxxx
> > > outputs when you boot with BIOS enabled and BIOS disabled?
> > 
> > Promise knows this point.
> > Thus they moved the setting to a push/pull in the vendor space in the
> > dma_base+1 and dma_base+3 respectively.
> > 
> > lspci -vvvxxx fails when the content is located in bar4 io space.
> 
> Clearly Promise is the one storage vendor whose products are best avoided.

I would not say this is the case.  What is going on is people are wanting
to migrate to more of an internal hidden operation.

Think about it from their side.
They want to make it easier to program the card.

Linux is an OS that like to know what is going on all the time, and the
two clash.

> Andre, could you give a recommendation on what add-on IDE controllers are
> not junk hardware and will work nicely with Linux?  'Cos I can't seem to
> remember seeing anything in the shelves other than Promise or CMD64X/68X.

Hmmm...

Andre Hedrick
LAD Storage Consulting Group

