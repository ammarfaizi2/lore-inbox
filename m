Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281242AbRKPIj5>; Fri, 16 Nov 2001 03:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281245AbRKPIjr>; Fri, 16 Nov 2001 03:39:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35333 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281242AbRKPIjm>;
	Fri, 16 Nov 2001 03:39:42 -0500
Date: Fri, 16 Nov 2001 09:39:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] block-highmem-all-18
Message-ID: <20011116093927.E27010@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Version #18 of the patch, the prepare-for-inclusion version. Changes:

- Drop IPS and megaraid changes, too problematic. If anyone has the
  hardware to really test this and do it properly (aimed at IPS), please
  do so and send it on. (me)
- Add CONFIG_HIGHIO configure option, has same effect as the nohighio
  boot parameter (me)
- Add sym2 can_dma_32 flag (me)
- aic7xxx_old can_dma_32 flag (me)

Against 2.4.15-pre5, find it here:

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.15-pre5/block-highmem-all-18.bz2

-- 
Jens Axboe

