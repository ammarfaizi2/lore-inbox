Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136490AbREIOXI>; Wed, 9 May 2001 10:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136491AbREIOW6>; Wed, 9 May 2001 10:22:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7692 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S136490AbREIOWr>;
	Wed, 9 May 2001 10:22:47 -0400
Date: Wed, 9 May 2001 16:22:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org, "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: blkdev in pagecache
Message-ID: <20010509162248.B521@suse.de>
In-Reply-To: <20010509043456.A2506@athlon.random> <3AF90A3D.7DD7A605@evision-ventures.com> <20010509151612.D2506@athlon.random> <20010509161452.A521@suse.de> <20010509162009.L2506@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010509162009.L2506@athlon.random>; from andrea@suse.de on Wed, May 09, 2001 at 04:20:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09 2001, Andrea Arcangeli wrote:
> On Wed, May 09, 2001 at 04:14:52PM +0200, Jens Axboe wrote:
> > better to stay with PAGE_CACHE_SIZE and not get into dark country :-)
> 
> My whole point for not using PAGE_CACHE_SIZE as virtual blocksize is
> that many architectures have a PAGE_CACHE_SIZE > 4k, up to 64k, on
> x86-64 we may even hack a 2M PAGE_SIZE/PAGE_CACHE_SIZE mode for the
> multi giga boxes. I think you agreed I'd better stay to a virtual
> blocksize of 4k fixed for now.

In that case, then yes leaving it as a hardcode 4k would be preferred.

-- 
Jens Axboe

