Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284507AbRLRTnn>; Tue, 18 Dec 2001 14:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284696AbRLRTni>; Tue, 18 Dec 2001 14:43:38 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:56324 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S284507AbRLRShc>; Tue, 18 Dec 2001 13:37:32 -0500
Date: Tue, 18 Dec 2001 12:37:24 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Dead2 <dead2@circlestorm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011218123724.A32316@asooo.flowerfire.com>
In-Reply-To: <E16GLmv-0007d4-00@the-village.bc.nu> <026701c187d5$ec2472c0$67c0ecd5@dead2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <026701c187d5$ec2472c0$67c0ecd5@dead2>; from dead2@circlestorm.org on Tue, Dec 18, 2001 at 04:09:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The CVS tree availability you mention parallels the FreeBSD tree, I
believe.  However, assuming enough brain cycles, one knowledgable
maintainer seems to be a better method of maintaining a kernel.

Having one person maintain the entire CVS tree for an OS would be
laughable, but in the case of a kernel you have much tighter control
over what goes into a smaller, more delicate tree, with maintainers who
have access to hardware for device driver implementation, etc.
Especially when this person is a Linus/Alan/Marcelo, etc.

I've been following lkml for some time now, and I've been using patches
that get posted to the list.  But I do so at my own risk, since I do not
have comprehensive knowledge of kernel internels.  But even I can tell
that many of the patches posted are either bogus, are potentially
incorrect in subtle and/or complex ways, or are simply working around
user-space issues or other bugs.

There have been discussions on this list (and several off) about how
patches are dropped, ignored, etc.  Part of this is due to what Linus
himself described as a conservative stabilization of 2.4 given VM and
other issues.  I believe the other part is that one person (Marcelo in
this case) will have a hard time taking something as verbose as lkml
(plus the plethora of direct email that he must receive) and weed out
the noise from the signal.  And then possibly having to spend time
finding a maintainer or someone knowledgable about a certain specific
area of the kernel to see if the signal is legitimate.

I think Alan compiled a ton of very useful stuff in the 2.4-ac series,
but (maybe he'll agree with my bs here :) I think 2.2-mainline and
2.4-mainline require different trade-offs.

What might take out a few birds with one stone is to have someone on
lkml become an "LKML MAINTAINER": collect patches and bug reports in a
central place.  This would include:

	1) The patch and/or bug report
	2) The entire LKML thread, with "important" messages marked
	3) Personal input, prioritization, severity info, etc.

This could be a bugtraq type site, or webrt, or something along those
lines.  Something like kernel traffic, but useful. ;-) ;-)

What this gives is a very succinct source of data for the key kernel
developers and maintainers who don't necessarily have time to weed
through lkml -- they can check the web site occasionally, or even fairly
frequently, and spend a very minimal amount of time glancing through for
anything that sounds relevant.

I think this would also be a good place to track which patches make it
into stable vs. development kernels (2.4.x vs 2.5.x right now).  But
this would NOT necessarily have crossover with the maintainers -- this
compilation would be unofficial and for informational purposes only.

This lkml maintainer would NOT be the sole source of lkml output --
clearly the public and direct sharing of patches should continue, but I
think compiling the best bits of lkml is 99% of the battle.

Just my two cents.  If enough of the relevant folks think this is
worthwhile, I might try to set this up (in my free time between 24 and
27 hours a day...) since I'm already doing a small subpart of this for
my own purposes.

Thx,
-- 
Ken.
brownfld@irridia.com


On Tue, Dec 18, 2001 at 04:09:00PM +0100, Dead2 wrote:
| > > > 1. Are we satisfied with the source code control system ?
| > >
| > > Yes.  Alan (2.2) and Marcelo (2.4) and Linus (2.5) are doing
| > > a good job with source control.
| >
| > Not really. We do a passable job. Stuff gets dropped, lost,
| > deferred and forgotten, applied when it conflicts with other work
| > - much of this stuff that software wouldnt actually improve on over a
| > person
| 
| What about having the Linux source code in a CVS tree where active/trusted
| driver-/module-maintainers are granted write access, and everyone else read
| access.
| After the patches are applied, people will test them out, and bugfixes will
| be applied when bugs are detected.
| Then, when the kernel-maintainer feels this or that sourcecode is ready for a
| .pre kernel, he puts it in the main kernel tree.
| (This would indeed pose a security risk, but who in their right mind would run
|  a CVS snapshot on anything important, that's right _noone_ in their _right
| mind_)
| 
| Of course this would require much maintenance, and possibly more than
| one kernel-maintainer. This because of how much easier it would become
| for driver-/module-maintainers to apply patches they believe would make
| things better. Cleanups would also be necessary from time to time..
| (cleanups = making the CVS identical to the main kernel tree again)
| 
| Just my 2 cents..
| 
| -=Dead2=-
| 
| 
| 
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
