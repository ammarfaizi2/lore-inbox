Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129074AbQJ3Vyw>; Mon, 30 Oct 2000 16:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbQJ3Vym>; Mon, 30 Oct 2000 16:54:42 -0500
Received: from fw.SuSE.com ([202.58.118.35]:50675 "EHLO linux.local")
	by vger.kernel.org with ESMTP id <S129074AbQJ3Vya>;
	Mon, 30 Oct 2000 16:54:30 -0500
Date: Mon, 30 Oct 2000 14:59:50 -0800
From: Jens Axboe <axboe@suse.de>
To: Hisaaki Shibata <shibata@luky.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch: atapi dvd-ram support
Message-ID: <20001030145950.E521@suse.de>
In-Reply-To: <20001028201047.A5879@suse.de> <20001029134145N.shibata@luky.org> <20001029141214.B615@suse.de> <20001031031455T.shibata@luky.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001031031455T.shibata@luky.org>; from shibata@luky.org on Tue, Oct 31, 2000 at 03:14:55AM +0900
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31 2000, Hisaaki Shibata wrote:
> By using serial console, I get messages for you ;-)

Thanks, now you're just one step short of being really
helpful :-). Pass it through ksymoops please, so the
addresses will map to function names + offsets.

> In case of doing "dd if=/dev/zero of=/dev/hdc bs=2048 count=1".
> ----------------------------------------------------------------------------
> hdc: ATAPI DVD-ROM DVD-RAM drive, 512kB Cache, UDMA(33)
> hdc: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14

Try it without DMA as well, please. I think I see a DMA bug in there right
now, I'll recheck and send you a new patch.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
