Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279986AbRKVQ1l>; Thu, 22 Nov 2001 11:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279988AbRKVQ1b>; Thu, 22 Nov 2001 11:27:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29959 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S279986AbRKVQ1Z>;
	Thu, 22 Nov 2001 11:27:25 -0500
Date: Thu, 22 Nov 2001 17:27:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] block-highmem-all-18b
Message-ID: <20011122172700.I19902@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A minor update version, nothing major. Changes:

- Megaraid highmem I/O enabled again, since 2.4.14 this should be safe.
  Verified by Arjan. (me)
- Change can_dma_32 to highmem_io to make the meaning more clear (me).
- Drop discontig pfn change for now (me)

Find it here:

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.15-pre9/block-highmem-all-18b.bz2

-- 
Jens Axboe

