Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315910AbSE3AST>; Wed, 29 May 2002 20:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315893AbSE3ASS>; Wed, 29 May 2002 20:18:18 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:43675
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S315870AbSE3ASQ>; Wed, 29 May 2002 20:18:16 -0400
Date: Wed, 29 May 2002 20:17:58 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Thunder from the hill <thunder@ngforever.de>,
        Tomas Szepe <szepe@pinerecords.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Paul P Komkoff Jr <i@stingr.net>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.19 - What's up with the kernel build?
In-Reply-To: <E17DD3f-0006q5-00@starship>
Message-ID: <Pine.LNX.4.44.0205291947170.23147-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2002, Daniel Phillips wrote:

> On Thursday 30 May 2002 01:18, Nicolas Pitre wrote:
> 
> > Or maybe people just don't care enough about the build system for kbuild25
> > to be worth it...
> 
> Omigod, don't even think that.  Kbuild 2.5 is faster and better than the
> current kbuild.  I, for one, am waiting - impatiently - for the thing to get
> in the tree.  The current build system is slow and unreliable, and don't even
> think of trying to build two different architectures in the same source tree
> at the same time.

I totally agree with you.

Then let me rephrase it that way: maybe not enough people care enough about
the build system for kbuild25 to be worth it...

> > > > Well, I really like Keith's kbuild25 too, but Linus said (at least once) 
> > > > he wanted an evolution to a new build system... not an unreasonable 
> > > > request to at least consider.  Despite Keith's quality of code (again -- 
> > > > I like kbuild25), his 3 patch submissions seemed a lot like ultimatums, 
> > > > very "take it or leave it dammit".  Not the best way to win friends and 
> > > > influence people.
> 
> OK that's true, but think: how much work has Keith put into this?  How much
> did he or his employer get paid?  And how many times has he been told to go
> off and fix something, as a prelude to getting the thing in?  The last time
> it was the first-time build speed.  He went away and came back with a *huge*
> improvement, even more than what people were demanding.  You'd think that
> would be enough.

But is it really enough?

Linus himself once said: "Especially as I don't find the existign system so
broken." He's not alone according to the amount (or lack) of public
complains with regards to the current system.

> > Of course, you could have hundreds of patches each consisting of a single
> > Makefile.in, but how would that make the reviewing/integrating easier? In
> > the end you'd end up reading the same input, only you'd complement it by
> > frequently pressing your favorite show-me-the-next-mail key.
> 
> I thought BitKeeper was supposed to be able to deal with precisely this sort
> of merge problem.  In this case, splitting the thing up just seems
> unnatural, and a dubious use of time.

Indeed, I agree.

But until there is enough people committed to kb25 to the point of pushing
for its wider adoption, either by releasing traditional kernel patches (like
the -dj, -aa, -ac or whatever) actually carrying kb25 so to convince Linus
and others, or producing "piecemeal" patches so it can be merged by Linus
with less resistance, well nothing will hapen.

If people aren't interested enough and/or willing to comply with Linus'
requirements this will be a sad dead end, regardless the amount of effort
Keith put into this.


Nicolas

