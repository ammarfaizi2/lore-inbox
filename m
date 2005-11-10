Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbVKJHnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbVKJHnz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 02:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVKJHnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 02:43:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:65324 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750879AbVKJHnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 02:43:55 -0500
Date: Thu, 10 Nov 2005 08:45:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk: run queue in elevator_switch
Message-ID: <20051110074500.GQ3699@suse.de>
References: <20051109171317.GB24115@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109171317.GB24115@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10 2005, Tejun Heo wrote:
> elevator_dispatch needs to run queue after forced dispatching;
> otherwise, the queue might stall.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Thanks, applied.

-- 
Jens Axboe

