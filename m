Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSDXETw>; Wed, 24 Apr 2002 00:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314516AbSDXETv>; Wed, 24 Apr 2002 00:19:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32524 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314514AbSDXETu>; Wed, 24 Apr 2002 00:19:50 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: graphical cset stats
Date: Wed, 24 Apr 2002 04:18:45 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aa5bn5$28v$1@penguin.transmeta.com>
In-Reply-To: <200204232240.g3NMe9231822@work.bitmover.com> <20020423232520.GA10479@kroah.com> <20020423203211.7a6d7078.dang@fprintf.net>
X-Trace: palladium.transmeta.com 1019621961 6305 127.0.0.1 (24 Apr 2002 04:19:21 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 24 Apr 2002 04:19:21 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020423203211.7a6d7078.dang@fprintf.net>,
Daniel Gryniewicz  <dang@fprintf.net> wrote:
>
>But it is interesting how it's an exponential progression.

I think it's a bit dangerous, because it is so misleading. Both the "top
performers" are clearly integrators rather than big coders, and I
suspect a lot of my "cset-points" are actually from the early BK tree
creation where every single cset got attributed to me simply because
they got merged from the historic non-SCM patch info.

Certainly looking at the SCM statistics from the last 500 ChangeSets, 63
of them were attributed to me ("Hey, Linus does 12% of all kernel coding
himself! Studly, man!"), but if you actually look at the details of the
changesets, you'll notice that I'm a total loser, and I end up doing
little coding and most of my changesets are merges, cset excludes,
kernel version updates etc ("Hey, Linus is a complete moron!").. 

So I personally get a bit nervous about pretty graphs - they _seem_ to
say so much, yet they clearly don't tell enough.  Which can be a bit
dangerous if somebody takes them too seriously. They're just simple
enough that you think you get the RealTruth(tm).

				Linus
