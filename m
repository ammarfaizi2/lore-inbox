Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267934AbTBVWJO>; Sat, 22 Feb 2003 17:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267935AbTBVWJO>; Sat, 22 Feb 2003 17:09:14 -0500
Received: from holomorphy.com ([66.224.33.161]:7338 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267934AbTBVWJI>;
	Sat, 22 Feb 2003 17:09:08 -0500
Date: Sat, 22 Feb 2003 14:18:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030222221820.GI10401@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <96700000.1045871294@w-hlinder> <20030222001618.GA19700@work.bitmover.com> <306820000.1045874653@flay> <20030222024721.GA1489@work.bitmover.com> <14450000.1045888349@[10.10.2.4]> <20030222050514.GA3148@work.bitmover.com> <19870000.1045895965@[10.10.2.4]> <20030222083810.GA4170@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030222083810.GA4170@gtf.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 03:38:10AM -0500, Jeff Garzik wrote:
> ia32 big iron.  sigh.  I think that's so unfortunately in a number
> of ways, but the main reason, of course, is that highmem is evil :)
> Intel can use PAE to "turn back the clock" on ia32.  Although googling
> doesn't support this speculation, I am willing to bet Intel will
> eventually unveil a new PAE that busts the 64GB barrier -- instead of
> trying harder to push consumers to 64-bit processors.  Processor speed,
> FSB speed, PCI bus bandwidth, all these are issues -- but ones that
> pale in comparison to the long term effects of highmem on the market.

PAE is a relatively minor insult compared to the FPU, the 50,000 psi
register pressure, variable-length instruction encoding with extremely
difficult to optimize for instruction decoder trickiness, the nauseating
bastardization of segmentation, the microscopic caches and TLB's, the
lack of TLB context tags, frankly bizarre and just-barely-fixable gate
nonsense, the interrupt controller, and ISA DMA.

I've got no idea why this particular system-level ugliness which is
nothing more than a routine pitstop in any bring your own barfbag
reading session of x86 manuals fascinates you so much.

At any rate, if systems (or any other) programming difficulties were
any concern at all, x86 wouldn't be used at all.


On Sat, Feb 22, 2003 at 03:38:10AM -0500, Jeff Garzik wrote:
> Enterprise customers will see this as a signal to continue building
> around ia32 for the next few years, thoroughly damaging 64-bit
> technology sales and development.  I bet even IA64 suffers...
> at Intel's own hands.  Rumors of a "Pentium64" at Intel are constantly
> floating around The Register and various rumor web sites, but Intel
> is gonna miss that huge profit opportunity too by trying to hack the
> ia32 ISA to scale up to big iron -- where it doesn't belong.

What power do you suppose we have to resist any of this? Intel, the
800lb gorilla, shoves what it wants where it wants to shove it, and
all the "exit only" signs in the world attached to our backsides do
absolutely nothing to deter it whatsoever.


On Sat, Feb 22, 2003 at 03:38:10AM -0500, Jeff Garzik wrote:
> Being cynical, one might guess that Intel will treat IA64 as a loss
> leader until the other 64-bit competition dies, keeping ia32 at the
> top end of the market via silly PAE/PSE hacks.  When the existing
> 64-bit compettion disappears, five years down the road, compilers
> will have matured sufficiently to make using IA64 boxes feasible.

Sounds relatively natural. I don't have a good notion of the legality
boundaries wrt. to antitrust, but I'd assume they would otherwise do
whatever it takes to either defeat or wipe out competitors.


On Sat, Feb 22, 2003 at 03:38:10AM -0500, Jeff Garzik wrote:
> If you really want to scale, just go to 64-bits, darn it.  Don't keep
> hacking ia32 ISA -- leave it alone, it's fine as it is, and will live
> a nice long life as the future's preferred embedded platform.

Take this up with Intel. The rest of us are at their mercy.
Good luck finding anyone there to listen to it, you'll need it.


On Sat, Feb 22, 2003 at 03:38:10AM -0500, Jeff Garzik wrote:
> 64-bit.  alpha is old tech, and dead.  *sniff*  sparc64 is mostly
> old tech, and mostly dead.  IA64 isn't, yet.  x86-64 is _nice_ tech,
> but who knows if AMD will survive competition with Intel.  PPC64 is
> the wild card in all this.  I hope it succeeds.

Alpha is old, dead, and kicking most other cpus' asses from the grave.
I always did like DEC hardware. =(

I'm not sure what's so nice about x86-64; another opcode prefix
controlled extension atop the festering pile of existing x86 crud
sounds every bit as bad any other attempt to prolong x86. Some of
the system device -level cleanups like the HPET look nice, though.

This success/failure stuff sounds a lot like economics, which is
pretty much even further out of our control than the weather or the
government. What prompted this bit?


-- wli
