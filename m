Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSIDTo0>; Wed, 4 Sep 2002 15:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSIDTo0>; Wed, 4 Sep 2002 15:44:26 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:63493
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315275AbSIDToZ>; Wed, 4 Sep 2002 15:44:25 -0400
Date: Wed, 4 Sep 2002 12:48:31 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "T. Ryan Halwachs" <halwachs@cats.ucsc.edu>
cc: kernel mailing list <linux-kernel@vger.kernel.org>,
       ataraid mailing list <ataraid-list@redhat.com>,
       Jeff Nguyen <jeff@aslab.com>
Subject: Re: 3 ultra100 controllers
In-Reply-To: <1031163605.4320.41.camel@p700m700>
Message-ID: <Pine.LNX.4.10.10209041245300.3440-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BAWHAHAHA,

5 have been done!

Ask "Jeff Nguyen", all it means is that only two cards will be setup by
their BIOS.  The remaining cards will be setup by the driver.
IIRC, there was a special RIO version with 8 card or 32 drives.

Cheers,


On 4 Sep 2002, T. Ryan Halwachs wrote:

> sent this to promise:
> 
> > -----Original Message-----
> > From: T. Ryan Halwachs [mailto:halwachs@cats.ucsc.edu] 
> > Sent: Monday, August 26, 2002 4:18 PM
> > To: support@promise.com
> > Subject: 3 ultra100 controllers
> > 
> > 
> > hi,
> >  i am trying to use three Promise technology controllers in one system.
> > the promise bios only shows drives attached to the first 2 controllers.
> > how can i use the drives attached to the third controller?
> > 
> > cheers,
> > ryan
> > 
> > 
> > 
> 
> got this in reply:
> 
> > From: support <support@promise.com>
> > To: 'T. Ryan Halwachs' <halwachs@cats.ucsc.edu>
> > Subject: RE: 3 ultra100 controllers
> > Date: 28 Aug 2002 08:23:29 -0700
> > 
> > Hi Ryan
> > 	Sorry you will not be able to used 3 ultra100 in single system.
> > 2 is the most.
> > 
> > It's All About Your Data!
> > 
> > Kevin Huynh
> > Reseller Technical Support.
> > Promise Technology, Inc
> > 1745 McCandless Dr.
> > Milpitas Ca, 95035
> > 408-228-6300
> > 
> > 
> 
> from pdc202xx.c in 2.4.19-ac4
> 
> /* 
> *  linux/drivers/ide/pdc202xx.c	Version 0.35	Mar. 30, 2002 
> * 
> *  Copyright (C) 1998-2002		Andre Hedrick <andre@linux-ide.org> 
> * 
> *  Promise Ultra33 cards with BIOS v1.20 through 1.28 will need this 
> *  compiled into the kernel if you have more than one card installed. 
> *  Note that BIOS v1.29 is reported to fix the problem.  Since this is 
> *  safe chipset tuning, including this support is harmless 
> * 
> *  Promise Ultra66 cards with BIOS v1.11 this 
> *  compiled into the kernel if you have more than one card installed. 
> * 
> *  Promise Ultra100 cards. 
> * 
> *  The latest chipset code will support the following :: 
> *  Three Ultra33 controllers and 12 drives. 
> *  8 are UDMA supported and 4 are limited to DMA mode 2 multi-word. 
> *  The 8/4 ratio is a BIOS code limit by promise. 
> * 
> *  UNLESS you enable "CONFIG_PDC202XX_BURST" 
> * 
> */
> 
> is it possible (using Linux) to run 3 (or more) PDC20267 based ultra100 cards in the same machine?
> 
> cheers,
> ryan
> 

Andre Hedrick
LAD Storage Consulting Group

