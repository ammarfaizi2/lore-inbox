Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312991AbSDOGgD>; Mon, 15 Apr 2002 02:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312996AbSDOGgC>; Mon, 15 Apr 2002 02:36:02 -0400
Received: from pc132.utati.net ([216.143.22.132]:60566 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S312991AbSDOGgA>; Mon, 15 Apr 2002 02:36:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: linux as a minicomputer ?
Date: Sun, 14 Apr 2002 20:37:22 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E16wkJq-0004Jl-00@the-village.bc.nu>
Cc: ldavidsen@tmr.com, hpa@zytor.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020415065501.3A687740@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 14 April 2002 09:45 am, Alan Cox wrote:
> > cheap system, but dual Celeron? The last dual Celeron m/b I saw was the
> > BP6, and I have a bunch of them in various places. Is that the board
> > you're remembering? It uses CPUs no longer available.
>
> There are much newer dual Celeron boards. Maybe they just don't sell them
> in the USA any more ?

You can get a dual athlon motherboard down at fry's for about $180, cash and 
carry.  (I was there the day before yesterday, they had tyan tiger, tyan 
thunder, and some kind of Asus.  I believe the $180 one was the tyan tiger...)

Add 512k DDR 2100 SDRAM (I believe the newspaper said it was on sale for 
around $110), a 160 gig maxtor ide drive (~$200 after mail-in rebate), throw 
it in a case...

Trust me, two 1.4 ghz athlons is PLENTY of CPU power.  That's just about 
enough CPU power to compress mp4 video in realtime.  (We've got one here 
doing just that, although we haven't tried feeding a live video signal into 
it, I so dunno how much buffering it would neet to avoid dropping frames, or 
what kind of latency spikes we're talking about...)

In terms of use as a workstation...  2800 mhz divided by 7 people is 400 mhz 
each.  Not that it really quite works that way, but if you think giving them 
a 400 mhz system of their own is reasonable (minus L1 cache contention, plus 
DDR SDRAM/faster FSB, and the three execution cores in an athlon...)

The killer is that if one person drives the machine into swap, performance 
melts down for everybody.  THAT is what makes the idea of a multi-headed 
linux box as a many-way shared workstation seem a lot less workable to me.  
(I'll admit swap behavior sucks a lot less than it used to, but is this an 
endorsement?  There's no attempt at all to make swapping fair with multiple 
users on a box.  Maybe rmap will help here...)

Rob
