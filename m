Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265878AbSKBFMF>; Sat, 2 Nov 2002 00:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265879AbSKBFMF>; Sat, 2 Nov 2002 00:12:05 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:16659 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265878AbSKBFMF>; Sat, 2 Nov 2002 00:12:05 -0500
Date: Sat, 2 Nov 2002 00:17:07 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Steven King <sxking@qwest.net>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Joel Becker <Joel.Becker@oracle.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
In-Reply-To: <02110112062400.01200@rigel>
Message-ID: <Pine.LNX.3.96.1021102000343.29692C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2002, Steven King wrote:

> On Friday 01 November 2002 11:18 am, Linus Torvalds wrote:
> 
> > To add insult to injury, you will not be able to actually _test_ any of
> > the real error paths in real life. Sure, you will be able to test forced
> > dumps on _your_ hardware, but while that is fine in the AIX model ("we
> > control the hardware, and charge the user five times what it is worth"),
> > again that doesn't mean _squat_ in the PC hardware space.
> 
>   On the other hand, ISC's system 5 r3 ran on commodity x86 hardware and the 
> crash dumper worked on the various disk hardware I had occasion to use it on 
> (mfm, scsi, ide), although one did need to make sure swap was larger than ram 
> or bad things would happen. 8-{.  

  The thing is that Solaris, AIX, and ISC are written by commercial
companies, they realize that customers need to be able to debug systems
which don't have a screen, a serial printer, etc. They do have disk. 

  I was hoping Alan would push Redhat to put this in their Linux so we
could resolve some of the ongoing problems which don't write an oops to a
log, but I guess none of the developers has to actually support production
servers and find out why they crash.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

