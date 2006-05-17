Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWEQHDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWEQHDq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 03:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWEQHDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 03:03:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4724 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932397AbWEQHDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 03:03:45 -0400
Date: Wed, 17 May 2006 09:01:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] block/ll_rw_blk.c: possible cleanups
Message-ID: <20060517070131.GC4197@suse.de>
References: <20060516174421.GM10077@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060516174421.GM10077@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16 2006, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - proper prototype for the following function:
>   - blk_dev_init()
> - #if 0 the following unused global function:
>   - blk_queue_invalidate_tags()
> - make the following needlessly global functions static:
>   - blk_alloc_queue_node()
>   - current_io_context()
> - remove the following unused EXPORT_SYMBOL's:
>   - blk_put_queue
>   - blk_get_queue
>   - blk_rq_map_user_iov

Looks good, queued for the next devel series.

-- 
Jens Axboe

