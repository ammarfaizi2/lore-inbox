Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266186AbTBPJnr>; Sun, 16 Feb 2003 04:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266199AbTBPJnq>; Sun, 16 Feb 2003 04:43:46 -0500
Received: from c16639.thoms1.vic.optusnet.com.au ([210.49.244.5]:7822 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S266186AbTBPJno>;
	Sun, 16 Feb 2003 04:43:44 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [BENCHMARK] 2.5.61-mm1 +/- as or cfq with contest
Date: Sun, 16 Feb 2003 20:53:36 +1100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Nick Piggin <piggin@cyberone.com.au>
References: <200302162046.42103.kernel@kolivas.org> <20030216095149.GA6521@suse.de>
In-Reply-To: <20030216095149.GA6521@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302162053.36119.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Feb 2003 08:51 pm, Jens Axboe wrote:
> On Sun, Feb 16 2003, Con Kolivas wrote:
> > Here are contest (http://contest.kolivas.org) results with osdl
> > (http://www.osdl.org) hardware for 2.5.61-mm1 with either the as i/o
> > scheduler or the cfq scheduler.
> >
> > io_load:
> > Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
> > 2.5.60-mm1          3   112     67.0    15.7    7.1     1.42
> > 2.5.61              2   143     52.4    32.9    13.3    1.81
> > 2.5.61-mm1          2   634     12.5    257.3   24.6    7.83
> > 2.5.61-mm1cfq       3   397     19.6    123.3   18.1    5.03
>
> These loo fishy, could be some other interaction. I'm consistently
> beating 2.5.60-mm1/2.5.61 on io_load here, but that is 2.5.61 base and
> not 2.5.61-mm1 base. Could be something odd happening there.

I dont think they're fishy - taken in the mm1 context -. I have tested cfq3a 
without mm1 and it does beat the baseline. See a previous email I posted with 
it.

Con
