Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132126AbRCYRHu>; Sun, 25 Mar 2001 12:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132122AbRCYRHk>; Sun, 25 Mar 2001 12:07:40 -0500
Received: from www.wen-online.de ([212.223.88.39]:37642 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S132121AbRCYRHg>;
	Sun, 25 Mar 2001 12:07:36 -0500
Date: Sun, 25 Mar 2001 21:07:35 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Jonathan Morton <chromi@cyberspace.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <l0313031db6e2def84b96@[192.168.239.101]>
Message-ID: <Pine.LNX.4.33.0103252041470.551-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Mar 2001, Jonathan Morton wrote:

> >> While my post didn't give an exact formula, I was quite clear on the
> >>fact that
> >> the system is allowing the caches to overrun memory and cause oom problems.
> >
> >Yes.  A testcase would be good.  It's not happening to everybody nor is
> >it happening under all loads.  (if it were, it'd be long dead)
> >
> >> I'm more than happy to test patches, and I would even be willing to suggest
> >> some algorithms that might help, but I don't know where to stick them in the
> >> code.  Most of the people who have been griping are in a similar position.
> >
> >First step toward killing the critter is to lure him onto open ground.
> >Once there.. well, I've seen some pretty fancy shooting on this list.
>
> My patch already fixes OOM problems caused by overgrown caches/buffers, by
> making sure OOM is not triggered until these buffers have been cannibalised
> down to freepages.high.  If balancing problems still exist, then they
> should be retuned with my patch (or something very like it) in hand, to
> separate one problem from the other.  AFAIK, balancing should now be a
> performance issue rather than a stability issue.

Great.  I haven't seen your patch yet as my gateway ate it's very last
disk.  I look forward to reading it.

	-Mike

