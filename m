Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUHIPUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUHIPUy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266347AbUHIPSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:18:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40928 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264238AbUHIPPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 11:15:47 -0400
Date: Mon, 9 Aug 2004 17:15:17 +0200
From: Jens Axboe <axboe@suse.de>
To: brking@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] blk_queue_export_resize_tags
Message-ID: <20040809151516.GY10418@suse.de>
References: <200408091445.i79EjOeQ079636@northrelay04.pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408091445.i79EjOeQ079636@northrelay04.pok.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09 2004, brking@us.ibm.com wrote:
> 
> Exports blk_queue_resize_tags since it is an exported interface.
> 
> Signed-off-by: Brian King <brking@us.ibm.com>
> ---
> 
>  linux-2.6.8-rc3-bjking1/drivers/block/ll_rw_blk.c |    2 ++
>  1 files changed, 2 insertions(+)
> 
> diff -puN drivers/block/ll_rw_blk.c~blk_queue_export_resize_tags drivers/block/ll_rw_blk.c
> --- linux-2.6.8-rc3/drivers/block/ll_rw_blk.c~blk_queue_export_resize_tags	2004-08-09 09:40:46.000000000 -0500
> +++ linux-2.6.8-rc3-bjking1/drivers/block/ll_rw_blk.c	2004-08-09 09:41:02.000000000 -0500
> @@ -653,6 +653,8 @@ int blk_queue_resize_tags(request_queue_
>  	return 0;
>  }
>  
> +EXPORT_SYMBOL(blk_queue_resize_tags);
> +
>  /**
>   * blk_queue_end_tag - end tag operations for a request
>   * @q:  the request queue for the device

I've passed it in, thanks.

-- 
Jens Axboe

