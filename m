Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282513AbRKZUvx>; Mon, 26 Nov 2001 15:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282490AbRKZUur>; Mon, 26 Nov 2001 15:50:47 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53767 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S282503AbRKZUtE>; Mon, 26 Nov 2001 15:49:04 -0500
Date: Mon, 26 Nov 2001 15:42:29 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: David Relson <relson@osagesoftware.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Releases
In-Reply-To: <4.3.2.7.2.20011124231412.00b40c50@mail.osagesoftware.com>
Message-ID: <Pine.LNX.3.96.1011126151758.27112G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2001, David Relson wrote:

I wish you luck. About 18 months ago I offered to set up a testing group
to take kernel source before it with up for ftp and to compile it on
various x86, SPARC{32,64}, and ALPHA machines to be sure it would at least
compile. I was told with varying degrees of rudeness that it would delay
the releases (that is a GOOD thing in stable kernels), and that I should
avoid the 2.4 series and use the "stable" 2.2 kernsls (2.4 IS a stable
kernel of course, although you would never gues it).
 
> Over the past few months, I've been listening in on LKML, with occasional, 
> minor comments - mostly to help newbies.  Now, I think it's time for a 
> suggestion ...
> 
> As we all know, several of the recent releases have had defects that have 
> __required__ patches before they could be built (or used safely).  Problems 
> with symlinks, loopbacks, and unmount come to mind as being like 
> this.  They are all show stoppers that required immediate fixes and the 
> creation of a new release or of the next -pre1 version.
> 
> I have a tendency to tink that it's better to be running a released kernel, 
> than a pre-release kernel.  I'd much rather be running a kernel named 2.4.x 
> than a kernel named 2.4.y-pre?.  With the recent problems, the working 
> versions tend to be the -pre1 or -pre2 releases, not the released 
> one.  With a bit of QA, I think we can have 2.4.x releases be the stable 
> releases.  Here's how...
> 
> When the kernel maintainer, now Marcelo for 2.4, is ready to release the 
> next kernel, for example 2.4.16, I suggest he switch from "pre?" to "-rc1" 
> (as in release candidate).  A day or two with -rc1 will quickly show if it 
> has a show stopper.  If so, then the minor fixes (and nothing else) go into 
> -rc2.  A day or two ..., and either -rc3 appears or we have a stable 
> release and 2.4.16 is ready to be released.

I do agree, of course. There's no reason to avoid -pre releases, but
having -rc versions would be really useful because people who are waiting
for features would then be motivated to test, knowing that only fixes will
be applied. NOTE: this might mean that 2.4.18-pre1 would be out before
2.4.17 was actually released. That may bother some people.

A stable kernel should have only new drivers and not a whole new VM, at
least until it is in a development series and has been tested. If it were
up to me I would have opened 2.5 when 2.4.0 was released, and all the VM
stuff would have happened there. That's just the way I would assure
stability, knowing that there is no lack of people to test Linux kernels
no matter how unstable and patched... But a little truth in labeling would
be nice, recently the "really stable" kernels were -ac, and that's
probably not desirable.

Maybe the time is right to separate -pre and -rc and let people who who
want to test choose which, if either, they want to try. Some stuff really
MUST be tested on production machines (the recent VM versions, for
instance) to see which performs better and provide useful feedback.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

