Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbSKCOED>; Sun, 3 Nov 2002 09:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261877AbSKCOED>; Sun, 3 Nov 2002 09:04:03 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:51717 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261874AbSKCOEC>; Sun, 3 Nov 2002 09:04:02 -0500
Date: Sun, 3 Nov 2002 09:08:41 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
cc: Steven King <sxking@qwest.net>, Linus Torvalds <torvalds@transmeta.com>,
       Joel Becker <Joel.Becker@oracle.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0211020033310.14075-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.3.96.1021103085405.5197B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002, Zwane Mwaikambo wrote:

> On Sat, 2 Nov 2002, Bill Davidsen wrote:
> 
> >   The thing is that Solaris, AIX, and ISC are written by commercial
> > companies, they realize that customers need to be able to debug systems
> > which don't have a screen, a serial printer, etc. They do have disk. 
> > 
> >   I was hoping Alan would push Redhat to put this in their Linux so we
> > could resolve some of the ongoing problems which don't write an oops to a
> > log, but I guess none of the developers has to actually support production
> > servers and find out why they crash.
> 
> Perhaps i'm being grossly naive here, but none of these presumably x86 
> productions servers don't have a serial port? Not even PCI/ISA slots to 
> add one? Serial would catch most of your oopsen anyway, and if you were 
> borked enough that serial couldn't get the entire output, i somehow doubt 
> dumping to disk could manage. And no i don't see anything wrong nor 
> consider it studly to use oopses only for debugging...

I have distributed servers in 15 locations, six states, four timezones. In
secure unattended locations like wiring closets. What do I do with the
serial port? Do I double my colocation costs and have another system there
to listen? Is the code on a sick system going to dial the modem on the
serial line amd establish a connection?

I have a mix of Linux, Solaris, and AIX systems deployed, and only the
Linux systems don't have this capability. Actually for the most part only
the Linux systems NEED it, that's another problem, but reliability would
go up if I could see the problem.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

