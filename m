Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278475AbRJVKMD>; Mon, 22 Oct 2001 06:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278472AbRJVKLx>; Mon, 22 Oct 2001 06:11:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:44507 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S275278AbRJVKLr>;
	Mon, 22 Oct 2001 06:11:47 -0400
Date: Mon, 22 Oct 2001 06:06:55 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: alain@linux.lu, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        kamil@science.uva.nl, adilger@turbolabs.com, vherva@niksula.hut.fi,
        nleroy@cs.wisc.edu, davidsen@tmr.com, landley@trommello.org,
        manfred@colorfullife.com
Subject: Re: Poor floppy performance in kernel 2.4.10
In-Reply-To: <20011022115956.J8408@athlon.random>
Message-ID: <Pine.GSO.4.21.0110220605470.2294-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Oct 2001, Andrea Arcangeli wrote:

> too). So I believe in the long run we must implement a whitelist that
> tells us when to trust the media change detection, and always trim the
> cache during blkdev_open or during rmmod as I also suggested during
> 2.3.x when blkdev_close was changed to do the unconditional

I think that I have a correct fix for that, but I'll need to sort
some devfs-related unpleasantness first...

