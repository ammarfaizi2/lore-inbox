Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbRBYUzG>; Sun, 25 Feb 2001 15:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129759AbRBYUy5>; Sun, 25 Feb 2001 15:54:57 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:3176 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129746AbRBYUyn>; Sun, 25 Feb 2001 15:54:43 -0500
Date: Sun, 25 Feb 2001 21:55:50 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Steve Whitehouse <Steve@ChyGwyn.com>
Cc: torvalds@transmeta.com, pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: NBD Cleanup patch and bugfix in ll_rw_blk.c
Message-ID: <20010225215550.B19168@athlon.random>
In-Reply-To: <200102251957.TAA01718@gw.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200102251957.TAA01718@gw.chygwyn.com>; from steve@gw.chygwyn.com on Sun, Feb 25, 2001 at 07:57:29PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2001 at 07:57:29PM +0000, Steve Whitehouse wrote:
> The bug fix in ll_rw_blk.c prevents hangs when using block devices which
> don't have plugging functions,

It looks the right fix (better than 2.4.0 that didn't had such bug but that was
recalling the request_fn at every inserction in the queue).

Thanks,
Andrea
