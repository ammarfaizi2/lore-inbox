Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261567AbTCGN1k>; Fri, 7 Mar 2003 08:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261560AbTCGN1k>; Fri, 7 Mar 2003 08:27:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46503 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261567AbTCGN1j>;
	Fri, 7 Mar 2003 08:27:39 -0500
Date: Fri, 7 Mar 2003 13:38:13 +0000
From: Chris Dukes <pakrat@www.uk.linux.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Robin Holt <holt@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: Make ipconfig.c work as a loadable module.
Message-ID: <20030307133812.A6676@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0303061500310.31368-100000@mandrake.americas.sgi.com> <1046990052.18158.121.camel@irongate.swansea.linux.org.uk> <20030306221136.GB26732@gtf.org> <20030306222546.K838@flint.arm.linux.org.uk> <1046996037.18158.142.camel@irongate.swansea.linux.org.uk> <20030306231905.M838@flint.arm.linux.org.uk> <1046996987.17718.144.camel@irongate.swansea.linux.org.uk> <20030307000816.P838@flint.arm.linux.org.uk> <20030307012905.G20725@parcelfarce.linux.theplanet.co.uk> <20030307094235.A11807@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030307094235.A11807@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, Mar 07, 2003 at 09:42:35AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 09:42:35AM +0000, Russell King wrote:
> On Fri, Mar 07, 2003 at 01:29:05AM +0000, Chris Dukes wrote:
> > That's nice.  Would you mind explaining to us where that would be a
> > benefit?  Aside from dead header space in elf executables, I'm at
> > a loss as to how a usermode implementation must be significantly
> > larger than kernel code.
> 
> If you're suggesting above that "5MB isn't significantly larger than
> the size Linux can do this" then I think I've just proven you wrong.

The 5Mb example is AIX.
> 
> Lets see - building an ramdisk to mount a root filesystem out of existing
> binaries would require from my exisitng systems probably something like:
> 
I said userspace.  I did not say existing binaries.
[Size comparison of the kitchen sink vs kernel code deleted because 
it's comparing apples and oranges].
> 
> Which version is overly bloated?
> Which version is huge?
> Which version is compact?

You are asserting aesthetics instead of benefits.  I asked about benefits.
Specifically, what is the benefit of compact?
I'm sure you have a very good technical or business benefit to compact, 
but those of us in the world of workstations and servers have zero clue 
what it may be.

Another individual has already indicated a very valid technical merit to
having it all in one file.  I have the same problem myself.  AIX and *BSD
have a working approach to that problem.
> 
> Even the klibc ipconfig version is significantly larger than the in-kernel
> version - and klibc and its binaries are written to be small.

User space solution is not the same as a solution implemented with
multiple user space apps.
> 
> Note: I *do* agree that ipconfig.c needs to die before 2.6 but I do not
> agree that today is the right day.

Perhaps you could explain why today is not the day.
(ie, soon to be shipping product that requires it.  desire to see a viable
userspace solution working before it is removed).

-- 
Chris Dukes
I tried being reasonable once--I didn't like it.
