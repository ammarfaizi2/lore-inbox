Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266948AbSKLVHF>; Tue, 12 Nov 2002 16:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266949AbSKLVHF>; Tue, 12 Nov 2002 16:07:05 -0500
Received: from pc175.host14.starman.ee ([62.65.206.175]:260 "EHLO amd-laptop")
	by vger.kernel.org with ESMTP id <S266948AbSKLVHE>;
	Tue, 12 Nov 2002 16:07:04 -0500
Date: Tue, 12 Nov 2002 23:13:29 +0200
From: Priit Laes <amd@tt.ee>
To: Linux-kernel@vger.kernel.org
Cc: "Bryan O'Sullivan" <bos@serpentine.com>
Subject: Re: GA-7VRXP is a bad motherboard [was Re: PDC20276 Linux driver]
Message-ID: <20021112211329.GB32036@amd-laptop.mshome.net>
References: <1037117166.8313.61.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.21.0211121649360.9631-100000@esentar.trinityteam.it> <20021112165309.GB12789@anakin.wychk.org> <1037133511.7047.12.camel@plokta.s8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037133511.7047.12.camel@plokta.s8.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.19-gentoo-r9 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan O'Sullivan (bos@serpentine.com) wrote:
> On Tue, 2002-11-12 at 08:53, Geoffrey Lee wrote:
> 
> > Board is a Gigabyte GA-7VRXP which has an on-board Promise 20276.
> 
> The GA-7VRXP is a known bad motherboard.  It has a bad electrical
> interface to the AGP slot, so if you're using an AGP graphics card
> without falling back to PCI access, you are pretty much guaranteed
> system hangs or crashes after some time, depending on load.
> 
> This is an issue I confirmed with AMD several (six?) months ago.  I
> don't know of any workarounds that maintain decent graphics performance,
> and last I checked, Gigabyte had not acknowledged the problem.
> 
> Either drop your video card back to not using AGP, or buy a replacement
> motherboard.
Well actually Gigabyte systems are aware of this bug...
According to: www.thetechboard.com (original page has disappeared):

A good number of 1.0 versions of this motherboard barely worked at all
with GeForce4 cards. Stability was unheard of."

The 1.1 version of this board would sometimes work and sometimes not
work. Odds are better of getting a functioning board, but if you have
this version of the board and your GeForce4 card does NOT work,
increasing the VCore voltage by +7.5 in the BIOS can help. The side
effect of this can lead to higher temperatures causing a whole new batch
of problems. Better cooling solutions (like a Volcano7 or Coolermaster
Heatpipe AT MINIMUM) can pacify the heat issues, but I feel that long
term usage at this high of a voltage will cause inevitable failure.

After calling Gigabyte (you would think that they should call me knowing
that they sent me a few hundred motherboards with a "known issue")
because I was growing very tired of all of the tech calls I was
receiving about the board's stability issues with the GeForce4 card, I
was told that the boards needed to be reworked. Older boards were being
"updated" by adding a 4.7uF capacitor between the VR at Q36 and a spot
on the board where a surface mounted capacitor could go (but isn't
installed) at C139. A new revision (2.0) with a resistor (labeled R833)
added is already in production and being shipped.

I've(www.thetechboard.com) already tested the 2.0 version of the board with a PowerColor brand Ti 4200 128MB DDR and things do seem to be considerably better.
"
Hope this helps...
