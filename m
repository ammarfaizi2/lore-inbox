Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277758AbRJRPkH>; Thu, 18 Oct 2001 11:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277756AbRJRPj5>; Thu, 18 Oct 2001 11:39:57 -0400
Received: from smtp01.uc3m.es ([163.117.136.121]:22538 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S277751AbRJRPjl>;
	Thu, 18 Oct 2001 11:39:41 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200110181540.f9IFe8S24810@oboe.it.uc3m.es>
Subject: Re: Non-GPL modules
In-Reply-To: <Pine.LNX.3.95.1011018110604.802A-100000@chaos.analogic.com> from
 "Richard B. Johnson" at "Oct 18, 2001 11:21:38 am"
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Thu, 18 Oct 2001 17:40:08 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Richard B. Johnson wrote:"
> On Thu, 18 Oct 2001, Peter T. Breuer wrote:
> 
> > "Richard B. Johnson wrote:"
> > > We have a data interface that feeds high-speed data from 4,000 +
> > > X-Ray detectors directly to memory at RAM/Bus memory speeds. There
> > > is no way in hell that we are going to let the world know how this
> > 
> > Oh my gosh. You aren't working on a project for CERN too, are you?
> 
> No. Amongst many other things, we make the "Exact" baggage scanners
> market by L3 division of Lockheed-Martin. All airplane baggage

Well, in that case, you may find that there _IS_ prior art. The
triggers for the LHC at CERN are PCI boards running to linux (or
solaris) machines.  I seem to be involved in projects to take the data
off at about 13GB/s (as far as I recall the back of envelope).  The
first ring is about 1000 machines in the current design, I believe.

> will eventually be scanned (at baggage-conveyor speeds) at all
> airports serving commercial airliners. The scanning detects
> various devices and chemical compounds. It uses X-Rays of different
> frequencies (hardness) to actually detect chemical compounds
> at their elementary atomic levels.

The CERN stuff gets about 6000 particle traces per collision. Each
particle marks several detectors in a sandwich, and the raw data (lots
of bytes per sandwich layer) is taken off and the trajectories and
timings for each trace are computed. Essentially "digital Xray
detection". I forget what the collision rate is at the target. High
enough that the events aliase.

> For instance, most X-Ray systems only detect density. The X-Ray
> density of a jar of peanut butter is similar to the density of
> the explosive C4. Without chemical discrimination, anybody with
> a jar of peanut butter in their luggage is suspect. However,

I suspect them anyway. I've never seen anything in peanut butter.

> by using dual-energy, we can zero in on nitrogen, while allowing

?? You mean the nitrogen in the explosive?

> the same-density substances containing other atoms.

[to go through]

> We do this in an incredibly fast hardware/software environment
> so that baggage runs through the machines at normal conveyor
> speeds, not slowing down the loading/boarding process.

I've news for you .. the passengers were already slowed down by the
visual Xray inspection as they came in, and as there are on average one
piece of hold baggage  per passenger, the bottleneck is at passenger
entry to the airport!

> This is NOT the scanner used to X-Ray carry-on luggage. That
> uses a much less robust and cheaper process because there
> are attendants present that can ask that suspect carry-on
> luggage be opened for inspection. 

But it seems to be the bottleneck. I imagine most airports have about 4
carry-on scanners, and each passenger takes 60s to go through, so you
cannot have an overall _average_ flow of more than about 4 pieces of
_hold_ baggage per minute to deal with.

Granted, the peaks might be higher, as they are bottlenecked by the
checkin desks. There may be about 100 of those, and each passenger
probably takes 3mins at them, so the flow can peak at about 33 hold
bags per minute (at 1pc/passenger). But there must be long intervals
of low activity because of the average flow calculation.

> Presently, we are using DEC/Alpha machines for the hardware/software
> interface. Our next generation will use PC/AT/Linux machines for
> the same function (at twice the performance).

I see.

Peter
