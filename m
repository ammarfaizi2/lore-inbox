Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267553AbSLSLHA>; Thu, 19 Dec 2002 06:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267599AbSLSLHA>; Thu, 19 Dec 2002 06:07:00 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:33943 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267553AbSLSLG7>; Thu, 19 Dec 2002 06:06:59 -0500
Date: Thu, 19 Dec 2002 12:14:50 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133 Promise ctrlr, or...
Message-ID: <20021219111450.GD17201@louise.pinerecords.com>
References: <200212190951.gBJ9pCs28149@Port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.10.10212190217240.8350-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10212190217240.8350-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > So.  I /think/ that somehow the Promise controller isn't being
> > > > initialized properly by the Linux kernel, UNLESS the mobo's BIOS
> > > > inits it first?
> > >
> > > In some situations yes. The BIOS does stuff including fixups we mere
> > > mortals arent permitted to know about.
> > 
> > OTOH mere mortals are allowed to make full dump of PCI config ;)
> > 
> > "D.A.M. Revok" <marvin@synapse.net>, can you send lspci -vvvxxx
> > outputs when you boot with BIOS enabled and BIOS disabled?
> 
> Promise knows this point.
> Thus they moved the setting to a push/pull in the vendor space in the
> dma_base+1 and dma_base+3 respectively.
> 
> lspci -vvvxxx fails when the content is located in bar4 io space.

Clearly Promise is the one storage vendor whose products are best avoided.

Andre, could you give a recommendation on what add-on IDE controllers are
not junk hardware and will work nicely with Linux?  'Cos I can't seem to
remember seeing anything in the shelves other than Promise or CMD64X/68X.

-- 
Tomas Szepe <szepe@pinerecords.com>
