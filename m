Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130097AbQJ1DZp>; Fri, 27 Oct 2000 23:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130207AbQJ1DZf>; Fri, 27 Oct 2000 23:25:35 -0400
Received: from fw.SuSE.com ([202.58.118.35]:6129 "EHLO linux.local")
	by vger.kernel.org with ESMTP id <S130097AbQJ1DZ3>;
	Fri, 27 Oct 2000 23:25:29 -0400
Date: Fri, 27 Oct 2000 20:27:10 -0700
From: Jens Axboe <axboe@suse.de>
To: Rui Sousa <rsousa@grad.physics.sunysb.edu>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Blocked processes <=> Elevator starvation?
Message-ID: <20001027202710.A825@suse.de>
In-Reply-To: <20001027134603.A513@suse.de> <Pine.LNX.4.21.0010280408520.1157-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0010280408520.1157-100000@localhost.localdomain>; from rsousa@grad.physics.sunysb.edu on Sat, Oct 28, 2000 at 04:14:23AM +0100
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28 2000, Rui Sousa wrote:
> After adding
> 
> #define ELEVATOR_HOLE_MERGE     3
> 
> to linux/include/linux/elevator.h it compiled ok.

Oops sorry, I'm on the road so the patch was extracted
from my packet writing tree (and not my regular tree).

> There were still some stalls but they only lasted a couple of
> seconds. The patch did make a difference and for the better.

Ok, still needs a bit of work. Thanks for the feedback.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
