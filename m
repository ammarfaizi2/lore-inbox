Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVEXIdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVEXIdq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 04:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVEXIch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 04:32:37 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:40816 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261475AbVEXI1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 04:27:08 -0400
Message-ID: <4292E559.3080302@yahoo.com.au>
Date: Tue, 24 May 2005 18:27:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Christoph Hellwig <hch@infradead.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
References: <1116890066.13086.61.camel@dhcp153.mvista.com> <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu> <4292DFC3.3060108@yahoo.com.au> <20050524081517.GA22205@elte.hu>
In-Reply-To: <20050524081517.GA22205@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Of course this is weighed off against the improvements added to the
>>kernel. I'm personally not too clear on what those improvements are; a
>>bit better soft-realtime response? (I don't know) [...]
> 
> 
> what the -RT kernel (PREEMPT_RT) offers are guaranteed hard-realtime 
> responses. ~15 usecs worst-case latency on a 2GHz Athlon64. On arbitrary 
> (SCHED_OTHER) workloads. (I.e. i've measured such worst-case latencies 
> when running 1000 hackbench tasks or when swapping the box to death, or 
> when running 40 parallel copies of the LTP testsuite.)
> 

Oh OK, I didn't realise it is aiming for hard RT. Cool! but
that wasn't so much the main point I was trying to make...

> so it's well worth the effort, but there's no hurry and all the changes 
> are incremental anyway. I can understand Daniel's desire for more action 
> (he's got a product to worry about), but upstream isnt ready for this 
> yet.
> 

Basically the same questions I think will still be up for debate.
Not that I want to start now, nor do I really have any feelings
on the matter yet (other than I'm glad you're not in a hurry :)).

For example, it may not be clear to everyone that it is
automatically well worth the effort ;) And others may really
want the functionality but prefer it to be done in a specialised
software like Christoph said.

Nick

