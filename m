Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316502AbSEOVDn>; Wed, 15 May 2002 17:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316503AbSEOVDm>; Wed, 15 May 2002 17:03:42 -0400
Received: from as3-1-8.ras.s.bonet.se ([217.215.75.181]:6087 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id <S316502AbSEOVDm>;
	Wed, 15 May 2002 17:03:42 -0400
Subject: Re: Changelogs on kernel.org
From: Kenneth Johansson <ken@canit.se>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Larry McVoy <lm@bitmover.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <19065.1021493737@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 15 May 2002 23:03:34 +0200
Message-Id: <1021496614.917.33.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-15 at 22:15, David Woodhouse wrote:
> 
> lm@bitmover.com said:
> > It's probably best if you simply view this as a BK limitation which
> > isn't going away any time soon and don't put junk changesets in the
> > middle of your stream of changes.  It's easy enough to export the
> > change you want as a patch, export the comments in the form that bk
> > comments wants, undo the junk changeset, import the patch, and set the
> > comments.  Yeah, it's awkward; consider that a feedback loop which
> > encourages you to think a bit more about what you put in the tree.
> 
> What it actually encourages is for people to have multiple throwaway trees. 
> (Which isn't quite so much of a BK turnoff once you discover compilercache.)
> 
> If the tree's going to be thrown away anyway, it doesn't matter if it gets 
> confused -- how about making it a little easier to backport changesets -- 
> surely it should be possible to make BK import a changeset iff all the 
> affected files are identical in both trees before the changeset? 

while we are adding to the wishlist here is a few more items.

Away to make a clone with all files checked out in edit mode. I find
that I always do the checkout anyway and maybe it's possible to make it
faster if it's done at clone time.

Also I have found that it is a pain in the a** to have debug code that I
really don't want to save but it's temporary usefull. When I do a pull
that changes the same file the pull don't work and I have to unedit the
file and lose the debug code or make a needless checkin. I would really
like if it was possible to do a merge that is only in the checkedout
file not stored as a changeset.

 


