Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289339AbSBEHe7>; Tue, 5 Feb 2002 02:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289340AbSBEHet>; Tue, 5 Feb 2002 02:34:49 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:43911 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289339AbSBEHef>; Tue, 5 Feb 2002 02:34:35 -0500
Message-Id: <200202042014.g14KE8gL001417@tigger.cs.uni-dortmund.de>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
In-Reply-To: Message from Keith Owens <kaos@ocs.com.au> 
   of "Mon, 04 Feb 2002 10:34:48 +1100." <15269.1012779288@ocs3.intra.ocs.com.au> 
Date: Mon, 04 Feb 2002 21:14:08 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> said:
> On Fri, 01 Feb 2002 14:42:11 +0100, 
> Horst von Brand <brand@jupiter.cs.uni-dortmund.de> wrote:
> >Keith Owens <kaos@ocs.com.au> said:
> >> I know, it makes it even harder to see what the initialization order
> >> is.  Some are controlled by the Makefile/subdirs order, some by special
> >> calls in the code.

> >Just to repeat myself: This is clearly a problem for tsort(1): Give
> >restrictions of the form "This has to come after that" (perhaps a special
> >comment at the start of the file containing the init function?), tsort that
> >and pick the order out of the result. Should be a few lines of script. No
> >central repository for the dependencies, no messing around with half the
> >world to fix dependencies. Plus they become explicit, which they aren't
> >today.

> Just to repeat myself: That is exactly what I want to do.  Linus vetoed
> it in October 2000.

Right. And I still think Linus is dead wrong here. IMVVHO.
-- 
Horst von Brand			     http://counter.li.org # 22616
