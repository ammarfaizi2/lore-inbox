Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289234AbSBJDx7>; Sat, 9 Feb 2002 22:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289239AbSBJDxt>; Sat, 9 Feb 2002 22:53:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47634 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289234AbSBJDxl>; Sat, 9 Feb 2002 22:53:41 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [bk patch] Make cardbus compile in -pre4
Date: Sun, 10 Feb 2002 03:52:32 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a44qq0$138$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0202081824070.25114-100000@segfault.osdlab.org> <20020208203931.X15496@lynx.turbolabs.com> <3C649F4F.7E190D26@mandrakesoft.com> <20020209002920.Z15496@lynx.turbolabs.com>
X-Trace: palladium.transmeta.com 1013313212 19997 127.0.0.1 (10 Feb 2002 03:53:32 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 10 Feb 2002 03:53:32 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020209002920.Z15496@lynx.turbolabs.com>,
Andreas Dilger  <adilger@turbolabs.com> wrote:
>
>The problem is that (AFAIK) bk pull does not let Linus pick-and-choose
>which patches he wants to accept as easily as importing them at the time
>he reads each email.  It basically assumes that he wants everything that
>is in the repository he is pulling from.

Yes and no.

I hope that the developers that I work enough with for it to matter tend
to be fairly good at keeping things separate (ie separate BK trees for
different development efforts etc), in which case it's not a big issue.

And yes, from at least one developer I have already done a partial pull,
ie taken only partial changes. In that case the changes I disagreed with
were at the end, so it was easy enough to just do a "bk pull" into
another tree, do a "bk undo", and only merge after that.

But I agree - if I end up having to do that more than occasionally, I'm
going to ask that developer to stop using bk at least as far as I'm
concerned (ie he can use bk for himself, but I wouldn't accept bk
patches from developers who cannot keep their stuff cleanly separated).

		Linus
