Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314829AbSE0JQq>; Mon, 27 May 2002 05:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314957AbSE0JQp>; Mon, 27 May 2002 05:16:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14540 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314829AbSE0JQo>;
	Mon, 27 May 2002 05:16:44 -0400
Date: Mon, 27 May 2002 11:16:26 +0200
From: Jens Axboe <axboe@suse.de>
To: Christopher Hoover <ch@hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, ch@murgatroid.com
Subject: Re: [PATCH] SCSI as module lossage in 2.5.1[56]
Message-ID: <20020527091626.GH17674@suse.de>
In-Reply-To: <20020520120756.A8951@friction.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20 2002, Christopher Hoover wrote:
> SCSI as a module (CONFIG_SCSI=m) loses in 2.5.1[56] because scsi_mod.o
> needs drivers/block/ll_rw_blk.c:blk_max_pfn and that symbol isn't exported.

Thanks, applied

-- 
Jens Axboe

