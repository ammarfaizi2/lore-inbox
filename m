Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264210AbSJ3Gm1>; Wed, 30 Oct 2002 01:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbSJ3Gm1>; Wed, 30 Oct 2002 01:42:27 -0500
Received: from packet.digeo.com ([12.110.80.53]:59575 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264210AbSJ3Gm1>;
	Wed, 30 Oct 2002 01:42:27 -0500
Message-ID: <3DBF80C6.9DB6D9F8@digeo.com>
Date: Tue, 29 Oct 2002 22:48:38 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Pavan Kumar Reddy N.S." <pavan.kumar@wipro.com>
CC: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: AIM Bench Mark results for different kernels
References: <7F396B9772328640B7593FA817EEEDAD05FF3C@blr-m3-msg.wipro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Oct 2002 06:48:39.0088 (UTC) FILETIME=[60A8EB00:01C27FE0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pavan Kumar Reddy N.S." wrote:
> 
> 
> AIM Independent Resource Benchmark - Suite IX v1.1, January 22, 1996
> Copyright (c) 1996 - 2001 Caldera International, Inc. All Rights
> Reserved
> 
>

Thanks.

This would be enormously less painful to read if you could fix
your mailer to not word-wrap your content.

All the compute-intensive workloads are down ~1% because of the
increase of HZ from 100 to 1000.

Things like "sequential disk reads (K)/second" would be more 
interesting if they were accompanied by CPU utilisation.  But then,
CPU utilisation comparisons with 2.4 kernels are suspect because of
the HZ change.  Probably it would be more informative if the 2.5
kernel was altered to run at HZ=100, or run 2.4 at HZ-1000.

2.5.43 outperformed 2.5.42 and 2.5.44 by a *lot* in many tests.
That is unexpected.  It might be worth double-checking that result.
