Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130216AbRABOzM>; Tue, 2 Jan 2001 09:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130645AbRABOzD>; Tue, 2 Jan 2001 09:55:03 -0500
Received: from renata.irb.hr ([161.53.129.148]:8708 "EHLO renata.irb.hr")
	by vger.kernel.org with ESMTP id <S130216AbRABOy5>;
	Tue, 2 Jan 2001 09:54:57 -0500
From: Vedran Rodic <vedran@renata.irb.hr>
Date: Tue, 2 Jan 2001 15:24:09 +0100
To: Daniel Phillips <phillips@innominate.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-prerelease problems (it corrupted my ext2 filesystem)
Message-ID: <20010102152409.A10863@renata.irb.hr>
In-Reply-To: <20010102131507.A7573@renata.irb.hr> <3A51D9BF.23C42DFE@innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A51D9BF.23C42DFE@innominate.de>; from phillips@innominate.de on Tue, Jan 02, 2001 at 02:38:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2001 at 02:38:07PM +0100, Daniel Phillips wrote:
> Could you provide details of your configuration?
> 

I put the complete kernel log of that session at http://quark.fsb.hr/~vrodic/kern.log

I scanned my swap device several times today with badblocks -w, and
it didn't show any errors. I also did some RAM tests with memtest86, 
again with no errors.

If you need more details, just ask.

> Vedran Rodic wrote:
> > I was using 2.4.0-prerelease without extra patches and I experienced some
> > heavy (ext2) file system corruption. I was grabbing some video using bttv at
> > the time. Kernel didn't oops, but processess just started terminating.
> > 
> > Here is a the interesting part from my logs:
> > 
> > Bad swap file entry 5c5b6256
> > VM: killing process qtvidcap
> > swap_free: Trying to free nonexistent swap-page
> > last message repeated 23 times
> > swap_free: Trying to free swap from unused swap-device
> > swap_free: Trying to free nonexistent swap-page
> > last message repeated 266 times
> > Bad swap file entry 272c2e24
> > VM: killing process pppd
> > swap_free: Trying to free nonexistent swap-page
> > last message repeated 30 times
> 
> --
> Daniel

Vedran
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
