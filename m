Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271661AbRHUNeg>; Tue, 21 Aug 2001 09:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271660AbRHUNe0>; Tue, 21 Aug 2001 09:34:26 -0400
Received: from fepE.post.tele.dk ([195.41.46.137]:54245 "EHLO
	fepE.post.tele.dk") by vger.kernel.org with ESMTP
	id <S271661AbRHUNeR>; Tue, 21 Aug 2001 09:34:17 -0400
Date: Tue, 21 Aug 2001 15:37:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@redhat.com>, Peter Wong <wpeter@us.ibm.com>,
        lse-tech@lists.sourceforge.net
Subject: [patch] zero-bounce highmem I/O #2, 2.4.9
Message-ID: <20010821153722.C1579@suse.de>
In-Reply-To: <20010821150938.A1579@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010821150938.A1579@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

DaveM was all over me, new patch is up. Changes:

- Add BLK_BOUNCE_ANY for hw that can access all of memory with the aid
  of remapping hardware - PCI_DMA_BUS_IS_PHYS (davem)
- Make blk_queue_bounce_limit 64-bit ok (davem)
- Remove redundant ifdef HIGHMEM (davem)
- Include cciss bh_phys fix (me)

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.9/block-highmem-all-10

-- 
Jens Axboe

