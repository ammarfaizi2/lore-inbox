Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130199AbRAOBsw>; Sun, 14 Jan 2001 20:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130281AbRAOBsn>; Sun, 14 Jan 2001 20:48:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4358 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130199AbRAOBsb>;
	Sun, 14 Jan 2001 20:48:31 -0500
Date: Mon, 15 Jan 2001 02:47:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Bill Crawford <billc@netcomuk.co.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0-ac9
Message-ID: <20010115024756.A11915@suse.de>
In-Reply-To: <3A624E77.634D42AD@netcomuk.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A624E77.634D42AD@netcomuk.co.uk>; from billc@netcomuk.co.uk on Mon, Jan 15, 2001 at 01:12:23AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15 2001, Bill Crawford wrote:
>  I have a problem here with loopback-mounted filesystem freezing. The
> process writing to the filesystem (ext2) gets stuck in uninterruptible
> state with WCHAN showing "lock_p" which I believe to be lock_page.

Could you try with this patch

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0-ac9/loop-2

and see if it helps?

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
