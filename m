Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281294AbRKETwb>; Mon, 5 Nov 2001 14:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281296AbRKETwU>; Mon, 5 Nov 2001 14:52:20 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:39609 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281294AbRKETwD>;
	Mon, 5 Nov 2001 14:52:03 -0500
Date: Mon, 5 Nov 2001 14:51:48 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Rik van Riel <riel@conectiva.com.br>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org,
        devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: Re: [PATCH] New devfs core
In-Reply-To: <Pine.LNX.4.33L.0111051742231.27028-100000@duckman.distro.conectiva>
Message-ID: <Pine.GSO.4.21.0111051447060.24894-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Nov 2001, Rik van Riel wrote:

> On Mon, 5 Nov 2001, Richard Gooch wrote:
> 
> > But since interest has been expressed ;-) in seeing this code, here it
> > is. So don't flame if you see problems. Remember that this is a very
> > rough cut. I have a list of "issues" to process before I consider this
> > alpha quality.
> 
> This is nice for 2.5, but I have to wonder what you're
> going to do in order to get the bugs in 2.4 devfs fixed.

Come on.  Regardless of the quality of new code (I hadn't looked at the
patched tree yet, but from the look at patch itself locking is heavily
overdone, so my gut feeling is that there are deadlocks), it's no worse
than the old one.

I.e. as long as it doesn't touch the rest of tree, situation hadn't
become worse.  Usual arguments re lost testing obviously do not apply -
replaced code is known to be broken _and_ impossible to fix without a
massive rewrite.  So all old testing had been worthless anyway.

