Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267535AbUIXHMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267535AbUIXHMT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 03:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268392AbUIXHMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 03:12:19 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:6193 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267535AbUIXHMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 03:12:17 -0400
Date: Fri, 24 Sep 2004 09:11:23 +0200
From: Jens Axboe <axboe@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1
Message-ID: <20040924071123.GC3394@suse.de>
References: <20040916024020.0c88586d.akpm@osdl.org> <20040924053031.GW9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924053031.GW9106@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23 2004, William Lee Irwin III wrote:
> On Thu, Sep 16, 2004 at 02:40:20AM -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm1/
> > - Added lots of Ingo's low-latency patches
> > - Lockmeter doesn't compile.  Don't enable CONFIG_LOCKMETER.
> > - Several architecture updates
> 
> Sorry to bother you again. I appear to get this after a couple days of
> uptime:
> 
> # ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at cfq_iosched:1395

is it the !allocated[rw] test again?

-- 
Jens Axboe

