Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130130AbRAIULD>; Tue, 9 Jan 2001 15:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131488AbRAIUKx>; Tue, 9 Jan 2001 15:10:53 -0500
Received: from chiara.elte.hu ([157.181.150.200]:33548 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130130AbRAIUKo>;
	Tue, 9 Jan 2001 15:10:44 -0500
Date: Tue, 9 Jan 2001 21:10:24 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Christoph Hellwig <hch@caldera.de>,
        "David S. Miller" <davem@redhat.com>, <riel@conectiva.com.br>,
        <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <20010109205420.H29904@athlon.random>
Message-ID: <Pine.LNX.4.30.0101092108240.8236-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Andrea Arcangeli wrote:

> BTW, I noticed what is left in blk-13B seems to be my work (Jens's
> fixes for merging when the I/O queue is full are just been integrated
> in test1x).  [...]

it was Jens' [i think those were implemented by Jens entirely]
batch-freeing changes that made the most difference. (we did
profile it step by step.)

> ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/2.4.0-test7/blkdev-3

great! i'm happy that the block IO layer and IO scheduler now has
a real home :-) nice work.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
