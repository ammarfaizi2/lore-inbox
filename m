Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVC2Iam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVC2Iam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVC2IMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 03:12:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:61924 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262185AbVC2IGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 03:06:50 -0500
Date: Tue, 29 Mar 2005 10:06:47 +0200
From: Jens Axboe <axboe@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] use cheaper elv_queue_empty when unplug a device
Message-ID: <20050329080646.GE16636@suse.de>
References: <200503290253.j2T2rqg25691@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503290253.j2T2rqg25691@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28 2005, Chen, Kenneth W wrote:
> This patch was posted last year and if I remember correctly, Jens said
> he is OK with the patch.  In function __generic_unplug_deivce(), kernel
> can use a cheaper function elv_queue_empty() instead of more expensive
> elv_next_request to find whether the queue is empty or not. blk_run_queue
> can also made conditional on whether queue's emptiness before calling
> request_fn().
> 
> 
> Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

Looks good, thanks.

Signed-off-by: Jens Axboe <axboe@suse.de>

-- 
Jens Axboe

