Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281484AbRKMFPZ>; Tue, 13 Nov 2001 00:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281487AbRKMFPN>; Tue, 13 Nov 2001 00:15:13 -0500
Received: from mail104.mail.bellsouth.net ([205.152.58.44]:18970 "EHLO
	imf04bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281484AbRKMFPH>; Tue, 13 Nov 2001 00:15:07 -0500
Message-ID: <3BF0AC47.221B6CD6@mandrakesoft.com>
Date: Tue, 13 Nov 2001 00:14:47 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <200111130324.fAD3OE916102@vindaloo.ras.ucalgary.ca>
		<Pine.GSO.4.21.0111122249160.22925-100000@weyl.math.psu.edu>
		<200111130358.fAD3wgb16617@vindaloo.ras.ucalgary.ca>
		<3BF09E44.58D138A6@mandrakesoft.com>
		<200111130437.fAD4b2j17329@vindaloo.ras.ucalgary.ca>
		<3BF0A788.8CCBC91@mandrakesoft.com> <200111130500.fAD50Wi17879@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Jeff Garzik writes:
> > Richard Gooch wrote:
> > > > Among other reasons, because of long term maintenance.
> > > >
> > > > How do you expect others in the Linux kernel community to review
> > > > your code, if it is widely considered difficult to read?  How do you
> > > > expect people to maintain your code when are no longer around?  The
> > > > Linux kernel will be around long after you and I and others leave
> > > > kernel development.  Others need to read and maintain this code.
> > >
> > > If and when I step down as maintainer (if I do so, I'll publically
> > > pass the baton to the new maintainer), the new maintainer can indent
> > > to their preference. Until that time, *I'm* the maintainer, and *I*
> > > need to be able to read the code efficiently. It's the part of the
> > > kernel I spend the most time in, after all.
> >
> > You argue that others reviewing your code is worthless?
> > That you are the only one reading your code?
> 
> I didn't say that at all! But since I'm the one maintaining that code,
> it makes sense that it's easiest for me to read, since I'm the most
> frequent reader (and writer).
> 
> But that's beside the point. Linus has stated that he doesn't want to
> force coding style upon others, unless it's something that he has to
> maintain. Since he doesn't maintain devfs, that doesn't apply.
> 
> If Linus makes the decision to change that policy, and *force* all
> code into the one style, I'll have to put up with that, although I'll
> grumble. And I'll scream blue murder if it's just *my* code that gets
> changed; I note that not all of the kernel conforms to Linus'
> preferred style. Right now I feel picked on.

There's a difference between telling you what to think, and trying to
point out why your methods are flawed.  I also would never presume to
tell anyone what to think or do; I am trying to emphasize here that your
choice makes it difficult to review the code, and affects the long-term
maintainability of the codebase overall.  It wouldn't really be an issue
if the code weren't so far from CodingStyle that everyone else is used
to.

Is a compromise possible?  Can you keep a local codebase in your own
coding style, and then run Lindent before sending to Linus?

Ideally in 2.5 devfs (or some form thereof) is gonna be the centerpiece
of our new and wonderful dynamic device world.  It would be nice if that
was what the majority consider readable code...

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

