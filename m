Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315259AbSEYTVY>; Sat, 25 May 2002 15:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315263AbSEYTVX>; Sat, 25 May 2002 15:21:23 -0400
Received: from dsl-213-023-040-043.arcor-ip.net ([213.23.40.43]:21711 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315259AbSEYTVX>;
	Sat, 25 May 2002 15:21:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Wolfgang Denk <wd@denx.de>, Kurt Wall <kwall@kurtwerks.com>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Date: Sat, 25 May 2002 21:21:08 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020525181402.E675611972@denx.denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Bh6D-0003nH-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 May 2002 20:13, Wolfgang Denk wrote:
> In message <20020525134709.L405@marta> Kurt Wall wrote:
> > 
> > > You can dimiss those who haven't chosen #4 as much as you want and
> > > find all the reasons to justify your dismissal. It remains that the
> > > embedded/rt market is closed to Linux because of the current situation.
> > 
> > That dog won't hunt. There are more players in the Linux embedded/RT space
> > than RTAI and RTLinux, which you have conveniently overlooked throughout
> > this entire thread. Maybe at this time none of them are ready for $300
> > IPO pops, but you can't make the argument that "RT is closed to Linux"
> > when your only data points are RTAI and RTLinux.
> 
> ...which are the only available free / GPL solutions. This is  reason
> enough  to  be  scared.  And  some  versions  of RTLinux are not even
> available under  GPL  (like  RTLinux  for  MPC8xx  CPUs).  RTAI  _is_
> available,  and  under  GPL, but the reputation is suffering under he
> patent FUD.

Speaking for myself, this thread has completely changed my perception of
RTAI.  And yes, I am one of those who was taken in by the FUD.  Thankyou
to Karim for presenting the facts logically, with patience and restraint,
and I apologize for having listened overly much to the makers of the
greatest noise.

I'm particularly interested in the notion that properties we normally
think of as exclusively the domain of the kernel can be extended to user
space, in the way that RTAI creates a mechanism for hard realtime
scheduling, then extends it beyond the boundaries of the kernel.  Such
extension of a state machine rooted in the kernel is powerful and
useful.

When we blur the boundaries of the kernel in this way, we invite the
question: what is the kernel, really?  I see the function of the kernel
as being increasingly concerned with security, and the real heavy
lifting increasingly being carried out in user space, with only
occasional need to cross the kernel boundary, and that mainly for the
purpose of initializing some mechanism that allows work to be done
in user space.

An recent example of this trend is the work on user-space semaphores.  A
less recent example is the X15 html daemon, which reportedly outperforms
the in-kernel TUX daemon.

-- 
Daniel
