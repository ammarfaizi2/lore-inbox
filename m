Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288771AbSADVFE>; Fri, 4 Jan 2002 16:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288763AbSADVEs>; Fri, 4 Jan 2002 16:04:48 -0500
Received: from h24-71-103-168.ss.shawcable.net ([24.71.103.168]:1032 "HELO
	discworld.dyndns.org") by vger.kernel.org with SMTP
	id <S288762AbSADVEc>; Fri, 4 Jan 2002 16:04:32 -0500
Date: Fri, 4 Jan 2002 15:04:13 -0600
From: Charles Cazabon <linux@discworld.dyndns.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, Dave Jones <davej@suse.de>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        Lionel Bouton <Lionel.Bouton@free.fr>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020104150413.A2744@twoflower.internal.do>
In-Reply-To: <Pine.GSO.3.96.1020104211143.829K-100000@delta.ds2.pg.gda.pl> <Pine.LNX.4.33.0201042128360.20620-100000@Appserv.suse.de> <20020104153305.C20097@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020104153305.C20097@thyrsus.com>; from esr@thyrsus.com on Fri, Jan 04, 2002 at 03:33:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond <esr@thyrsus.com> wrote:
> Dave Jones <davej@suse.de>:
> > Indeed. Something I'm trying to convey to Eric, but I don't think
> > he realises just how many pooched BIOSen there are out there.
> > His conservative estimate of '150 entries in the blacklist'
> > is possibly off by an order of 10 times or more.
> 
> Are there even 1500 distinct PC motherboard designs in *existence*? :-)

There are tens of thousands of distinct PC motherboard designs in existence.
I've personally worked on more than a thousand of them over the years.  The
big issue is that even with a single distinct design (say a reference design
used by multiple manufacturers), there will be multiple differently-buggy
BIOSen for that board before you even consider the different versions a single
manufacturer will crank out over time.

The motherboard market is a lot less diverse today than it was at its peak --
say late-486 through mid-Pentium (94-97 perhaps).  At one point, there were a
dozen major brands of core logic, and hundreds of motherboard manufacturers.

Of course, DMI doesn't come into much of the older ones.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
-----------------------------------------------------------------------
