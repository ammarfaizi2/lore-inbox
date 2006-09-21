Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWIUSfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWIUSfv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 14:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWIUSfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 14:35:51 -0400
Received: from brick.kernel.dk ([62.242.22.158]:42837 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750948AbWIUSfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 14:35:50 -0400
Date: Thu, 21 Sep 2006 20:40:24 +0200
From: Jens Axboe <axboe@kernel.dk>
To: michaelc@cs.wisc.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] block: support larger block pc requests take 2
Message-ID: <20060921184024.GB16556@kernel.dk>
References: <11583761161108-git-send-email-michaelc@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11583761161108-git-send-email-michaelc@cs.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15 2006, michaelc@cs.wisc.edu wrote:
> From: Mike Christie <michaelc@cs.wisc.edu>
> 
> This patch modifies blk_rq_map/unmap_user() so that it supports
> requests larger than bio by chaning them together.
> 
> Changes since v1.
> 1. Removed blk_get_bounced_bio() function. blk_rq_unmap_user
> checks the bounced flag and if set access bi_private.
> 
> 2. Removed biohead_orig field from request.
> Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>

Patches 1+2 applied, thanks Mike!


-- 
Jens Axboe

