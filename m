Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314101AbSEaBQG>; Thu, 30 May 2002 21:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSEaBQF>; Thu, 30 May 2002 21:16:05 -0400
Received: from pop018pub.verizon.net ([206.46.170.212]:6092 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S314101AbSEaBQF>; Thu, 30 May 2002 21:16:05 -0400
Date: Thu, 30 May 2002 21:20:27 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KBuild 2.5 Impressions
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205302155.g4ULtEb09500@buggy.badula.org> <E17DZCa-0007hI-00@starship> <1022803993.2799.13.camel@tiger> <E17Daa5-0007iZ-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Message-Id: <20020531011600.ENOZ28280.pop018.verizon.net@pool-141-150-239-239.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> On Friday 31 May 2002 02:13, Kenneth Johansson wrote:
> > On Fri, 2002-05-31 at 01:19, Daniel Phillips wrote:
> > > 
> > > I think that with these breakups done the thing would be sufficiently
> > > digestible to satisfy Linus.  Now that I think of it, Linus's request
> > 
> > Maybe I'm the idiot here but what dose this gain you??
> >
> > The reason to break up a patch is not simply to get more of them. There
> > is no point in splitting if you still need to use every single one of
> > them to make anything work. 
> 
> See above.  It's all about analyzing the structure of the patch.  To be
> fair though, it took me less than an hour to get a pretty good idea of
> how the current patch set is structured.

I could be wrong but I think Linus wants small patches that slowly
convert kbuild24 to kbuild25, and not just a chopped up wholesale
kbuild25.

There's a big difference between splitting kb25 into pieces and figuring
out a way to migrate from kb24 to kb25 with small patches.  You're
suggesting the former while Linus wants the latter.

-- 
Skip
