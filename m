Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267033AbTBHQja>; Sat, 8 Feb 2003 11:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267029AbTBHQj2>; Sat, 8 Feb 2003 11:39:28 -0500
Received: from [195.39.17.254] ([195.39.17.254]:9988 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267033AbTBHQiG>;
	Sat, 8 Feb 2003 11:38:06 -0500
Date: Fri, 7 Feb 2003 17:09:55 +0100
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
Message-ID: <20030207160955.GG345@elf.ucw.cz>
References: <1044385759.1861.46.camel@localhost.localdomain> <200302041935.h14JZ69G002675@darkstar.example.net> <b1pbt8$2ll$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1pbt8$2ll$1@penguin.transmeta.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>    I'm hesitant to enter into this.  But from my own experience
> >> the issue with big companies supporting these sort of changes 
> >> in gcc have more to do with the acceptance process of changes 
> >> into gcc than a lack of desire on the large companies part.
> >
> >Maybe we should create a KGCC fork, optimise it for kernel
> >complilations, then try to get our changes merged back in to GCC
> >mainline at a later date.
> 
> That's not really the problem.
> 
> I think the problem with gcc is that many of the developers are actually
> much more interested in Ada or C++ (or even Fortran!), than in plain
> old-fashioned C.  So it's not a kernel issue per se, gcc is slow to
> compile _any_ C project. 
> 
> And a lot of the optimizations gcc does aren't even interesting to most
> C projects.  Most "old-fashioned" C projects tend to be written in ways
> that mean that the most important optimizations are the truly trivial
> ones, and then doing good register allocation.
> 
> I'd love to see a small - and fast - C compiler, and I'd be willing to
> make kernel changes to make it work with it.  

What about gcc-1.4 or something like that? If you go back in time,
you'll find gcc is getting smaller and faster ;-). Actually making
kernel compile with gcc-2.7.2 should make it few times faster than
gcc-3.2...
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
