Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSDTVCB>; Sat, 20 Apr 2002 17:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312031AbSDTVCA>; Sat, 20 Apr 2002 17:02:00 -0400
Received: from dsl-213-023-039-128.arcor-ip.net ([213.23.39.128]:57740 "EHLO
	starship") by vger.kernel.org with ESMTP id <S311898AbSDTVB7>;
	Sat, 20 Apr 2002 17:01:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Date: Fri, 19 Apr 2002 23:02:04 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Anton Altaparmakov <aia21@cantab.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16yfW9-0000aZ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 April 2002 19:51, Linus Torvalds wrote:
> Any suggestions on how to make the process _appear_ less intimidating?

I'm thinking about it.  It's still the best project on the planet, but even
so, could it be better?

> Note that one thing that I had hoped BK would do for me, but that hasn't
> happened because I'm a lazy bastard and I'm bad at doing automated scripts
> is to do dialy snapshots as patches (getting rid of the "-pre" kernels,
> since they don't actually add any information except act as update
> points), and also send out a changelog daily to the kernel mailing list.

Eeek.  That sounds like a lot of work.  Oh I see, this is 100% automated.

> That would actually make the development process MORE open than it was
> before BK, and might make even non-BK people appreciate BK more simply
> because there is a real point to it.

Well, it would be more like working in a fishbowl anyway.  The part that's
missing is the discussion.  Just looking at the recent traffic... there's
Martin Dalecki's IDE patch, gosh, look at all the fun.  It's a non-BK
patch, let's see if there's a pattern.  Hmm, the next bushy one is "[PATCH]
zerocopy NFS updated", descending from a traditional patch set.  The next
one, "[PATCH] IDE TCQ #4" is also a traditional patch.  Hmm, no bitkeeper
patches showing up yet, I don't think I need to go on.

There is a clear inverse relationship between the bk-ness of a patch and
the extent to which it's discussed on lkml.  I don't know what to read into
that, but it does seem to lend credence to the idea that the bitkeeper
style of working is not compatible with the idea of community discussion.

Perhaps there are really two kinds of patches, those that are mainly
functional and don't need to be discussed, for which Bitkeeper is an
entirely appropriate medium, and patches-needing-discussion, for which
the Bitkeeper channel is entirely inappropriate.  Most of the volume is in
the former, and hence, that is where most of the time savings are.  The
corollary of that is, we will not lose a lot of productivity by *not*
using Bitkeeper for the kind of patch that could or should be discussed.

> Comments? Anybody want to hack up a script to do this?

Well, that's a nice thought, but it's not the crux of the problem.

-- 
Daniel
