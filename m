Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267637AbSKTHXm>; Wed, 20 Nov 2002 02:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267641AbSKTHXW>; Wed, 20 Nov 2002 02:23:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54199 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267637AbSKTHXP>;
	Wed, 20 Nov 2002 02:23:15 -0500
Date: Wed, 20 Nov 2002 08:30:03 +0100
From: Jens Axboe <axboe@suse.de>
To: Robert Love <rml@tech9.net>
Cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.5.48-mm1 with contest
Message-ID: <20021120073003.GF11884@suse.de>
References: <1037741326.3ddaad0ef119d@kolivas.net> <1037741983.1504.2229.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037741983.1504.2229.camel@phantasy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19 2002, Robert Love wrote:
> On Tue, 2002-11-19 at 16:28, Con Kolivas wrote:
> 
> > xtar_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.5.48 [5]              184.4   41      2       6       2.52
> > 2.5.48-mm1 [5]          210.7   35      2       6       2.88
> >
> > read_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.5.48 [5]              102.9   74      6       4       1.41
> > 2.5.48-mm1 [5]          256.7   29      11      2       3.51*
> 
> What changed, Andrew?
> 
> Wall time is up but CPU is down... spending more time on I/O?

-mm is an io scheduler test base atm, expect fluctuations. Unless you
are working on it, dont worry about it.

-- 
Jens Axboe

