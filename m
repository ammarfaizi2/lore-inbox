Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267849AbTBVI2I>; Sat, 22 Feb 2003 03:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267850AbTBVI2H>; Sat, 22 Feb 2003 03:28:07 -0500
Received: from havoc.daloft.com ([64.213.145.173]:9657 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267849AbTBVI2H>;
	Sat, 22 Feb 2003 03:28:07 -0500
Date: Sat, 22 Feb 2003 03:38:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030222083810.GA4170@gtf.org>
References: <96700000.1045871294@w-hlinder> <20030222001618.GA19700@work.bitmover.com> <306820000.1045874653@flay> <20030222024721.GA1489@work.bitmover.com> <14450000.1045888349@[10.10.2.4]> <20030222050514.GA3148@work.bitmover.com> <19870000.1045895965@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19870000.1045895965@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ia32 big iron.  sigh.  I think that's so unfortunately in a number
of ways, but the main reason, of course, is that highmem is evil :)

Intel can use PAE to "turn back the clock" on ia32.  Although googling
doesn't support this speculation, I am willing to bet Intel will
eventually unveil a new PAE that busts the 64GB barrier -- instead of
trying harder to push consumers to 64-bit processors.  Processor speed,
FSB speed, PCI bus bandwidth, all these are issues -- but ones that
pale in comparison to the long term effects of highmem on the market.

Enterprise customers will see this as a signal to continue building
around ia32 for the next few years, thoroughly damaging 64-bit
technology sales and development.  I bet even IA64 suffers...
at Intel's own hands.  Rumors of a "Pentium64" at Intel are constantly
floating around The Register and various rumor web sites, but Intel
is gonna miss that huge profit opportunity too by trying to hack the
ia32 ISA to scale up to big iron -- where it doesn't belong.

Being cynical, one might guess that Intel will treat IA64 as a loss
leader until the other 64-bit competition dies, keeping ia32 at the
top end of the market via silly PAE/PSE hacks.  When the existing
64-bit compettion disappears, five years down the road, compilers
will have matured sufficiently to make using IA64 boxes feasible.

If you really want to scale, just go to 64-bits, darn it.  Don't keep
hacking ia32 ISA -- leave it alone, it's fine as it is, and will live
a nice long life as the future's preferred embedded platform.

64-bit.  alpha is old tech, and dead.  *sniff*  sparc64 is mostly
old tech, and mostly dead.  IA64 isn't, yet.  x86-64 is _nice_ tech,
but who knows if AMD will survive competition with Intel.  PPC64 is
the wild card in all this.  I hope it succeeds.

	Jeff,
	feeling like a silly, random rant after a long drive



...and from a technical perspective, highmem grots up the code, too :)
