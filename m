Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbSJ2Hpn>; Tue, 29 Oct 2002 02:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261641AbSJ2Hpn>; Tue, 29 Oct 2002 02:45:43 -0500
Received: from packet.digeo.com ([12.110.80.53]:10898 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261640AbSJ2Hpm>;
	Tue, 29 Oct 2002 02:45:42 -0500
Message-ID: <3DBE3E1D.F505D85B@digeo.com>
Date: Mon, 28 Oct 2002 23:51:57 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.44-mm6 contest results
References: <1035855807.3dbde7bf1bda8@kolivas.net> <3DBE2EBE.DC860105@digeo.com> <20021029074025.GP2937@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Oct 2002 07:51:58.0170 (UTC) FILETIME=[0EAD13A0:01C27F20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Mon, Oct 28 2002, Andrew Morton wrote:
> > Con Kolivas wrote:
> > >
> > > io_load:
> > > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > > 2.5.44 [3]              873.8   9       69      12      12.24
> > > 2.5.44-mm1 [3]          347.3   22      35      15      4.86
> > > 2.5.44-mm2 [3]          294.2   28      19      10      4.12
> > > 2.5.44-mm4 [3]          358.7   23      25      10      5.02
> > > 2.5.44-mm5 [4]          270.7   29      18      11      3.79
> > > 2.5.44-mm6 [3]          284.1   28      20      10      3.98
> >
> > Jens, I think I prefer fifo_batch=16.  We do need to expose
> > these in /somewhere so people can fiddle with them.
> 
> I was hoping someone else would do comprehensive disk benchmarks with
> fifo_batch=32 and fifo_batch=16, but I guess that you have to currently
> change the define in the source doesn't make that very likely. I don't
> really like your global settings (for per-queue entities), but I guess
> they can suffice until a better approach is done.

Oh sure; it's just a hack so we can experiment with it.  Not that
anyone has, to my knowledge.

> I'll do some benching today.

Wouldn't hurt, but it's a complex problem.  Another approach would
be to quietly change it and see who squeaks ;)
