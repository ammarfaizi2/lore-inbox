Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130334AbQKCCEm>; Thu, 2 Nov 2000 21:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130403AbQKCCEc>; Thu, 2 Nov 2000 21:04:32 -0500
Received: from fw.SuSE.com ([202.58.118.35]:12536 "EHLO linux.local")
	by vger.kernel.org with ESMTP id <S130334AbQKCCEV>;
	Thu, 2 Nov 2000 21:04:21 -0500
Date: Thu, 2 Nov 2000 19:10:39 -0800
From: Jens Axboe <axboe@suse.de>
To: David Mansfield <lkml@dm.ultramaster.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: blk-7 fails to boot (against 2.4.0-test10)
Message-ID: <20001102191039.B17975@suse.de>
In-Reply-To: <3A01C8B2.23D6E9C4@dm.ultramaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A01C8B2.23D6E9C4@dm.ultramaster.com>; from lkml@dm.ultramaster.com on Thu, Nov 02, 2000 at 03:04:02PM -0500
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02 2000, David Mansfield wrote:
> Hi Jens.
> 
> I wanted to try out blk-7 to see if it cured the abysmal I/O
> performance on 2.4.0-test10, but it won't boot on my system.

Could you try blk-8?

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0-test10/blk-8.bz2

It also has other fixes over blk-7 (saves the linear back scan when
a buffer can't be merged, simple aging of requests in queue, and
more "fair" accouting of merges)

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
