Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313260AbSEJKBY>; Fri, 10 May 2002 06:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313264AbSEJKBX>; Fri, 10 May 2002 06:01:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32980 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313260AbSEJKBX>;
	Fri, 10 May 2002 06:01:23 -0400
Date: Fri, 10 May 2002 12:01:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Anton Altaparmakov <aia21@cantab.net>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, martin@dalecki.de, neilb@cse.unsw.edu.au
Subject: Re: [PATCH] remove 2TB block device limit
Message-ID: <20020510100105.GO9183@suse.de>
In-Reply-To: <15579.16423.930012.986750@wombat.chubb.wattle.id.au> <5.1.0.14.2.20020510093714.01fa9680@pop.cus.cam.ac.uk> <20020510090514.GL9183@suse.de> <15579.39081.528187.280027@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10 2002, Peter Chubb wrote:
> >>>>> "Jens" == Jens Axboe <axboe@suse.de> writes:
> 
> Jens> On Fri, May 10 2002, Anton Altaparmakov wrote:
> >> Why not the even dumber one? Forget FMT_SECTOR_T and always use %Lu
> >> and typecast (unsigned long long)sector_t_variable in the printk.
> 
> Jens> I like that better too, it's what I did in the block layer too.
> 
> That's exactly what I did in the patch....

Excellent

> Except most places I used u64 not unsigned long long (it's the same
> thing on all architectures, and much shorter to type).

Patch looks fine to me. I was hoping someone would do the grunt
conversion work when I introduced sector_t, thanks! :-)

-- 
Jens Axboe

