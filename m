Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261630AbSJ2HeU>; Tue, 29 Oct 2002 02:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261639AbSJ2HeT>; Tue, 29 Oct 2002 02:34:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36071 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261630AbSJ2HeT>;
	Tue, 29 Oct 2002 02:34:19 -0500
Date: Tue, 29 Oct 2002 08:40:25 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.44-mm6 contest results
Message-ID: <20021029074025.GP2937@suse.de>
References: <1035855807.3dbde7bf1bda8@kolivas.net> <3DBE2EBE.DC860105@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DBE2EBE.DC860105@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28 2002, Andrew Morton wrote:
> Con Kolivas wrote:
> > 
> > io_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.5.44 [3]              873.8   9       69      12      12.24
> > 2.5.44-mm1 [3]          347.3   22      35      15      4.86
> > 2.5.44-mm2 [3]          294.2   28      19      10      4.12
> > 2.5.44-mm4 [3]          358.7   23      25      10      5.02
> > 2.5.44-mm5 [4]          270.7   29      18      11      3.79
> > 2.5.44-mm6 [3]          284.1   28      20      10      3.98
> 
> Jens, I think I prefer fifo_batch=16.  We do need to expose
> these in /somewhere so people can fiddle with them.

I was hoping someone else would do comprehensive disk benchmarks with
fifo_batch=32 and fifo_batch=16, but I guess that you have to currently
change the define in the source doesn't make that very likely. I don't
really like your global settings (for per-queue entities), but I guess
they can suffice until a better approach is done.

I'll do some benching today.

-- 
Jens Axboe

