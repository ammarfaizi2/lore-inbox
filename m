Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSEaBYW>; Thu, 30 May 2002 21:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314227AbSEaBYV>; Thu, 30 May 2002 21:24:21 -0400
Received: from dsl-213-023-038-015.arcor-ip.net ([213.23.38.15]:37086 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314149AbSEaBYU>;
	Thu, 30 May 2002 21:24:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Skip Ford <skip.ford@verizon.net>
Subject: Re: KBuild 2.5 Impressions
Date: Fri, 31 May 2002 03:24:00 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200205302155.g4ULtEb09500@buggy.badula.org> <E17Daa5-0007iZ-00@starship> <20020531011600.ENOZ28280.pop018.verizon.net@pool-141-150-239-239.delv.east.verizon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Db96-0007iy-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 May 2002 03:20, Skip Ford wrote:
> Daniel Phillips wrote:
> > On Friday 31 May 2002 02:13, Kenneth Johansson wrote:
> > > On Fri, 2002-05-31 at 01:19, Daniel Phillips wrote:
> > > > 
> > > > I think that with these breakups done the thing would be sufficiently
> > > > digestible to satisfy Linus.  Now that I think of it, Linus's request
> > > 
> > > Maybe I'm the idiot here but what dose this gain you??
> > >
> > > The reason to break up a patch is not simply to get more of them. There
> > > is no point in splitting if you still need to use every single one of
> > > them to make anything work. 
> > 
> > See above.  It's all about analyzing the structure of the patch.  To be
> > fair though, it took me less than an hour to get a pretty good idea of
> > how the current patch set is structured.
> 
> I could be wrong but I think Linus wants small patches that slowly
> convert kbuild24 to kbuild25, and not just a chopped up wholesale
> kbuild25.

I hope you're wrong, because that does not sound reasonable.  On the other
hand, the two build systems coexist quite happily in the same tree.  You
have to explicitly do the -f Makefile-2.5 for the new build system to kick
in.  So nobody is being asked to make any sudden change, people can convert
at their own convenience.

> There's a big difference between splitting kb25 into pieces and figuring
> out a way to migrate from kb24 to kb25 with small patches.  You're
> suggesting the former while Linus wants the latter.

If that's really a correct interpretation, it would be weird.  I hope it
isn't.

-- 
Daniel
