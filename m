Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283536AbRK3HgD>; Fri, 30 Nov 2001 02:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283540AbRK3Hfx>; Fri, 30 Nov 2001 02:35:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:11282 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283536AbRK3Hfl>;
	Fri, 30 Nov 2001 02:35:41 -0500
Date: Fri, 30 Nov 2001 08:35:18 +0100
From: Jens Axboe <axboe@suse.de>
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: drivers/block/block.o: In function `rd_blkdev_pagecache_IO' and `rd_make_request': undefined reference to `bio_size'
Message-ID: <20011130083518.F16796@suse.de>
In-Reply-To: <1007098432.25394.2.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1007098432.25394.2.camel@stomata.megapathdsl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29 2001, Miles Lane wrote:
> 
> I haven't seen this mentioned on the list, yet.
> 
> drivers/block/block.o: In function `rd_blkdev_pagecache_IO':
> drivers/block/block.o(.text+0x2884): undefined reference to `bio_size'
> drivers/block/block.o: In function `rd_make_request':
> drivers/block/block.o(.text+0x2a28): undefined reference to `bio_size'

kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.1-pre4/bio-pre4-1

should make it work again, feedback is welcome.

-- 
Jens Axboe

