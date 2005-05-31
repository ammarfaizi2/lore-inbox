Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVEaSbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVEaSbF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 14:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVEaSbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 14:31:04 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:21724 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261170AbVEaSbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 14:31:01 -0400
Subject: Re: RT patch acceptance
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, hch@infradead.org, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, Andi Kleen <ak@muc.de>,
       "Bill Huey (hui)" <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       James Bruce <bruce@andrew.cmu.edu>
In-Reply-To: <20050531175152.GT5413@g5.random>
References: <Pine.OSF.4.05.10505311347290.1707-100000@da410.phys.au.dk>
	 <1117556283.2569.26.camel@localhost.localdomain>
	 <20050531171143.GS5413@g5.random>
	 <1117561379.2569.57.camel@localhost.localdomain>
	 <20050531175152.GT5413@g5.random>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 31 May 2005 14:29:52 -0400
Message-Id: <1117564192.2569.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-31 at 19:51 +0200, Andrea Arcangeli wrote:
> On Tue, May 31, 2005 at 01:42:59PM -0400, Steven Rostedt wrote:

> > the integration level, and system level.  Could you imagine what it
> > would take to do this with Linux!  Linux is much bigger than that code
> > that ran the engine of an aircraft, and that testing took ten years!
> 
> Indeed, that's why I believe hard-RT with preempt-RT is just a joke.

I think the main problem with this thread is the definition of what
people call hard-RT.  I came from the defense industry and my version of
what hard-RT is, is what I believe you think is hard-RT.  But now I'm
starting to work with more commercial industries, and I'm finding their
terminology of what hard-RT is different.  This really boils down to the
terminology of hard and soft.  Because, what I think of soft-RT is not
as good as what the preempt-RT patch does.  You need more too it.
Probably, what I was talking about is diamond hard, and Ingo's RT patch
is metal hard.  PREEMPT is just wood hard and !PREEMPT is plastic hard*.
Leaving MS Windows as feather hard ;-)

The levels of RT is really what can be guaranteed and can be proved (or
clearly demonstrated).  What controls an aircraft is obviously going to
have much more scrutiny than what is controlling your cell phone. I
believe that what the -RT patch is giving us, is something that can give
the Linux kernel more that it can guarantee, but not everything. Which I
think is a good thing (and keeps me employed :-)

I don't think that hard-RT in Linux would ever be used for life or death
critical devices, like cat-scan machines or aircraft. But I do see it
more for telecommunication and as others said, music.  Before I left
Lockheed, they were looking into using a version of a RT Linux for use
for applications running on the plane (not controlling it).  The
requirements called for a soft-RT+ OS, but those requirements were much
more stringent than what some so called hard-RTOS could produce.

-- Steve

* OK, maybe still not as hard as what is mentioned, but I couldn't think
of better terminology. I do stand by what I called diamond and what I
called feather. ;-)

+ I know I contradicted myself by saying soft-RT is very weak and then
the requirements for soft-RT were very hard. But I never agreed with
Lockheed's use of the term soft-RT. But I guess, it was stressed that
the OS didn't need to be tested the same, and as mentioned, the lack of
terminology for this is the source of most problems, as is demonstrated
on this thread!


