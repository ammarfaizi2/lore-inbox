Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130679AbQLUT0G>; Thu, 21 Dec 2000 14:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131059AbQLUTZ4>; Thu, 21 Dec 2000 14:25:56 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:26380 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130679AbQLUTZq>; Thu, 21 Dec 2000 14:25:46 -0500
Date: Thu, 21 Dec 2000 15:01:37 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Zdenek Kabelac <kabi@informatics.muni.cz>
cc: Douglas Gilbert <dougg@torque.net>, linux-kernel@vger.kernel.org,
        Zdenek Kabelac <kabi@fi.muni.cz>
Subject: Re: Oops with 2.4.0-test13pre3 - swapoff
In-Reply-To: <E148lQt-0000UI-00@decibel.fi.muni.cz>
Message-ID: <Pine.LNX.4.21.0012211500500.2199-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Dec 2000, Zdenek Kabelac wrote:

> > Zdenek Kabelac wrote:
> > > This is oops I've got when rebooting after some heavy disk activity on
> > > my SMP system:
> > > 
> > > Written by hand:
> > > 
> > > kernel BUG swap_state.c:78!
> > [snip]
> > 
> > Same here during a halt of a RH 6.2 based K6-2 500 MHz
> > UP machine running lk240t13p3. The machine had been on
> > for a while and had built a kernel amongst other things.
> > 
> 
> I'll just append that my machine has been up for just several
> minutes (maybe 10) but has been doing heavy copying - several
> 600MB files between some partitions.
> 
> So maybe the problem with memory thrashing is still not fully fixed ???

The bug was in new shm's code it seems.

Christoph is already looking at it and should have a fix soon.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
