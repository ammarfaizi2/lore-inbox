Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136488AbREIOU6>; Wed, 9 May 2001 10:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136489AbREIOUs>; Wed, 9 May 2001 10:20:48 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:27992 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136488AbREIOUe>; Wed, 9 May 2001 10:20:34 -0400
Date: Wed, 9 May 2001 16:20:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org, "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: blkdev in pagecache
Message-ID: <20010509162009.L2506@athlon.random>
In-Reply-To: <20010509043456.A2506@athlon.random> <3AF90A3D.7DD7A605@evision-ventures.com> <20010509151612.D2506@athlon.random> <20010509161452.A521@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010509161452.A521@suse.de>; from axboe@suse.de on Wed, May 09, 2001 at 04:14:52PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 04:14:52PM +0200, Jens Axboe wrote:
> better to stay with PAGE_CACHE_SIZE and not get into dark country :-)

My whole point for not using PAGE_CACHE_SIZE as virtual blocksize is
that many architectures have a PAGE_CACHE_SIZE > 4k, up to 64k, on
x86-64 we may even hack a 2M PAGE_SIZE/PAGE_CACHE_SIZE mode for the
multi giga boxes. I think you agreed I'd better stay to a virtual
blocksize of 4k fixed for now.

Andrea
