Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129602AbRAAP6Q>; Mon, 1 Jan 2001 10:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbRAAP6H>; Mon, 1 Jan 2001 10:58:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30218 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129627AbRAAP6C>;
	Mon, 1 Jan 2001 10:58:02 -0500
Date: Mon, 1 Jan 2001 16:27:18 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Chipsets, DVD-RAM, and timeouts....
Message-ID: <20010101162718.B567@suse.de>
In-Reply-To: <Pine.LNX.4.10.10012312252220.21836-300000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10012312252220.21836-300000@master.linux-ide.org>; from andre@linux-ide.org on Mon, Jan 01, 2001 at 12:07:34AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01 2001, Andre Hedrick wrote:
> ide.2.4.0-prerelease.cd.1231.patch :
> 
> 	./drivers/ide/ide-cd.c
> 	./drivers/ide/ide-cd.h
> 
> 	Adds ATAPI DVD-RAM native read/write mode for any FS.
> 	mke2fs -b 2048 /dev/hdc
> 	You must format to 2048 size blocks.

Any >= 2KB block size will work, using -b 2048 is not necessary.

> 	UDF is an unknown.

Barring strange (new) UDF bugs, it will work. And it's the preferred
way of using the DVD-RAM, both from a portability and media stability
standpoint.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
