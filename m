Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132427AbRBEBKN>; Sun, 4 Feb 2001 20:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132554AbRBEBKE>; Sun, 4 Feb 2001 20:10:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:31237 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132427AbRBEBJ6>;
	Sun, 4 Feb 2001 20:09:58 -0500
Date: Mon, 5 Feb 2001 02:09:52 +0100
From: Jens Axboe <axboe@suse.de>
To: patrick.mourlhon@wanadoo.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: ATAPI CDRW which doesn't work
Message-ID: <20010205020952.B1276@suse.de>
In-Reply-To: <20010203230544.A549@MourOnLine.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010203230544.A549@MourOnLine.dnsalias.org>; from patrick.mourlhon@wanadoo.fr on Sat, Feb 03, 2001 at 11:05:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03 2001, patrick.mourlhon@wanadoo.fr wrote:
> Feb  3 22:08:25 Line kernel: hdb: irq timeout: status=0xd0 { Busy }
> Feb  3 22:08:25 Line kernel: hdb: DMA disabled
> Feb  3 22:08:55 Line kernel: hdb: ATAPI reset timed-out, status=0x90
> Feb  3 22:08:55 Line kernel: hda: DMA disabled

Try disabling DMA on the drive before accessing it. 

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
