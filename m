Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261856AbSKCNmy>; Sun, 3 Nov 2002 08:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261861AbSKCNmy>; Sun, 3 Nov 2002 08:42:54 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:47877 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261856AbSKCNmx>; Sun, 3 Nov 2002 08:42:53 -0500
Date: Sun, 3 Nov 2002 08:48:30 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
In-Reply-To: <1036157204.12693.13.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1021103082813.5197A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Nov 2002, Alan Cox wrote:

> On Fri, 2002-11-01 at 06:34, Bill Davidsen wrote:
> >   From the standpoint of just the driver that's true. However, the remote
> > machine and all the network bits between them are a string of single
> > points of failure. Isn't it good that both disk and network can be
> > supported.
> 
> My concerns are solely with things like the correctness of the disk
> dumper. Its obviously a good way to do a lot more damage if it isnt done
> carefully. Quite clearly your dump system wants to support multiple dump
> targets so you can dump to pci battery backed ram, down the parallel
> port to an analysing box etc

Quite clearly SCO, Sun, and IBM have been doing this for years without
offering dozens of options. I don't need it to sing and dance, I just need
a way to put the dump where I can find it. I'm not going to put another
box in at the end of a serial or parallel port, I don't have NVram, I do
have lopts of disk, and so does almost everyone else. I have remote
systems in wiring closets all over the country (all four time zones). They
are at the end of open net connections, unreliable and untrusted. I don't
want to bet that I have a working VPN, or that I can safely send all that
data without it being read by someone other than me.

The AIX support has a group just to beat on dumps customers send. What
more evidence is needed that people can and do use the capability.

I had hoped that someone would do this for Linux, I never dreamed that
it would be kept out of the kernel by people who clearly don't understand
the problems if distributed and clustered headless systems.

I guess the development folks are working on more important things like
xiafs and morse code dumps to the keyboard LEDs.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

