Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311445AbSDDUNK>; Thu, 4 Apr 2002 15:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311454AbSDDUNA>; Thu, 4 Apr 2002 15:13:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54534 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311445AbSDDUMs>; Thu, 4 Apr 2002 15:12:48 -0500
Date: Thu, 4 Apr 2002 12:12:07 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Larry McVoy <lm@bitmover.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.8-pre1
In-Reply-To: <20020403195445.U17549@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0204041203440.14206-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Apr 2002, Larry McVoy wrote:
> 
> Oh, yeah, this URL is starting to be fun:
> 
> http://linux.bkbits.net:8080/linux-2.5/stats
> 
> You can click on any name to see what they have been working on, once you
> drill down through a name, you are looking at things through a "this user
> only" filter.

Side note: this only works partially.

For example, of the 297 changesets in 2.5.8-pre1, 147 were from email
patches (the 50% ratio seems to have held up pretty well over time:  
about half of the submissions I get are old-style patches, with half being
BK merges. Of course, for me the advantage of BK is that the BK merge half
often required _much_ less than 50% of the time).

Anyway: of the 147 patches, 125 were merges from Dave Jones (only 123 are
marged as such - two were re-attributed by me by hand by editing the
emails directly).

And of those 123 changesets marked as coming from Dave, most were
obviously written by others, and Dave acted as integrator (which is not
unimportant, of course - 99% of what I do myself is only integration these
days).

So the statistics get skewed by details like this - if is only a partial
map of who actually _wrote_ the patch.

(The same is sometimes true of the BK patches themselves, not just the
email patches I get from integrators liek Dave who still use diffs to
merge with me. It depends on who and how the original BK changeset was
created, of course).

		Linus

