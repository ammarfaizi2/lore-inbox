Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310943AbSCMRqK>; Wed, 13 Mar 2002 12:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310942AbSCMRqC>; Wed, 13 Mar 2002 12:46:02 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:57521 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S310932AbSCMRps>;
	Wed, 13 Mar 2002 12:45:48 -0500
Date: Wed, 13 Mar 2002 12:44:41 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Valdis.Kletnieks@vt.edu
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Rik van Riel <riel@conectiva.com.br>, Hans Reiser <reiser@namesys.com>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Re: PROBLEM: Kernel Panic on 2.5.6 and 2.5.7-pre1
 boot [PATCH] and discussion of Linux testing procedures 
In-Reply-To: <200203131703.g2DH3ij6019570@foo-bar-baz.cc.vt.edu>
Message-ID: <Pine.GSO.4.21.0203131230240.22930-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Mar 2002 Valdis.Kletnieks@vt.edu wrote:

> On Wed, 13 Mar 2002 09:09:52 EST, Alexander Viro said:
> 
> > Proposal is a bit naive, though - in most of the cases fuckups merrily
> > pass original testing.
> 
> 
> We're not going to create a testing procedure that will find all bugs,
> since that's essentially impossible.  On the other hand, I think we
> all need to collectively take 24 or 48 hour off, spend the time downing
> several <insert beverage here>, and see if anybody has a good proposal
> that would catch 90% of the show-stopper bugs that have slipped through
> so far in the 2.4 and 2.5 series, without complicating matters TOO much.
> 
> Here's a simple one:  a -rcN release has to sit there at least 96
> hours before it gets tagged as "final".  That's something we've been
> quite poor at so far:

Well, let's see.  I can't speak for other folks, but the worst of mine
during 2.4 was in 2.4.15-pre9.  The rest was minor and IIRC didn't make
it into -final.  That one did, however.  It wasn't caught until 2.4.15 -
not immediately, at that.

