Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264833AbRFSXbw>; Tue, 19 Jun 2001 19:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264834AbRFSXbn>; Tue, 19 Jun 2001 19:31:43 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:46091 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S264833AbRFSXb0>; Tue, 19 Jun 2001 19:31:26 -0400
Date: Tue, 19 Jun 2001 18:31:15 -0500
From: Timur Tabi <ttabi@interactivesi.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <01061914180302.04670@localhost.localdomain>
In-Reply-To: <20010619090956.R3089@work.bitmover.com> <Pine.LNX.4.30.0106191714320.11271-100000@sphinx.mythic-beasts.com> 
	<20010619095239.T3089@work.bitmover.com> <20010619095239.T3089@work.bitmover.com>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-ID: <lATeaC.A.K1B.HD-L7@dinero.interactivesi.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Rob Landley <landley@webofficenow.com> on Tue, 19 Jun
2001 14:18:03 -0400


> 2) Not only did Linux not have threads (at all), it didn't plan to have 
> threads, and anybody who brought up the idea of threads was dismissed.  
> Considering this was long before clone, and SMP hardware was starting to come 
> into the high and and looked like it might wind up on the desktop eventually 
> (who knew MS would keep DOS around another ten years, unable to understand 
> two processors, to displays, two mice, two keyboards, and barely able to cope 
> with two hard drives under a 26 letter limit...)

Amen.  This is one of the reasons why I also prefer OS/2 over Linux.

> So I wound up work at IBM doing OS/2 development for a couple years.  On a 
> project called Feature Install, which was based on a subclassed folder in the 
> workplace shell (object oriented desktop).

[snip]

> When they made up a test object hierarchy 
> for all the components of the entire OS, it created so many threads the 
> system ran out and got completely hosed.  I had a command line window open, 
> but couldn't RUN anything, since anything it tried to spawn required a thread 
> to run.  (Child of the shell.)

Feature Installer is a bad example.  That software is a piece of crap for lots
of reasons, excessive threading being only one, and every OS/2 user knew it the
day it was released.  Why do you think WarpIN was created?  

> Sometimes they're an easy way to get asynchronous behavior, and to perform 
> work in the background without the GUI being locked up.  But the difference 
> between "processes" and "threads" there is academic.  Processes with shared 
> memory and some variant of semaphores to avoid killing each other in it.  
> Same thing.

Not quite.  What makes OS/2's threads superior is that the OS multitasks
threads, not processes.  So I can create a time-critical thread in my process,
and it will have priority over ALL threads in ALL processes.

A lot of OS/2 software is written with this feature in mind.  I know of one
programmer who absolutely hates Linux because it's just too difficult porting
software to it, and the lack of decent thread support is part of the problem.

> Bondage and discipline languages that enforce somebody's idea of good 
> programming practice usually just result in WORSE bad programs, and fewer 
> good programs written by people who know how to play with fire without 
> burning themselves.  Saying you can't have threads because they can be 
> misused and "you shouldn't program that way" would be truly dumb.  (Turned ME 
> off for a couple years, anyway.)

Exactly.  Saying that threads cause bad code is just as dumb as saying that a
kernel debugger will cause bad code because programmers will start using the
debugger instead of proper design.

Oh wait, never mind .....


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

