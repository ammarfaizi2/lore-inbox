Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268555AbUGXMmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268555AbUGXMmj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 08:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268557AbUGXMmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 08:42:39 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:33415 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S268555AbUGXMmg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 08:42:36 -0400
Message-ID: <410258FA.1010202@rtr.ca>
Date: Sat, 24 Jul 2004 08:41:30 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jens Axboe <axboe@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel	Preemption
 Patch
References: <1089673014.10777.42.camel@mindpipe>	 <20040712163141.31ef1ad6.akpm@osdl.org>	 <1089677823.10777.64.camel@mindpipe>	 <20040712174639.38c7cf48.akpm@osdl.org>	 <1089687168.10777.126.camel@mindpipe>	 <20040712205917.47d1d58b.akpm@osdl.org>	 <1089705440.20381.14.camel@mindpipe> <20040719104837.GA9459@elte.hu>	 <1090301906.22521.16.camel@mindpipe> <20040720061227.GC27118@elte.hu>	 <20040720121905.GG1651@suse.de> <1090642050.2871.6.camel@mindpipe>
In-Reply-To: <1090642050.2871.6.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note that the method used by hdparm tends to underreport
achievable throughput somewhat, because it generally only
ever has one I/O "in flight".

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")

Lee Revell wrote:
> On Tue, 2004-07-20 at 08:19, Jens Axboe wrote:
> 
>>On Tue, Jul 20 2004, Ingo Molnar wrote:
>>
>>>>How much I/O do you allow to be in flight at once?  It seems like by
>>>>decreasing the maximum size of I/O that you handle in one interrupt
>>>>you could improve this quite a bit.  Disk throughput is good enough,
>>>>anyone in the real world who would feel a 10% hit would just throw
>>>>hardware at the problem.
...
> According to hdparm, the throughput is still quite good (42MB/sec on a 
> sub-$100 IDE drive).


