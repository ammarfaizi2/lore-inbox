Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261919AbSJNGqC>; Mon, 14 Oct 2002 02:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261920AbSJNGqC>; Mon, 14 Oct 2002 02:46:02 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:14606 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S261919AbSJNGqB>; Mon, 14 Oct 2002 02:46:01 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: jim.houston@ccur.com
Date: Mon, 14 Oct 2002 08:50:59 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
CC: linux-kernel@vger.kernel.org
Message-ID: <3DAA8571.5439.26F0B5@localhost>
In-reply-to: <3DA89C29.93F5622E@ccur.com>
X-mailer: Pegasus Mail for Win32 (v3.12c)
X-Content-Conformance: HerringScan-0.12/Sophos-3.59+2.10+2.03.098+01 July 2002+74553@20021014.064418Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Oct 2002, at 18:03, Jim Houston wrote:

> 
> >> This patch, in conjunction with the "core" high-res-timers 
> >> patch implements high resolution timers on the i386 
> >> platforms. 
> >
> > I really don't get the notion of partial ticks, and quite frankly, this 
> > isn't going into my tree until some major distribution kicks me in the 
> > head and explains to me why the hell we have partial ticks instead of just 
> > making the ticks shorter. 
> > 
> >                Linus 
> 
> Hi Linus,
> 
> Concurrent has been using previous versions of the Posix timers patch
> in our 2.4.18 based kernel.  I like this interface and would like to 
> see it included in your kernel.

Hi,

I think nobody objects seeing the interface implemented. Maybe just how 
it's implemented. I did not have a close look, but the concept seems 
odd at first sight.

Using a individial timer as interrupt source may be a different idea 
(if avaliable for the particular hardware), but the there must be a 
balance between busy looping in the kernel and setting up of such an 
individual interrupt.

The other thing is how to correlate it with the wall clock.

Sorry for not giving answers, I just know the problems...

Regards,
Ulrich

