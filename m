Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314502AbSDXCYU>; Tue, 23 Apr 2002 22:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314507AbSDXCYT>; Tue, 23 Apr 2002 22:24:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34824 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314502AbSDXCYS>; Tue, 23 Apr 2002 22:24:18 -0400
Date: Tue, 23 Apr 2002 19:23:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@suse.cz>
cc: Rob Landley <landley@trommello.org>, Alexander Viro <viro@math.psu.edu>,
        Ian Molton <spyro@armlinux.org>, <linux-kernel@vger.kernel.org>
Subject: Re: BK, deltas, snapshots and fate of -pre...
In-Reply-To: <20020421230842.E155@toy.ucw.cz>
Message-ID: <Pine.LNX.4.44.0204231920401.10866-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Apr 2002, Pavel Machek wrote:
>
> I believe -pre's are still important. Daily snapshots are too likely to be
> broken, and "real" releases are different from -pre ones (with *usefull*
> difference): you can ignore -pre release, but you can't ignore real release
> (because real releases are relative to each other).

Considering how even real releases in the development tree are likely to
be broken (never mind the _trivial_ brokenness of applying the same patch
to init/main.c twice, I'm talking about the more fundamental brokenness of
just broken drivers and filesystems due to development), I'm not sure how
big a deal that is.

And I do make full tar-files of real releases, so that people can skip a
few (although unless you have a fast connection it usually only makes
sense after 10 full releases or so).

> Having slightly more frequent real releases would be nice, but I believe
> it is not feasible to make them as common as pre- patches.

I'll try to keep them coming a bit more often.

		Linus

