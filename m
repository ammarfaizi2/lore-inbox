Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317176AbSFKQzS>; Tue, 11 Jun 2002 12:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317185AbSFKQzR>; Tue, 11 Jun 2002 12:55:17 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:40720
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317176AbSFKQzP>; Tue, 11 Jun 2002 12:55:15 -0400
Date: Tue, 11 Jun 2002 09:52:29 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Nick Evgeniev <nick@octet.spb.ru>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.19-preX IDE bugs
In-Reply-To: <002101c2115d$1c0bc7c0$baefb0d4@nick>
Message-ID: <Pine.LNX.4.10.10206110939580.11687-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well be more specific on the hardware.
Remember Promise came in and started dorking the driver.
Next they will not admit to an asic bug even thought I have called them on
the existance.  2.5 can not fix it, it will only blow up in 2.5.  Hell it
is possiblely blowing up in 2.4 but less likely.

So spell out the hardware in question.

The new chip hardware lost its interrupt parse because promise took it out
of the pci space and it made the driver less stable because the hardware
is less stable.

On Tue, 11 Jun 2002, Nick Evgeniev wrote:

> Hi,
> 
> > > I added it to the collection of IDE oddities I'm looking at. There are
> > > also some promise requested changes due to get merged at the end of this
> > > week. Then we can see where we stand
> >
> > Also, it is hard to answer email without connectivity in the air.
> 
> Agreed. But all what I see is that STABLE Linux kernel DOESN'T has working
> driver for promise controller (including latest ac patches) for SEVERAL
> MONTHS.
> And as for now there is no any progress in fixing it. I don't blame on you,
> or Alan,
> or whoever else. All I have to suggest is to drop promise support in stable
> kernel,
> then rewrite/fix it in 2.5 tree... and then backport it to 2.4.
> 
> I don't want to make experiments in production environment anymore... And
> it's
> unfair to the rest of Linux users to keep broken drivers in stable kernel...
> Because
> nobody expects that stable kernel will rip your fs _daily_.
> 
> 
> 

Andre Hedrick
LAD Storage Consulting Group

