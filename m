Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136215AbRAMBuf>; Fri, 12 Jan 2001 20:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136170AbRAMBu0>; Fri, 12 Jan 2001 20:50:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27149 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S136215AbRAMBuI>;
	Fri, 12 Jan 2001 20:50:08 -0500
Date: Sat, 13 Jan 2001 02:49:17 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Frank de Lange <frank@unternet.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
Message-ID: <20010113024917.B22380@suse.de>
In-Reply-To: <20010113014807.B29757@unternet.org> <Pine.LNX.4.10.10101121652160.8097-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10101121652160.8097-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Jan 12, 2001 at 04:56:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12 2001, Linus Torvalds wrote:
> [...] With disks it is very hard
> to get the same kind of irq load - Linux will merge the requests and do at
> least 1kB worth of transfer per interrupt etc. On a ne2k 100Mbps PCI card,

Actually, without mult count you will do only 512b of I/O per interrupt
on IDE. Regardless of merging etc. Still doesn't reach nic levels, but
it's _bad_ anyway :-)

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
