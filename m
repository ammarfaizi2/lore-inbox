Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267119AbTALO6Q>; Sun, 12 Jan 2003 09:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267114AbTALO6Q>; Sun, 12 Jan 2003 09:58:16 -0500
Received: from mta10.srv.hcvlny.cv.net ([167.206.5.45]:62143 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267119AbTALO6N>; Sun, 12 Jan 2003 09:58:13 -0500
Date: Sun, 12 Jan 2003 10:05:04 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: inefficient RT vs efficient non-RT
In-reply-to: <20030112082822.GB16050@mark.mielke.cc>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Valdis.Kletnieks@vt.edu, David Schwartz <davids@webmaster.com>,
       linux-kernel@vger.kernel.org
Reply-to: robw@optonline.net
Message-id: <1042383903.848.33.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20030112075844.GA16050@mark.mielke.cc>
 <200301120804.h0C84jLE011563@turing-police.cc.vt.edu>
 <20030112082822.GB16050@mark.mielke.cc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 03:28, Mark Mielke wrote:
> be quite a bit more sophisticated than VxWorks. The reason for making
> the point is that a guy jumped on linux-devel saying that anybody can
> write a kernel, and he knows, because he has contributed to
> VxWorks. He then went on to say that he has personally submitted
> several dozen patches to VxWorks.

"Several dozen" per week, for two years... Totalling several hundred..
And almost none of them were in the real time subsystem because at the
time I didn't even know what reak time meant, so don't blame me for any
of that portion of the system.  I was simply working on the core
operating systems functions.

As per the OS sucking, there were a _total_ of about 10 developers on
the OS team as I recall.. From memory, Carl, Linda, Rich, Mike, Joe,
were the real time core system developers, then there was my team, the
"quality and release engineering team", which consisted of me (general
debugging), jeff (release), franklyn (nfs expert), xiaofei (not a word
of english spoken, I don't know what he did), and another robert
(genuinely good guy, scsi and general debugging expert).  So, let's
count the total number of developers that I remember: 5+8=13.  One of
which was responsible for install scripting only,  yep one guy handled
all that.  Quite impressive if you stop and think about it.  Even more
impressive is that after I quit, everyone on my team left within a year
I believe (and they were all there before I got there).  It seems I
somewhat was a motivational factor for keeping them there, though I
can't imagine why (maybe having someone near their age -- the other
development team was all older people).

Anyway, given that VxWorks is, I believe, the only o.s. that runs on the
particular NUMA hardware that it targets, or was at the time, comparing
linux to it is like comparing apples and oranges because your comparing
different hardware platforms, presumably with different speed processors
(like an old 200Mhz system which is what they were selling back in 1996
when I left to a state of the art 2.4 GHz system which they probably
sell nowadays, if not faster).  If and when Linux does run (RedHawk
linux, I'm guessing) properly on this platform, it will quickly be
modified by the real time expert there to meet the real time needs based
on the changes needed to meet their customers needs.  Of course, once
that happens, all their proprietary real time knowledge then becomes
open source....   And when I was there they had already laid off most
all of there custom hardware engineers -- so if there's not much new
custom hardware, and no specific knowledge in the software, I don't know
what the company really has to offer.. Maybe we can look for the death
of Concurrent Computer Coproration shortly after they switch to Linux...
Regardless, My point is that was a system done by about 10 people (and
we support two OS's VxWorks and CX/UX which was BSD).  If you look at
debian, it's done by "900 volunteers".

-Rob
p.s. Yes, I left out the "tools team" which had about another ten people
doing custom compilers, debuggers and that sort of thing.. And of
course, I'm only referring to the u.s. real time division of the
company.. They had a u.k. division as well which speicialized in video
on demand appplications, and they now have a headquarters wihch moved to
atlanta, only because they were displaced from ft. lauderdale by a
church when Harris (the previous company's owner) sold the building. 
The development side of the commpany refused to move, so they just went
a little (one block) north to pompano beach.

