Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271013AbRHOD1y>; Tue, 14 Aug 2001 23:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271008AbRHOD1m>; Tue, 14 Aug 2001 23:27:42 -0400
Received: from jgateadsl.cais.net ([205.252.5.196]:59938 "EHLO
	tyan.doghouse.com") by vger.kernel.org with ESMTP
	id <S271010AbRHOD1b>; Tue, 14 Aug 2001 23:27:31 -0400
Date: Tue, 14 Aug 2001 23:25:54 -0400 (EDT)
From: Maxwell Spangler <maxwax@mindspring.com>
X-X-Sender: <maxwell@tyan.doghouse.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: =?ISO-8859-1?Q?=D8ystein?= Haare <oyhaare@online.no>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Via chipset
In-Reply-To: <E15UGOw-0004H2-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108142320300.13805-100000@tyan.doghouse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Aug 2001, Alan Cox wrote:

> > I'm planning on getting a new workstation, and I kinda want an AMD
> > system. But it seems that most (all?) motherboards for the amd cpu's us=
> > e
> > VIA chipsets, and some people have experienced problems with via
> > chipsets and linux.
>
> We have seen two big problem sets with the VIA chipsets and Athlon. The
> first is a bug in some of the bridges that caused corruption. We had partial
> workarounds but as of 2.4.7ac releases (and I sent it to Linus for
> 2.4.8pre) we have an official workaround based on VIA provided info.
>
> The second problem is that some VIA chipset boards lock up running the
> Athlon optimised kernel. This seems to be board specific and we've also had
> 'setting CAS3 not CAS2' and 'bigger PSU' reports of fixing it for some
> people. I'm still trying to put together a detailed enough study of what
> is going on to actually take it to VIA and AMD engineers.

I just took the plunge this past weekend and bought a Tyan 2390B (KT-133A
chipset) and an Athlon 1.2/266 processor.

The system is running smoothly, performance is quite good, and I'm not getting
anything scary like random lockups or reboots.. if I use 2.4.8 compiled for
Pentium Pro (previous motherboard was PPro).

HOWEVER, if I try to boot an Athlon optimized kernel, I get a variety of
problems.  In the 2-3 attempts I've tried, I've been able to boot the kernel,
but when the kernel runs init and starts processing init scripts, I get a
variety of lockups, PANICs, etc..

Alan, what can we do to help provide information?  I'll volunteer to run some
tests on this system and report the results to try to assist in nailing down
the problem.  I just don't know what tests to run.. :)

It's running Redhat 7.1 with kernel 2.4.8.  This system has two Netgear
FA310TXs, two Promise Ultra100 cards, AGP video of some sort and two PC133
256M DIMMs.  There's a 15G Maxtor EIDE drive on the via controller, along with
an EIDE cdrom on the secondary channel, everything else is on the Promise
controllers..

I'm running most BIOS options (especially the scary stuff like memory
settings) at their out-of-the-box defaults.

-------------------------------------------------------------------------------
Maxwell Spangler                         "Don't take the penguin too seriously.
Program Writer                       It's supposed to be kind of goofy and fun,
Greenbelt, Maryland, U.S.A.                      that's the whole point" - l.t.
Washington D.C. Metropolitan Area

