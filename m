Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273415AbRIWMDB>; Sun, 23 Sep 2001 08:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273419AbRIWMCv>; Sun, 23 Sep 2001 08:02:51 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60166 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S273415AbRIWMCe>; Sun, 23 Sep 2001 08:02:34 -0400
Date: Sun, 23 Sep 2001 07:58:20 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon/K7-Opimisation problems
In-Reply-To: <Pine.LNX.4.10.10109211552370.12592-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.3.96.1010923074900.3296A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001, Mark Hahn wrote:

> > The problem I have is seen only when I use Athlon code enabled with
> > menuconfig, so the question is if the code is bad (as in timing
> > sensitive), or if the compiler might be generating bad code for Athlon.
> 
> or the chipset/motherboard/dram can't handle the 2-3x bandwidth
> demanded by the athlon code in the kernel.  the latter is conventional
> wisdom for the past 6-8 months.

The so-called Athlon patch fixed the problem for me on my Abit KK266R
board, I stress tested it at 146MHz FSB (10% o/c) just to see if it was
stable, and it seems all the problems have gone away in both kernel and
user land.

It could be that the bit cleared slows memory, I haven't checked to see if
playing with memory parameters will do the same thing.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

