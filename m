Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262039AbSIYRs2>; Wed, 25 Sep 2002 13:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262041AbSIYRs2>; Wed, 25 Sep 2002 13:48:28 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17161 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262039AbSIYRs1>; Wed, 25 Sep 2002 13:48:27 -0400
Date: Wed, 25 Sep 2002 13:46:18 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Michel Eyckmans (MCE)" <mce@pi.be>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.38 
In-Reply-To: <200209242242.g8OMgmvX008154@jebril.pi.be>
Message-ID: <Pine.LNX.3.96.1020925134010.24336A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2002, Michel Eyckmans (MCE) wrote:

> 
> > Anyway, I'd really like to pinpoint that by having you try another mouse 
> > (borrow a PS/2 or USB mouse from somebody), to make sure that it really is 
> > mouse-related.. After that I can try to beat up on Vojtech.
> 
> I'd like to test other mice too, but I have nowhere to connect them to. 
> This box is 6 years old by now (and yet still going strong :-), so it
> doesn't have all those post-modern connectors...

Have you tried running without X and using the serial port for other
things, like ppp? The assumption is that this is a mouse issue, and I
haven't run 2.5.38 long enough to swear that it isn't, but it might also
be a serial issue. I would venture a guess that the major developers don't
use serial much for anything.
 
> For completeness: very occasionally, X does survive an hour or so of
> normal use. So much so that last night I even thought to have found a 
> solution by changing a mouse-related bit in my kernel config. But today
> it locked up again, causing me to loose a whole bunch of mails in the 
> process. So I'm back to 2.5.31 once more.
> 
> I'm gonna try a non-smp 2.5.38 next, to see if that makes any difference.

Or booting with "noapic" if you don't already. Consider that a data point,
not a solution, I wish I wasn't running all my systems that way. Clearly
the performance impact of noapic is minimal, it just bugs me that after
all the work to balance the irq load many systems are not stable using
that feature.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

