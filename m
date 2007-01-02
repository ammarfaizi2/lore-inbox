Return-Path: <linux-kernel-owner+w=401wt.eu-S932981AbXABIc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932981AbXABIc7 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 03:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932980AbXABIc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 03:32:59 -0500
Received: from brick.kernel.dk ([62.242.22.158]:16257 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932975AbXABIc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 03:32:59 -0500
Date: Tue, 2 Jan 2007 09:32:56 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: yc_zhou <yc_zhou@ncic.ac.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH  2.6.19] Adding branch to remove possible unnecessary inst
Message-ID: <20070102083255.GP2483@kernel.dk>
References: <459752B6.1020904@ncic.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459752B6.1020904@ncic.ac.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31 2006, yc_zhou wrote:
> Function blk_queue_bounce_limit using dma flag to determine whether
> assigned a certain value for member of request_queue_t. But the
> assignment is unconditionally after the flag is set. It introduce
> possible unnecessary instructions.

Your patch is white space damaged, it makes it hard to read and
impossible to apply.

Note that blk_queue_bounce_limit() is an initialization function, so not
much gained from optimizing on that.

-- 
Jens Axboe

