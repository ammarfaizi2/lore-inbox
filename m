Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318973AbSHFDtL>; Mon, 5 Aug 2002 23:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318974AbSHFDtL>; Mon, 5 Aug 2002 23:49:11 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:54287 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318973AbSHFDtK>; Mon, 5 Aug 2002 23:49:10 -0400
Date: Mon, 5 Aug 2002 23:46:21 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Steven Cole <elenstev@mesatop.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Jens Axboe <axboe@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>,
       Steven Cole <scole@lanl.gov>
Subject: Re: Linux v2.4.19-rc5
In-Reply-To: <1028232945.3147.99.camel@spc9.esa.lanl.gov>
Message-ID: <Pine.LNX.3.96.1020805234423.4423A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Aug 2002, Steven Cole wrote:

> Here are some dbench numbers, from the "for what it's worth" department.
> This was done with SMP kernels, on a dual p3 box, SCSI disk, ext2.
> The first column is dbench clients.  The numbers are throughput
> in MB/sec.  The 2.5.29 kernel had a few RR-supplied smp fixes.
> Looks like for this limited test, 2.4.19-rc5 holds up pretty well.
> I've also ran this set of tests several times on -rc5 using ext3
> and data=writeback, and everything looks fine.
> 
> Steven

Call me an optimist, but after all the reliability problems we had win the
2.5 series, I sort of hoped it would be better in performance, not
increasingly worse. Am I misreading this? Can we fall back to the faster
2.4 code :-(
 
> 		2.4.19-rc2	2.4.19-rc5	2.5.29
> 
> 1		114.616		113.402		112.668
> 2		173.234		183.829		175.148
> 3		185.995		187.411		184.63
> 4		185.447		186.891		188.199
> 6		191.115		191.439		191.787
> 8		191.962		191.551		191.53
> 10		192.984		194.036		194.923
> 12		183.847		185.73		195.328
> 16		183.609		183.439		196.224
> 20		181.519		179.956		193.681
> 24		183.509		183.387		194.09
> 28		176.04		175.832		169.326
> 32		174.583		163.09		137.815
> 36		155.04		164.154		121.861
> 40		155.37		156.028		102.014
> 44		152.546		138.171		91.6088
> 48		146.419		135.447		84.3884
> 52		139.788		125.968		89.2374
> 56		113.933		122.592		81.021
> 64		110.792		106.484		84.648
> 80				87.4692		60.6054
> 96				87.7201		57.9622
> 112				74.9503		49.468
> 128				67.2649		47.0254

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

