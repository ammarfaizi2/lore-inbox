Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261704AbSI0Ofx>; Fri, 27 Sep 2002 10:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261706AbSI0Ofx>; Fri, 27 Sep 2002 10:35:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64200 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261704AbSI0Ofw>;
	Fri, 27 Sep 2002 10:35:52 -0400
Date: Fri, 27 Sep 2002 16:41:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <conman@kolivas.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.5.38-mm3 with contest 0.37
Message-ID: <20020927144104.GB15101@suse.de>
References: <1033043594.3d92fe8a8dd82@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033043594.3d92fe8a8dd82@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26 2002, Con Kolivas wrote:
> io_load:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  170.06          45%             2.36
> 2.5.38                  283.27          28%             3.92
> 2.5.38-mm2              106             75%             1.47*
> 2.5.38-mm3              95.9            84%             1.33*

this is encouraging to see, 2.5.38-mm3 has the new deadline io scheduler
and it appears to be performing well here too. I'm especially looking
forward to 2.5.38 vs 2.5.39 too, as 2.5.39 will have some deadline
updates that are not in -mm3.

-- 
Jens Axboe

