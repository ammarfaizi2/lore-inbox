Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317347AbSFLDut>; Tue, 11 Jun 2002 23:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317349AbSFLDus>; Tue, 11 Jun 2002 23:50:48 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:13280 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317347AbSFLDur>; Tue, 11 Jun 2002 23:50:47 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, dent@cosy.sbg.ac.at,
        adilger@clusterfs.com, da-x@gmx.net, patch@luckynet.dynu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 - list.h cleanup 
In-Reply-To: Your message of "Tue, 11 Jun 2002 10:54:04 MST."
             <E17HpqG-000454-00@w-gerrit2> 
Date: Wed, 12 Jun 2002 13:49:00 +1000
Message-Id: <E17Hz8A-0003oC-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E17HpqG-000454-00@w-gerrit2> you write:
> In message <Pine.LNX.4.44.0206110128130.1987-100000@home.transmeta.com>, > : 
Li
> nus Torvalds writes:
> > 
> > 
> > On Tue, 11 Jun 2002, Rusty Russell wrote:
> > >
> > > Worst sin is that you can't predeclare typedefs.  For many uses (not the
> > > list macros of course):
> > > 	struct xx;
> > > is sufficient and avoids the #include hell,
> > 
> > True.
> 
> Untrue.  Or partially true (yes, you *can* use struct xx;).
> 
> But you can also use:
> 
> typedef foo_t;

Huh?  In what language?  Try it with -Wall to see what you're really
doing here, and think about what happens when you put that in one
header, and the real typedef in another.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
