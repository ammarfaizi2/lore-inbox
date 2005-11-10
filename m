Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbVKJHyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbVKJHyJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 02:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbVKJHyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 02:54:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6450 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751260AbVKJHyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 02:54:08 -0500
Date: Thu, 10 Nov 2005 08:55:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, bernd@firmix.at
Subject: Re: [PATCH] blk: fix string handling in elv_iosched_store
Message-ID: <20051110075508.GT3699@suse.de>
References: <20051109171134.GA24115@htj.dyndns.org> <20051109180246.GA27759@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109180246.GA27759@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10 2005, Tejun Heo wrote:
> elv_iosched_store doesn't terminate string passed from userspace if
> it's too long.  Also, if the written length is zero (probably not
> possible), it accesses elevator_name[-1].  This patch fixes both bugs.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Bernd Petrovitsch <bernd@firmix.at>

Thanks applied.

-- 
Jens Axboe

