Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267350AbUHECNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267350AbUHECNI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 22:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267361AbUHECNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 22:13:08 -0400
Received: from gizmo04ps.bigpond.com ([144.140.71.14]:34003 "HELO
	gizmo04ps.bigpond.com") by vger.kernel.org with SMTP
	id S267350AbUHECNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 22:13:05 -0400
Message-ID: <411197AB.8060809@bigpond.net.au>
Date: Thu, 05 Aug 2004 12:12:59 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: Re: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler Evaluation
References: <20040803020345.GU2334@holomorphy.com> <410F08D6.5050200@bigpond.net.au> <20040803104912.GW2334@holomorphy.com> <41102FE5.9010507@bigpond.net.au> <20040804005034.GE2334@holomorphy.com> <41103DBB.6090100@bigpond.net.au> <20040804015115.GF2334@holomorphy.com> <41104C8F.9080603@bigpond.net.au> <20040804074440.GL2334@holomorphy.com> <4111882B.9090504@bigpond.net.au> <20040805020041.GQ2334@holomorphy.com>
In-Reply-To: <20040805020041.GQ2334@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>Software constructs are less of a concern. This also presumes that
>>>taking timer interrupts when cpu-intensive workloads voluntarily
>>>yield often enough is necessary or desirable.
> 
> 
> On Thu, Aug 05, 2004 at 11:06:51AM +1000, Peter Williams wrote:
> 
>>Voluntary yielding can't be relied upon.  Writing a program that never 
>>gives up the CPU voluntarily is trivial.  Some have been known to do it 
>>without even trying :-)
> 
> 
> No reliance is implied. In such a scenario, the timers for timeslice
> expiry are always cancelled because userspace voluntarily yields first,
> so no timer interrupts are delivered. Should userspace fail to do so,
> timer interrupts programmed for timeslice expiry would not be cancelled.

OK.  My misunderstanding.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

