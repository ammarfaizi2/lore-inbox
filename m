Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130215AbQKLIgU>; Sun, 12 Nov 2000 03:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130241AbQKLIgL>; Sun, 12 Nov 2000 03:36:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12049 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130215AbQKLIgD>;
	Sun, 12 Nov 2000 03:36:03 -0500
Date: Sun, 12 Nov 2000 09:35:54 +0100
From: Jens Axboe <axboe@suse.de>
To: Hisaaki Shibata <shibata@luky.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch: atapi dvd-ram support
Message-ID: <20001112093554.I805@suse.de>
In-Reply-To: <20001028201047.A5879@suse.de> <20001029134145N.shibata@luky.org> <20001029141214.B615@suse.de> <20001111031748S.shibata@luky.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001111031748S.shibata@luky.org>; from shibata@luky.org on Sat, Nov 11, 2000 at 03:17:48AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11 2000, Hisaaki Shibata wrote:
> > Or you could try the 2.4 version, as I said originally the 2.2 patch
> > hasn't been tested at all. It would be nice to know if that works
> > for you, as I may have screwed up the backport a bit.
> 
> I tested on 2.4-test10 + dvd-ram-240t10p5.diff.bz2 + dvdram-ro_fix.diff env.
> It occured oops too :-(.

Interesting, then it isn't the backport that is buggy.

> And I forgot to say that my DVD-RAM drive is a new 9.4GB DVD-RAM model drive.

I'd like to know specifically what make/model drive you have? The
oops you sent earlier seems to indicate an empty ide dma request setup.
If you disable DMA on the drive, does it then work? I'd send you a
patch right now, but I have to unpack my trees first.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
