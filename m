Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270571AbRHWVcs>; Thu, 23 Aug 2001 17:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270528AbRHWVci>; Thu, 23 Aug 2001 17:32:38 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:39819
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S270521AbRHWVc1>; Thu, 23 Aug 2001 17:32:27 -0400
Date: Thu, 23 Aug 2001 14:32:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010823143240.E14302@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <E15a1mD-000M4n-00@f10.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15a1mD-000M4n-00@f10.mail.ru>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2001 at 01:12:33AM +0400, Samium Gromoff wrote:
> > The main reason to include it, is that that's what it was done in.
> > If you go back and read the archives, ESR goes over why all sorts of
> > other languages wouldn't work as easily.
>
> in such cases the solution is to elaborate, and not to
> leave things to decay.

Well, the flames finally died down and everyone forgot about it again
for a while.

> > That wasn't my point at all.  My point was that if you're somehow
> > transfering the 21mb source .tar.bz2'ed, you can also stand to transport
> > the 4mb of python 2.0.1 source, tar.gz'ed over as well.  In other words,
> > having to bring python over any of the methods that Jes mentioned isn't
> > any more painful than the kernel source.  It's roughly the size of a couple
> > of vmlinux'es.
>   i was sarcastic here. actually the fact is that
>   4MB of tarred sources is more than 10 .c files
>   doing the same thing 1.5x times faster.

Where'd you get 1.5x from? :)  But, go ahead and re-write the CML2 engine
in C.  There's been some work done on this.  A few people (Al Viro?) even
said that if this got into 2.5 they'd do a 'C' version.  Many many months
ago, if i recall correctly.

> > Have you tried cml2 on your p166?  ESR went and did much speed tweaking of
> > the code about 6 months ago it seems like and managed to please some of the
> > people using a low-end pentium.  Building a kernel on a 386 isn't approcaching
> > tolerable right now anyhow.  Someone pointed out today or yesterday it takes
> > ~10 days.
>   it is not an excuse to make things even worser.

It shouldn't be a consideration at all.  I'd go as far as to say any sort of
speed bonus on a 486 is gravy.  In other words, how fast something will be
on 10 year old hardware shouldn't be important (I'm speaking of 386 with
10 years.)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
