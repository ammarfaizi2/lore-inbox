Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318998AbSHFFnG>; Tue, 6 Aug 2002 01:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318999AbSHFFnG>; Tue, 6 Aug 2002 01:43:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23969 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318998AbSHFFnF>;
	Tue, 6 Aug 2002 01:43:05 -0400
Date: Tue, 6 Aug 2002 07:42:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Steven Cole <elenstev@mesatop.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>,
       Steven Cole <scole@lanl.gov>
Subject: Re: Linux v2.4.19-rc5
Message-ID: <20020806054258.GJ3975@suse.de>
References: <1028232945.3147.99.camel@spc9.esa.lanl.gov> <Pine.LNX.3.96.1020805234423.4423A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020805234423.4423A-100000@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05 2002, Bill Davidsen wrote:
> On 1 Aug 2002, Steven Cole wrote:
> 
> > Here are some dbench numbers, from the "for what it's worth" department.
> > This was done with SMP kernels, on a dual p3 box, SCSI disk, ext2.
> > The first column is dbench clients.  The numbers are throughput
> > in MB/sec.  The 2.5.29 kernel had a few RR-supplied smp fixes.
> > Looks like for this limited test, 2.4.19-rc5 holds up pretty well.
> > I've also ran this set of tests several times on -rc5 using ext3
> > and data=writeback, and everything looks fine.
> > 
> > Steven
> 
> Call me an optimist, but after all the reliability problems we had win the
> 2.5 series, I sort of hoped it would be better in performance, not
> increasingly worse. Am I misreading this? Can we fall back to the faster
> 2.4 code :-(

try a work load that excercises the block i/o layer alone (O_DIRECT,
raw, whatnot) and then compare 2.4 and 2.5. ibm had some slides on this
from ols, unfortunately I don't know if they have then online.

please don't put too much wait in dbench numbers for this sort of thing
:-)

-- 
Jens Axboe

