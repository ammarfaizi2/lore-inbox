Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263539AbTCUHJI>; Fri, 21 Mar 2003 02:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263541AbTCUHJG>; Fri, 21 Mar 2003 02:09:06 -0500
Received: from dial-ctb04100.webone.com.au ([210.9.244.100]:3339 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S263539AbTCUHJC>;
	Fri, 21 Mar 2003 02:09:02 -0500
Message-ID: <3E7ABD15.1030005@cyberone.com.au>
Date: Fri, 21 Mar 2003 18:19:49 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Joel Becker <Joel.Becker@oracle.com>
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: WimMark I report for 2.5.65-mm2 (now with deadline)
References: <20030320204041.GO2835@ca-server1.us.oracle.com> <20030320175805.1625dbcc.akpm@digeo.com> <20030321024256.GW2835@ca-server1.us.oracle.com>
In-Reply-To: <20030321024256.GW2835@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:

>On Thu, Mar 20, 2003 at 05:58:05PM -0800, Andrew Morton wrote:
>
>>>WimMark I report for 2.5.65-mm2
>>>
>>>Runs (antic):  1374.22 1487.19 1437.26
>>>Runs (deadline):  1238.58 1537.36 1513.04
>>>
>>The averages of these are equal.  Can we safely conclude that this is fixed
>>up now?
>>
>
>	Not really, I think, because the 1238 seems a slightly fluke
>run.  I see these from time to time, but almost all of the deadline runs
>are in the 1500-1600 range.  In fact, -mm2 is lower than some other
>kernels by about 50 for deadline.
>	I wouldn't disagree with you if I didn't see that consistency.
>antic has never really jumped above 1500, and deadline almost never goes
>below.
>	Certainly they are much closer than they were.
>
The smaller first runs are not due to the benchmark running for the first
time, are they? In your mm1 tests you wrote:

>WimMark I report for 2.5.65-mm1
>
>Runs (antic):  1559.32 1025.38 1579.98
>Runs (deadline):  1554.48 1589.89 1350.37
>
So it does seem to be quite varied, but yes I'll keep working on it.
BTW. how do these results compare with 2.4 and other operating
systems on the same hardware, out of interest?

