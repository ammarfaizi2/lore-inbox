Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281144AbRKZFdl>; Mon, 26 Nov 2001 00:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281173AbRKZFd3>; Mon, 26 Nov 2001 00:33:29 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:63225
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281144AbRKZFdR>; Mon, 26 Nov 2001 00:33:17 -0500
Date: Sun, 25 Nov 2001 21:33:11 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.5/2.6/2.7 transition [was Re: Linux 2.4.16-pre1]
Message-ID: <20011125213311.A4593@mikef-linux.matchmail.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011125155323.D30336@mikef-linux.matchmail.com> <Pine.LNX.4.33.0111251946400.9764-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111251946400.9764-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2001 at 07:58:41PM -0800, Linus Torvalds wrote:
> 
> On Sun, 25 Nov 2001, Mike Fedyk wrote:
> >
> > Personally, I think that 2.4 was released too early.  It was when the
> > Internet hype was going full force, and nobody (including myself) could be
> > faulted for getting swept up in the wave that it was.
> 
> That's not the problem, I think.
> 
> 2.4.0 was appropriate for the time. The problem with _any_ big release is
> that the people you _really_ want to test it won't test it until it is
> stable, and you cannot make it stable before you have lots of testers. A
> basic chicken-and-egg problem, in short.
>

True.

> You find the same thing (to a smaller degree) with the pre-patches, where
> a lot more people end up testing the non-pre-patches, and inevitably there
> are more percieved problems with the "real" version than with the
> pre-patch. Just statistically you should realize that that is not actually
> true ;)
>

Unless you look at the *very* small amount of time between 2.4.15-pre9 and
-final.  As noted by Rusty (first one to come to mind)...  But what is done
is history.

> > 1) Develop 2.5 until it is ready to be 2.6 and immediately give it over to
> > a maintainer, and start 2.7.
> 
> I'd love to do that, but it doesn't really work very well. Simply because
> whenever the "stable" fork happens, there are going to be issues that the
> bleeding-edge guard didn't notice, or didn't realize how they bite people
> in the real world.
> 
> So I could throw a 2.6 directly over the fence, and start a 2.7 series,
> but that would have two really killer problems
> 
>  (a) I really don't like giving something bad to whoever gets to be
>      maintainer of the stable kernel. It just doesn't work that way:
>      whoever would be willing to maintain such a stable kernel would be a
>      real sucker and a glutton for punishment.
> 
>  (b) Even if I found a glutton for punishment that was intelligent enough
>      in other ways to be a good maintainer, the _development_ tree too
>      needs to start off from a "known reasonably good" point. It doesn't
>      have to be perfect, but it needs to be _known_.
> 
> For good of for bad, we actually have that now with 2.4.x - the system
> does look fairly stable, with just some silly problems that have known
> solutions and aren't a major pain to handle. So the 2.5.x release is off
> to a good start, which it simply wouldn't have had if I had just cut over
> from 2.4.0.
>
> The _real_ solution is to make fewer fundamental changes between stable
> kernels, and that's a real solution that I expect to become more and more
> realistic as the kernel stabilizes. I already expect 2.5 to have a _lot_
> less fundamental changes than the 2.3.x tree ever had - the SMP
> scaliability efforts and page-cachification between 2.2.x and 2.4.x is
> really quite a big change.
>

Thank you.

Now all we need is a road map for the next ten or so dev kernels and many of
the questions will be answered...  What patches will go in what version, and
in what order?

> But you also have to realize that "fewer fundamental changes" is a mark of
> a system that isn't evolving as quickly, and that is reaching middle age.
> We are probably not quite there yet ;)
> 

Yep.  It looks like there are some rather large changes in the works for 2.5
though.  Time will tell, and a LWN news story in about 1-2 years will be very
insteresting indeed.

MF
