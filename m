Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261542AbSJMRFK>; Sun, 13 Oct 2002 13:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261572AbSJMRFK>; Sun, 13 Oct 2002 13:05:10 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:63899 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261542AbSJMRFJ>;
	Sun, 13 Oct 2002 13:05:09 -0400
Date: Sun, 13 Oct 2002 13:10:49 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Michael Clark <michael@metaparadigm.com>
cc: Christoph Hellwig <hch@infradead.org>,
       Mark Peloquin <markpeloquin@hotmail.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Linux v2.5.42
In-Reply-To: <3DA99CEC.8040208@metaparadigm.com>
Message-ID: <Pine.GSO.4.21.0210131243480.9247-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Oct 2002, Michael Clark wrote:

> Some of us have large arrays and SANs where the absence a volume
> manager is a big thing. I'm glad to see the distros picking it up
> - i guess they have customers who need this sort of stuff.
> 
> How about feedback from other kernel developers on EVMS. Does anyone
> think 'its good enough for inclusion now as long as a few cleanups
> are done after the freeze'?


	Mostly those who won't have to clean up the mess afterwards.
For the record, my vote is "not ready".

	There are good chunks, no arguments about that.  However, IMNSHO
we will be better off if we gradually pick the pieces that make sense
and integrate them into the system.  As it is, wholesale merge would cost
us too much half a year down the road.

	I have seen major subsystem rewrites.  I have done several myself.
I have also done more than a bit of wading through "yet another drivers".
EVMS in its current state shows a lot of signs promising very painful
work on cleanups and intergration.  "Few cleanups after the freeze" doesn't
come anywhere near the impression I'm getting from it and I would bet a lot
on that particular impression.

