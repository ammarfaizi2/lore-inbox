Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315544AbSFCKL0>; Mon, 3 Jun 2002 06:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317262AbSFCKLZ>; Mon, 3 Jun 2002 06:11:25 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:35848
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315544AbSFCKLY>; Mon, 3 Jun 2002 06:11:24 -0400
Date: Mon, 3 Jun 2002 03:10:10 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Kjartan Maraas <kmaraas@online.no>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Anthony Spinillo <tspinillo@linuxmail.org>,
        linux-kernel@vger.kernel.org
Subject: Re: INTEL 845G Chipset IDE Quandry
In-Reply-To: <1023104966.26418.11.camel@sevilla.gnome.no>
Message-ID: <Pine.LNX.4.10.10206030306470.14596-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kjartan,

Please do not confuse them, they have a hard enough time reading.
The docs state it can only do X, but lets overclock it and do X+1.
Maybe the hardware is smart and knows which drivers are safe and sane.

Anthony, I sent you a mini-patch to add the 845G to the sane driver.
It will work, as Kjartan has stated.  His system suffered the exact same
events.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On 3 Jun 2002, Kjartan Maraas wrote:

> man, 2002-06-03 kl. 03:13 skrev Alan Cox:
> > On Sun, 2002-06-02 at 22:30, Vojtech Pavlik wrote:
> > > On Sun, Jun 02, 2002 at 09:36:35PM +0200, Martin Dalecki wrote:
> 
> [SNIP]
> 
> > > Note it works with 2.5 already. We have the device there.
> > 
> > If you look at why it fails it fails not because it isnt in the table
> > but because the PCI device has not been allocated resources properly by
> > the BIOS
> > 
> 
> Back when I talked to Andre about this problem it sounded to me like he
> said it was a genuine bug that was fixed in the ide-convert patches.
> Maybe I'm confusing two issues here...

