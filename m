Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUCLBXn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 20:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbUCLBXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 20:23:43 -0500
Received: from holomorphy.com ([207.189.100.168]:51986 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261879AbUCLBXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 20:23:34 -0500
Date: Thu, 11 Mar 2004 17:23:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       kenneth.w.chen@intel.com
Subject: Re: [PATCH] per-backing dev unplugging #2
Message-ID: <20040312012327.GA655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jens Axboe <axboe@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, kenneth.w.chen@intel.com
References: <20040311083619.GH6955@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040311083619.GH6955@suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 09:36:19AM +0100, Jens Axboe wrote:
> Final version, unless something stupid pops up. Changes:
> - Adapt to 2.6.4-mm1
> - Cleaned up the dm bits, much nicer with the lockless unplugging
>   (thanks Joe)
> - md and loop unplugging, stacked devices should unplug their targets.
>   Otherwise they'll end up waiting for the unplug timer, which sucks.
> - XFS fixed up, I hope. XFS folks still encouraged to look at this,
>   looks better this time around though (and works, I tested).
> - blk_run_* inlined in blkdev.h
> Against 2.6.4-mm1 (note you need other attached patch to boot it).

There was a decent improvement here. I'll get some numbers up after
I rerun (ETA 2 hours) since I blew away the results in reformatting.


-- wli

