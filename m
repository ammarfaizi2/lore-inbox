Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315619AbSEZDpx>; Sat, 25 May 2002 23:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315627AbSEZDpw>; Sat, 25 May 2002 23:45:52 -0400
Received: from stm.lbl.gov ([131.243.16.51]:22021 "EHLO stm.lbl.gov")
	by vger.kernel.org with ESMTP id <S315619AbSEZDpv>;
	Sat, 25 May 2002 23:45:51 -0400
Date: Sat, 25 May 2002 20:45:42 -0700
From: David Schleef <ds@schleef.org>
To: Larry McVoy <lm@work.bitmover.com>, David Schleef <ds@schleef.org>,
        Karim Yaghmour <karim@opersys.com>, Larry McVoy <lm@bitmover.com>,
        Wolfgang Denk <wd@denx.de>, linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020525204542.A10392@stm.lbl.gov>
Reply-To: David Schleef <ds@schleef.org>
In-Reply-To: <20020525110208.A15969@work.bitmover.com> <20020525182617.D627E11972@denx.denx.de> <20020525114426.B15969@work.bitmover.com> <3CEFEB73.5BB2C14C@opersys.com> <20020525133637.B17573@work.bitmover.com> <20020525190913.A6869@stm.lbl.gov> <20020525201749.A19792@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 08:17:49PM -0700, Larry McVoy wrote:
> On Sat, May 25, 2002 at 07:09:13PM -0700, David Schleef wrote:
> > I checked RTAI vs. RTLinux, and it turned up 2 things: an example
> > written by Jerry Epplin, and the implementation of rt_printk(),
> > which was written by me.  Neither of these were "originally" in
> > RTLinux, they were both "originally" posted to the RTLinux mailing
> > list.
> > 
> > There was one more match that was publicly claimed as copying by
> > the maintainer of RTLinux -- a few fields in the scheduler structure.
> > The script caught those, too, once I set the threshhold down to 3
> > lines, which also picked up hundreds of mismatches.  
> 
> Good luck making that stick in court.  First of all, the RTAI guys have
> admitted over and over that RTAI is a fork of the RTLinux source base.

Paolo (the maintainer) hasn't.  I (the second largest contributor)
hasn't.  I understand why others talk about RTAI and RTLinux forking,
since the _projects_ forked, and the _ideas_ forked, but the _code_
was always separate.  At some point, a person gives up trying to
argue the point, and just says "it forked".  But when you get down
to brass tacks, there was no code fork, because there was never one
code base.

There was some sharing of code in the beginning, typically code that
was sent to the RTLinux mailing list by third parties.  In that case,
the code was copyrighted by the individual.  The fact that it later
showed up in RTLinux as "copyright VJY associates" does not change
the fact that Paolo got it from the original author.

> Your claims that that isn't true are countered by principles from both
> parties in question.  Second of all, both source bases have evolved 
> since the fork.  Whether your script catches the common heritage or 
> not has no meaning, the fact remains that one is derived from the
> other, and as such has to be GPLed.

Oh yeah -- I forgot to mention that I was talking about comparing
the original version of RTAI and the contemporary version of RTLinux.
I also checked a number of other combinations, including the last
version of RTLinux that Paolo says that he looked at, and recent
RTAI releases.

I'm not claiming that RTAI is 100% perfect with respect to licensing.
But I have spend many weeks in the past chasing down alleged
plagiarism problems, and I can't find any.  So I'm relatively
certain.

I actually _do_ my research.



dave...

