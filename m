Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbVKJRUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbVKJRUk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 12:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVKJRUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 12:20:40 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:55853 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751176AbVKJRUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 12:20:38 -0500
Date: Thu, 10 Nov 2005 18:21:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk: elv_latter/former_request update
Message-ID: <20051110172145.GG3699@suse.de>
References: <20051110142347.GC26030@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110142347.GC26030@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10 2005, Tejun Heo wrote:
> With generic dispatch queue update, implicit former/latter request
> handling using rq->queuelist.prev/next doesn't work as expected
> anymore.  Also, the only iosched dependent on this feature was
> noop-iosched and it has been reimplemented to have its own
> latter/former methods.  This patch removes implicit former/latter
> handling.

Thanks, applied.

-- 
Jens Axboe

