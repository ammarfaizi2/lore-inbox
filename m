Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271777AbRIHRew>; Sat, 8 Sep 2001 13:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271775AbRIHRem>; Sat, 8 Sep 2001 13:34:42 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44039 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271777AbRIHRec>; Sat, 8 Sep 2001 13:34:32 -0400
Date: Sat, 8 Sep 2001 10:30:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <20010908191954.C11329@athlon.random>
Message-ID: <Pine.LNX.4.33.0109081028390.936-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Sep 2001, Andrea Arcangeli wrote:
>
> There are instead a few initrd bugs that I corrected in the
> blkdev-pagecache patch while rewriting the ramdisk/initrd pagecache
> backed but I'm too lazy to extract them since they're quite low prio,
> I'll just wait for the blkdev in pagecache to be merged instead.

I'll merge the blkdev in pagecache very early in 2.5.x, but I'm a bit
nervous about merging it in 2.4.x.

That said, if you'll give a description of how you fixed the aliasing
issues etc, maybe I'd be less nervous. Putting it in the page cache is
100% the right thing to do, so in theory I'd really like to merge it
earlier rather than later, but...

		Linus

