Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314689AbSDTRv0>; Sat, 20 Apr 2002 13:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314690AbSDTRvZ>; Sat, 20 Apr 2002 13:51:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56081 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314689AbSDTRvX>; Sat, 20 Apr 2002 13:51:23 -0400
Date: Sat, 20 Apr 2002 10:51:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Anton Altaparmakov <aia21@cantab.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
In-Reply-To: <E16ycFR-0000Vg-00@starship>
Message-ID: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Apr 2002, Daniel Phillips wrote:
> > > And some have a more difficult one.  So it goes.
> >
> > How?
>
> Those who now chose to carry out their development using the patch+email
> method, and prefer to submit everything for discussion on lkml before it
> gets included are now largely out of the loop.  Things just seem to *appear*
> in the tree now, without much fanfare.  That's my impression.

I don't buy that - I'm not getting changes from any new magical BK "men in
black". The patches are the same kind they always were, the last few
entries in my changelog are now the x86-64 merge (which was half a meg,
and yes it wasn't posted on linux-kernel, but no, it never was before BK
either), and before that the extensively discussed SSE register content
leak patch.

HOWEVER, the fact that you _feel_ like that is clearly a fact.

Any suggestions on how to make the process _appear_ less intimidating?

Note that one thing that I had hoped BK would do for me, but that hasn't
happened because I'm a lazy bastard and I'm bad at doing automated scripts
is to do dialy snapshots as patches (getting rid of the "-pre" kernels,
since they don't actually add any information except act as update
points), and also send out a changelog daily to the kernel mailing list.

That is something that is one of the big _points_ to using source control,
yet because I don't need it personally I've never gotten around to writing
those scripts.

That would actually make the development process MORE open than it was
before BK, and might make even non-BK people appreciate BK more simply
because there is a real point to it.

Comments? Anybody want to hack up a script to do this?

		Linus

