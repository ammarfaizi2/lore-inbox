Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289492AbSAOPsW>; Tue, 15 Jan 2002 10:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289977AbSAOPsN>; Tue, 15 Jan 2002 10:48:13 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:44041 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S289490AbSAOPsC>; Tue, 15 Jan 2002 10:48:02 -0500
Date: Tue, 15 Jan 2002 16:47:59 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: Giacomo Catenazzi <cate@debian.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery
 --the elegant solution)
In-Reply-To: <3C444441.3080608@debian.org>
Message-ID: <Pine.LNX.4.33.0201151607280.11441-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Giacomo Catenazzi wrote:

> 
> 
> Marco Colombo wrote:
> 
> >>
> >>The main discussion was in kbuild-devel list.
> >>
> > 
> > Uh, my mailbox hurts just at the thought of even more posting on the suject.
> > 
> 
> 
> In kbuild: less people, less traffic, more discussion, less flames
> 
> > Kernel tarballs are for hackers. Marcelo can't test any configuration
> > the autoconfigurator can produce. So basically it means an untested
> > kernel. Running untested kernel isn't a job for Joe User, and never
> > will be.
> 
> 
> Also what are the stable series?

The *starting* point to build a working solution. And stable != supported.
The "working solution" being a distro kernel (well, the whole thing really),
which happens to be supported (and supportable), too...

> But you think your distribution test the kernel in all possible
> use? With all possible hardware configuration?

They *virtually* do. Why do they have (slightly) DIFFERENT hardware
compatibility lists? I don't care if they do really test a given HW
configuration as long as they support it.  You can't ask Marcelo to
actively support any HW conf. I'd expect him to "support" just the HW
he uses to build tarballs.

> Autoconfiguration will configure a compile and booting kernel.
> (but on old machine). Neither vendor can assure you that the kernel
> will work for a particolar permutation of hardware, and mainly
> it is indipendent from configuration.

Uh? After autoconfiguration you *hope* the kernel boots. In late 2.2
times, vanilla 2.2 used to be almost useless for just less-than-naive
users. Think of RAID @ redhat, or ReiserFS @ suse.
BTW, if I buy a RH Linux CD set (+support), and install it on a PC made
by parts all included in RH HW compatibility list, I expect:
1) it to work;
2) failing 1), Red Hat to solve any problem when I call them for support;
3) failing 2), Red Hat to return the money for the CDs.
That's what vendors are for.

> > Vendors and kernel developers have different goals. That horrible hack
> > that fixes some bug or misbehavior fits fine into a vendor kernel, and
> > has no place in Marcelo's tree; the same for that C++ written, cross OS
> > crap driver for hardware XYZ. Users want it, vendors provide it.
> > Different goals, different targets.
> 
> 
> Change distribution. In Debian/unstable developers and distribution are
> hardly linked!

Are you suggesting that Joe User should run Debian/*unstable*? What
it Debian/stable for, then?

> Why do you need someone in the 'layer' between developers
> and user?

The user isn't expected to do any QA. And Marcelo and other kernel
maitainers aren't, either. 

> > Autoconfiguration is nice. But please move the topic elsewhere.
> 
> Right. Let stop it

No problem for me. Feel free to answer me privately, as the above is 
hardly kernel-related (it applies to any other piece of software).

> 
> 	giacomo

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

