Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283182AbRK2OYW>; Thu, 29 Nov 2001 09:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283246AbRK2OYN>; Thu, 29 Nov 2001 09:24:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20743 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283182AbRK2OYC>;
	Thu, 29 Nov 2001 09:24:02 -0500
Date: Thu, 29 Nov 2001 15:23:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: new bio: compile fix for alpha
Message-ID: <20011129152339.M10601@suse.de>
In-Reply-To: <20011129165456.A13610@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011129165456.A13610@jurassic.park.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29 2001, Ivan Kokshaysky wrote:
> Added BUG_ON macro, similar to x86 one;
> arg 2 for blk_queue_bounce_limit() declared `long long' in blkdev.h
> and `u64' in ll_rw_blk.c, which is not the same thing on alpha.

Ah indeed, thanks.

> There are several compiler warnings "long long format, long arg",
> caused by the same reason, but I think they could be ignored at this point.

Please send whatever you find, thanks.

-- 
Jens Axboe

