Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262889AbSJGFww>; Mon, 7 Oct 2002 01:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262890AbSJGFww>; Mon, 7 Oct 2002 01:52:52 -0400
Received: from mx2.elte.hu ([157.181.151.9]:44696 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262889AbSJGFwv>;
	Mon, 7 Oct 2002 01:52:51 -0400
Date: Mon, 7 Oct 2002 08:08:40 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Larry McVoy <lm@bitmover.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Russell King <rmk@arm.linux.org.uk>,
       "David S. Miller" <davem@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ulrich Drepper <drepper@redhat.com>, <bcollins@debian.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: BK MetaData License Problem?
In-Reply-To: <20021006155217.Y29486@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0210070758490.2557-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 6 Oct 2002, Larry McVoy wrote:

> Yes, but you'd want to make sure that you stated that your license
> extended to the BK metadata.  In our opinion, only you as the creator of
> the repository gets to make that rule but you certainly can, that's one
> of the reasons we put that clause in there.

so in theory it's perfectly possible to 'link' the data's and metadata's
license via BKL.txt - after all you already added licensing rules for the
metadata into the BK license, for the purposes of OpenLogging.

It would also perhaps make your position slightly more robust - besides
you already having the right to 'republish' metadata [which is a term not
directly defined in the license], you'd also have all the rights that come
through the license of the data it describes - whatever that is worth.

There are some problems like the fact that metadata might describe
multiple pieces of data that might have different licenses, the solution
would be to license metadata under every license that data is licensed
under - if there's any. This would be in addition to the already existing
republishing rights for OpenLogging.

> By the way, the way this code works in bk-3.0 is that it saves a md5sum
> or some sort of strong hash of the license in question and it will ask
> you only once, assuming you are using the same home directory.  It will
> ask you again if the license changes, that's what the hash is for.

this sounds really nice and unintrusive, how does one enable it? Is this
BK_FORCE, or something else? I cannot find any reference to this in 'bk
helptool'.

	Ingo

