Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315794AbSE2XmH>; Wed, 29 May 2002 19:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315792AbSE2XmG>; Wed, 29 May 2002 19:42:06 -0400
Received: from dsl-213-023-039-142.arcor-ip.net ([213.23.39.142]:23220 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315794AbSE2XlR>;
	Wed, 29 May 2002 19:41:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Tomas Szepe <szepe@pinerecords.com>, Nicolas Pitre <nico@cam.org>
Subject: Re: 2.5.19 - What's up with the kernel build?
Date: Thu, 30 May 2002 01:40:46 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CF540F8.6000802@mandrakesoft.com> <Pine.LNX.4.44.0205291827130.23147-100000@xanadu.home> <20020529230657.GB2851@louise.pinerecords.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17DD3f-0006q5-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 May 2002 01:06, Tomas Szepe wrote:
> > > Well, I really like Keith's kbuild25 too, but Linus said (at least once) 
> > > he wanted an evolution to a new build system... not an unreasonable 
> > > request to at least consider.  Despite Keith's quality of code (again -- 
> > > I like kbuild25), his 3 patch submissions seemed a lot like ultimatums, 
> > > very "take it or leave it dammit".  Not the best way to win friends and 
> > > influence people.

OK that's true, but think: how much work has Keith put into this?  How much
did he or his employer get paid?  And how many times has he been told to go
off and fix something, as a prelude to getting the thing in?  The last time
it was the first-time build speed.  He went away and came back with a *huge*
improvement, even more than what people were demanding.  You'd think that
would be enough.

Keith has to do *two* full time jobs as long as the patch isn't merged:
developing the patch itself and tracking the whole 2.5 tree as it (rapidly)
evolves.

> > > If Keith is indeed leaving it, I'm hoping someone will maintain it, or 
> > > work with Kai to integrate it into 2.5.x.
> > 
> > When I suggested to Keith he push kbuild25 the way Linus likes, he (Keith) 
> > considered that was a "stupid comment" and that he'd ignore stupid comments.

It is of course always regrettable when one is so rash as to call a stupid
comment a stupid comment ;-)

> What remains to be answered is, how does one split a system of a myriad of
> build rule files into a reasonable amount of small patches.
> 
> Of course, you could have hundreds of patches each consisting of a single
> Makefile.in, but how would that make the reviewing/integrating easier? In
> the end you'd end up reading the same input, only you'd complement it by
> frequently pressing your favorite show-me-the-next-mail key.

I thought BitKeeper was supposed to be able to deal with precisely this sort
of merge problem.  In this case, splitting the thing up just seems
unnatural, and a dubious use of time.

-- 
Daniel
