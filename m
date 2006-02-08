Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030464AbWBHJCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbWBHJCa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 04:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030586AbWBHJCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 04:02:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57700 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030464AbWBHJC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 04:02:29 -0500
Date: Wed, 8 Feb 2006 10:04:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: kill not-so-popular simple flag testing macros
Message-ID: <20060208090457.GF4338@suse.de>
References: <20060208085728.GA21065@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208085728.GA21065@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08 2006, Tejun Heo wrote:
> This patch kills the following request flag testing macros.
> 
> blk_noretry_request()
> blk_rq_started()
> blk_pm_suspend_request()
> blk_pm_resume_request()
> blk_sorted_rq()
> blk_barrier_rq()
> blk_fua_rq()
> 
> All above macros test for single request flag and not used widely and
> seem to contribute more to obscurity than readability.

Agreed, I've queued it up post-2.6.16

-- 
Jens Axboe

