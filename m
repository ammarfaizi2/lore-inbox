Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265819AbSKKREz>; Mon, 11 Nov 2002 12:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265843AbSKKREz>; Mon, 11 Nov 2002 12:04:55 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:24082 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265819AbSKKREy>; Mon, 11 Nov 2002 12:04:54 -0500
Date: Mon, 11 Nov 2002 12:10:13 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jens Axboe <axboe@suse.de>, Torben Mathiasen <torben.mathiasen@hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-2.5.46] IDE BIOS timings
In-Reply-To: <1036780850.16651.105.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1021111120435.18680B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Nov 2002, Alan Cox wrote:

> On Fri, 2002-11-08 at 16:56, Jens Axboe wrote:
> > > Linus please drop this patch for now. Its not been tested on enough
> > > controllers, its making things unneccessarily ugly and its also just
> > > going to make updates hard.
> > 
> > Alan, the patch is pretty much straight forward. Cleaning up the magic
> > numbers and ->autotune consistencies is a good thing, imo.
> 
> You can clean up the naming but it still hasn't been tested, not all
> bioses neccessarily give us timings we can trust either.  I'm not
> opposed to the concept but after the previous IDE mess in 2.5 merging
> something that isnt tested on lots of controllers and might have weird
> effects does both me a bit

This is one of those things which we should allow at user risk. After all,
you can shoot yourself in the foot with hdparm as well, there are many
unwise things allowed.

Having seen all the warnings from bad setup of MPS and ACPI in dmesg, I
would say it's more likely that the BIOS get these settings right, since
they may be used by that other operating system.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

