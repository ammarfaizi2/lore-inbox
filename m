Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281301AbRKEUEA>; Mon, 5 Nov 2001 15:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281303AbRKEUDv>; Mon, 5 Nov 2001 15:03:51 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:26555 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281301AbRKEUDm>; Mon, 5 Nov 2001 15:03:42 -0500
Date: Mon, 5 Nov 2001 13:03:34 -0700
Message-Id: <200111052003.fA5K3YG10879@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New devfs core
In-Reply-To: <Pine.GSO.4.21.0111051447060.24894-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.LNX.4.33L.0111051742231.27028-100000@duckman.distro.conectiva>
	<Pine.GSO.4.21.0111051447060.24894-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> On Mon, 5 Nov 2001, Rik van Riel wrote:
> > On Mon, 5 Nov 2001, Richard Gooch wrote:
> > > But since interest has been expressed ;-) in seeing this code, here it
> > > is. So don't flame if you see problems. Remember that this is a very
> > > rough cut. I have a list of "issues" to process before I consider this
> > > alpha quality.
> > 
> > This is nice for 2.5, but I have to wonder what you're
> > going to do in order to get the bugs in 2.4 devfs fixed.
> 
> Come on.  Regardless of the quality of new code (I hadn't looked at
> the patched tree yet, but from the look at patch itself locking is
> heavily overdone, so my gut feeling is that there are deadlocks),
> it's no worse than the old one.

As I said, this is a very rough cut. I'm not actually suggesting this
is code people should run (although testing reports are always
welcome), it's a release so that people can see what I'm doing.

> I.e. as long as it doesn't touch the rest of tree, situation hadn't
> become worse.  Usual arguments re lost testing obviously do not
> apply - replaced code is known to be broken _and_ impossible to fix
> without a massive rewrite.  So all old testing had been worthless
> anyway.

Surprising as it may seem, I agree with Al. The old code has too many
problems, and can't be fixed with just a tweak here and there. A
re-write is what is needed, and a re-write is what I'm doing. The new
code will be tested, and once I'm satisfied that it works at least as
well as the old code, I'll submit it to Linus. Any remaining problems
should be much easier to fix in the new code, I hope.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
