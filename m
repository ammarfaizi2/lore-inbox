Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311564AbSEJJFb>; Fri, 10 May 2002 05:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313206AbSEJJFa>; Fri, 10 May 2002 05:05:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3023 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S311564AbSEJJFa>;
	Fri, 10 May 2002 05:05:30 -0400
Date: Fri, 10 May 2002 11:05:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Andrew Morton <akpm@zip.com.au>, Peter Chubb <peter@chubb.wattle.id.au>,
        linux-kernel@vger.kernel.org, martin@dalecki.de, neilb@cse.unsw.edu.au
Subject: Re: [PATCH] remove 2TB block device limit
Message-ID: <20020510090514.GL9183@suse.de>
In-Reply-To: <15579.16423.930012.986750@wombat.chubb.wattle.id.au> <5.1.0.14.2.20020510093714.01fa9680@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10 2002, Anton Altaparmakov wrote:
> Why not the even dumber one? Forget FMT_SECTOR_T and always use %Lu and 
> typecast (unsigned long long)sector_t_variable in the printk.

I like that better too, it's what I did in the block layer too.

-- 
Jens Axboe

