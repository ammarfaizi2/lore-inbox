Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277911AbRJITBA>; Tue, 9 Oct 2001 15:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277915AbRJITAw>; Tue, 9 Oct 2001 15:00:52 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29450 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S277911AbRJITAi>; Tue, 9 Oct 2001 15:00:38 -0400
Date: Tue, 9 Oct 2001 14:55:41 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Chris Siebenmann <cks@utcc.utoronto.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Breaking system configuration in stable kernels
In-Reply-To: <01Oct8.234022edt.62391@gpu.utcc.utoronto.ca>
Message-ID: <Pine.LNX.3.96.1011009144430.31112A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001, Chris Siebenmann wrote:

> You write:
> |   I've beaten this dead horse before, but Linux will not look to
> | management like a viable candidate for default o/s until whoever releases
> | new versions of *stable* kernel series with cosmetic changes which break
> | existing systems running earlier releases of the same stable kernel
> | series.
> [...]
> |   I love getting problems like this on my vacation, [...]
> 
>  Although I sympathise, I have to ask: why are you rolling new kernels
> (or new anythings) onto production servers without testing and a
> reversion plan? In years of experience with all sorts of vendors as well
> as Linux, I have yet to see *anyone* be reliable about this (the worst
> offender I've ever had to deal with was SGI, who would release 'urgent'
> kernel patches with crash bugs).

I certainly had a reversion plan and backups, but I don't have in-house
hardware duplicating every client configuration. But there's only so much
testing you can do before you put user load on the machine. Also, existing
machines doesn't mean irreplacable mission critical machines, I don't
upgrade unless I have a reason, and piss-poor VM performance certainly is
a reason.
 
>  I strive to never put anything on our servers that I have not tested
> on an expendable machine that is configured as closely as possible to
> the server. And I also try not to be anywhere near the leading edge
> on production servers, unless there is some strong benefit to it.
> 
>  The only time I roll something out 'right now stat!' is when it is
> an urgent security fix.

I don't have that luxury. I can't afford to have a copy of most machines,
and after load and stability testing I have to try on production machines.
None of which addresses the issue that parameter name changes buy nothing
functional, and can cause serious problems. If the module in question was
needed for boot and in the initrd file the system wouldn't boot at all and
there would be little to tell why.

I'd like Linux to be more widely used, and things like this are not
invisible to the people who choose standards.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

