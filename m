Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278422AbRJMVrE>; Sat, 13 Oct 2001 17:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278426AbRJMVqy>; Sat, 13 Oct 2001 17:46:54 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:34063 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S278423AbRJMVql>; Sat, 13 Oct 2001 17:46:41 -0400
Date: Sat, 13 Oct 2001 17:47:13 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Which is better at vm, and why? 2.2 or 2.4
In-Reply-To: <20011013142926.B28547@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.10.10110131733430.17521-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > my test for VM is to compile a kernel on my crappy old BP6 with mem=64m;
> > I use a dedicated partition with a fresh ext2, unpack the same source tree,
> > make -j2 7 times, drop 1 outlier, and average:
> > 
> > 2.2.19: 584.462user 57.492system 385.112elapsed 166.5%CPU
> > 2.4.12: 582.318user 40.535system 337.093elapsed 184.5%CPU
> >
> 
> Is this:
> > 2.2.19: 
> 584.462user 
> 57.492system 
> 385.112elapsed 
> 166.5%CPU
> 
> > 2.4.12: 
> 582.318user 
> 40.535system 
> 337.093elapsed 
> 184.5%CPU
> 
> ???

what's the question?  you just reformatted my results.

> If so, then 2.4.12 won on user, system and elapsed.  

of course: that's the point.  but elapsed is where the big difference is,
and that's what's interesting, since it reflects less dead time due to 
smarter/less swapping.

> What's with the CPU
> percentage?  Are you on a dual system?

yes, of course: the bp6 is a dual, with cel/366's in this case.
I don't think SMPness is relevant here.

> > notice that elapsed is noticably faster even than the 1+17 second
> > benefit to user and system times.  Rik's VM seems to be slightly
> 
> No, that's Andrea's VM (since 2.4.10pre11).  Rik's is in 2.4.xx-ac.

no, my statement is correct; I merely didn't give stats for Rik's VM.

