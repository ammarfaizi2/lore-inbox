Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbUC3HUy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 02:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263156AbUC3HUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 02:20:38 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:7828 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262378AbUC3HTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 02:19:05 -0500
Message-ID: <40691F46.1020200@yahoo.com.au>
Date: Tue, 30 Mar 2004 17:18:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andi Kleen <ak@suse.de>, jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
References: <20040325203032.GA15663@elte.hu> <20040329084531.GB29458@wotan.suse.de> <4068066C.507@yahoo.com.au> <20040329080150.4b8fd8ef.ak@suse.de> <20040329114635.GA30093@elte.hu> <20040329221434.4602e062.ak@suse.de> <4068B692.9020307@yahoo.com.au> <20040330083450.368eafc6.ak@suse.de> <20040330064015.GA19036@elte.hu> <20040330090716.67d2a493.ak@suse.de> <20040330071519.GA20227@elte.hu>
In-Reply-To: <20040330071519.GA20227@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Andi Kleen <ak@suse.de> wrote:
> 
> 
>>>Andi, could you please try the patch below - this will test whether this
>>>has to do with the rate of balancing between NUMA nodes. The patch
>>>itself is not correct (it way overbalances on NUMA), but it tests the
>>>theory.
>>
>>This works much better, but wildly varying (my tests go from 2.8xCPU
>>to ~3.8x CPU for 4 CPUs. 2,3 CPU cases are ok). A bit more consistent
>>results would be better though.
> 
> 
> ok, could you try min_interval,max_interval and busy_factor all with a
> value as 4, in sched.h's SD_NODE_INIT template? (again, only for testing
> purposes.)
> 

(sorry, forget what I said then, I'll leave it to Ingo)
