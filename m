Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262970AbTJJReW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 13:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbTJJReV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 13:34:21 -0400
Received: from agminet02.oracle.com ([141.146.126.229]:34968 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S262970AbTJJReB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 13:34:01 -0400
Date: Fri, 10 Oct 2003 10:33:44 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-ID: <20031010173344.GC29301@ca-server1.us.oracle.com>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Ulrich Drepper <drepper@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031010162606.GB28773@ca-server1.us.oracle.com> <Pine.LNX.4.44.0310100939300.20420-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310100939300.20420-100000@home.osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 09:50:02AM -0700, Linus Torvalds wrote:
> The fact is, the high end is getting smaller and smaller. If Oracle wants 
> to go after that high-end-only market, then be my guest. 

	No, the high-end for hardware is getting smaller.  The need for
high-end jobs is just fine.  But as you point out, the high-end jobs are
being done by low-end hardware.  And here is Oracle, promoting a bank of
cheap-ass 2-way boxen to do the job.

> Have you guys learnt _nothing_ from the past? The reason MicroSoft and
> Linux are kicking all the other vendors butts is that _small_ is
> beautiful. Especially when small is "powerful enough".

	Again, we need this sort of stuff precisely because we'd rather
use 2 $5k Linux/Intel servers than 1 $40k Sun server (and the Linux box
outruns the Sun, quite comfortably).  That's the "powerful enough",
right there.

> And believing that the load will keep up with "big iron hardware" is just 
> not _true_. It's never been true. "Small iron" not only keeps up, but 
> overtakes it - to the point where you have to start doing new things just 
> to be able to take advantage of it.

	Linus, I've said it twice above.  This has been our entire
direction for the past couple years, and we've been loud about it.
Please, knock us for what we do wrong, but recognize what we are
actually doing wrong, not what you think we are doing.

> Ok. Let's just hope all the crackers and virus writers believe you when 
> you say "you shouldn't do that".

	Well, if a cracker and virus writer can get enough priviledge to
write(), cached or O_DIRECT, they can corrupt you without worrying about
this specific gotcha.  That doesn't mean you don't fix it, but it also
doesn't mean you throw up your hands and claim you can't do it.

> BIG FRIGGING HINT: a _real_ OS doesn't allow data corruption even for
> cases where "you shouldn't do that". It shouldn't allow reading of data
> that you haven't written. And "you shouldn't do that" is _not_ an excuse
> for having bad interfaces that cause problems.

	I know that, I agree with it, and I said as much a few emails
past.  Linux should refuse to corrupt your data.  But you've taken the
tack "It is unsafe today, so we should abandon it altogether, never mind
fixing it.", which doesn't logically follow.

Joel

-- 

"Behind every successful man there's a lot of unsuccessful years."
        - Bob Brown

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
-- 

"When choosing between two evils, I always like to try the one
 I've never tried before."
        - Mae West

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
