Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266042AbSLCVC3>; Tue, 3 Dec 2002 16:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbSLCVC3>; Tue, 3 Dec 2002 16:02:29 -0500
Received: from franka.aracnet.com ([216.99.193.44]:6327 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266042AbSLCVCU>; Tue, 3 Dec 2002 16:02:20 -0500
Date: Tue, 03 Dec 2002 13:09:42 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>
cc: Christoph Hellwig <hch@sgi.com>, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
Message-ID: <124510000.1038949781@titus>
In-Reply-To: <3DED18CC.5770EA90@digeo.com>
References: <20021202192652.A25938@sgi.com>
 <1919608311.1038822649@[10.10.2.3]> <3DEBB4BD.F64B6ADC@digeo.com>
 <20021202195003.GC28164@dualathlon.random> <3DED18CC.5770EA90@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> please try with my tree.
>
> It is greatly improved.  It is still not as smooth as the standard 2.4
> scheduler, but I'd characterise it as "a bit jerky" rather than "makes
> me want to punch a hole in the monitor".
>
> The difference is unlikely to be noticed by many.  (But it should be
> _better_ than stock 2.4)

...

>> can you reproduce with my tree?
>
> Again, hugely improved over normal O(1) behaviour, but not as responsive
> as the stock 2.4 scheduler.

Andrea, which patches in your tree are the ones that fix this?
If it's the big-monster one ... any chance you could split out
the bits actually fix it? I'd love to be able to apply your fixes
to 2.5 and try them there ....

Thanks,

M.

