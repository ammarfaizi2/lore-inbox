Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131935AbQLPOap>; Sat, 16 Dec 2000 09:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131930AbQLPOaf>; Sat, 16 Dec 2000 09:30:35 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34578 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131962AbQLPOaW>;
	Sat, 16 Dec 2000 09:30:22 -0500
Date: Sat, 16 Dec 2000 14:59:40 +0100
From: Jens Axboe <axboe@suse.de>
To: Stanislav Brabec <utx@penguin.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ATAPI: audio CD still stops on >> (fast forward, 2.4.0-test12)
Message-ID: <20001216145940.C471@suse.de>
In-Reply-To: <20001103235437.B5574@utx.cz> <20001104151845.E12610@suse.de> <20001215123132.A790@utx.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001215123132.A790@utx.cz>; from utx@penguin.cz on Fri, Dec 15, 2000 at 12:31:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15 2000, Stanislav Brabec wrote:
> - play CD audio correctly, don't stop after 12 minutes.
> 
> Patch in 2.4.0-test12 really fixes this problem.

Good

> But problem with >> (fast forward playng of short samples) still remains
> on some audio CD's.
> Dec 15 12:17:25 utx kernel:   "47 00 00 00 02 00 3c 3a ff 00 00 00 " 
							 ^^

This is the same case that Miles reported, it's very odd how that 8th
byte gets screwed somehow... But I know about this, I just haven't tracked
this down yet.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
