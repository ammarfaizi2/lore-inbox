Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315929AbSE3AhK>; Wed, 29 May 2002 20:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315941AbSE3AhJ>; Wed, 29 May 2002 20:37:09 -0400
Received: from dsl-213-023-039-142.arcor-ip.net ([213.23.39.142]:4533 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315929AbSE3AhI>;
	Wed, 29 May 2002 20:37:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Nicolas Pitre <nico@cam.org>
Subject: Re: 2.5.19 - What's up with the kernel build?
Date: Thu, 30 May 2002 02:36:39 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Thunder from the hill <thunder@ngforever.de>,
        Tomas Szepe <szepe@pinerecords.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Paul P Komkoff Jr <i@stingr.net>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205291947170.23147-100000@xanadu.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17DDvk-0006qp-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 May 2002 02:17, Nicolas Pitre wrote:
> On Thu, 30 May 2002, Daniel Phillips wrote:
> > > > > Well, I really like Keith's kbuild25 too, but Linus said (at least once) 
> > > > > he wanted an evolution to a new build system... not an unreasonable 
> > > > > request to at least consider.  Despite Keith's quality of code (again -- 
> > > > > I like kbuild25), his 3 patch submissions seemed a lot like ultimatums, 
> > > > > very "take it or leave it dammit".  Not the best way to win friends and 
> > > > > influence people.
> > 
> > OK that's true, but think: how much work has Keith put into this?  How much
> > did he or his employer get paid?  And how many times has he been told to go
> > off and fix something, as a prelude to getting the thing in?  The last time
> > it was the first-time build speed.  He went away and came back with a *huge*
> > improvement, even more than what people were demanding.  You'd think that
> > would be enough.
> 
> But is it really enough?
> 
> Linus himself once said: "Especially as I don't find the existign system so
> broken." He's not alone according to the amount (or lack) of public
> complains with regards to the current system.

I think a lot of us were not complaining because we thought it was a done deal.
Now what's necessary, do we have to form cheerleading teams and start lobbying
to get what we thought was coming anyway?  It's really not a pleasant feeling
to be put in that position.  Nobody relishes the role of outspoken advocate of
this or that, at least I do not.  I'd *much* rather be hacking.

> > > Of course, you could have hundreds of patches each consisting of a single
> > > Makefile.in, but how would that make the reviewing/integrating easier? In
> > > the end you'd end up reading the same input, only you'd complement it by
> > > frequently pressing your favorite show-me-the-next-mail key.
> > 
> > I thought BitKeeper was supposed to be able to deal with precisely this sort
> > of merge problem.  In this case, splitting the thing up just seems
> > unnatural, and a dubious use of time.
> 
> Indeed, I agree.
> 
> But until there is enough people committed to kb25 to the point of pushing
> for its wider adoption, either by releasing traditional kernel patches (like
> the -dj, -aa, -ac or whatever) actually carrying kb25 so to convince Linus
> and others, or producing "piecemeal" patches so it can be merged by Linus
> with less resistance, well nothing will hapen.

You've got it backwards.  The function of the maintainers you mentioned is
to *resist* change, not promote it.  In this case, change comes from the top,
and as long as Linus doesn't realize that there really is a lot of demand
for this change, nothing is going to happen.

> If people aren't interested enough and/or willing to comply with Linus'
> requirements this will be a sad dead end, regardless the amount of effort
> Keith put into this.

Now wait, it seems to me that only Keith is being asked to comply with
requirements, and they're tough requirements.  The burden is just not
being shared equally.

-- 
Daniel
