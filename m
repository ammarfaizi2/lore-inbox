Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131378AbRASBqe>; Thu, 18 Jan 2001 20:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131077AbRASBo2>; Thu, 18 Jan 2001 20:44:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4111 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130108AbRASBoF>;
	Thu, 18 Jan 2001 20:44:05 -0500
Date: Fri, 19 Jan 2001 02:43:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1pre8 slowdown on dbench tests
Message-ID: <20010119024351.C18209@suse.de>
In-Reply-To: <20010119011629.C32087@athlon.random> <Pine.LNX.4.21.0101182119120.4610-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0101182119120.4610-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Thu, Jan 18, 2001 at 09:51:03PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18 2001, Marcelo Tosatti wrote:
> > Marcelo can you give a try with `high_queued_sectors = total_ram / 3' and
> > low_queued_sectors = high_queued_sectors / 2 and drop the big ram machine
> > check?
> 
> Andrea,
> 
> With the changes you suggested I got almost the same results with
> pre8. 

Good, so it's getting closer. Actually, the dbench numbers being
this close (or better) is only due to blk-xx optimizations. The
latency is much smaller, which usually really hurts dbench quite
a bit in testing.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
