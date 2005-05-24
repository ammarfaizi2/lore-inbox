Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVEXLZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVEXLZm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 07:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVEXLZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 07:25:42 -0400
Received: from relay01.pair.com ([209.68.5.15]:44038 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S261981AbVEXLWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 07:22:36 -0400
X-pair-Authenticated: 24.241.238.70
Message-ID: <42930E79.1030305@cybsft.com>
Date: Tue, 24 May 2005 06:22:33 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
References: <1116890066.13086.61.camel@dhcp153.mvista.com> <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu> <4292DFC3.3060108@yahoo.com.au> <20050524081517.GA22205@elte.hu> <4292E559.3080302@yahoo.com.au>
In-Reply-To: <4292E559.3080302@yahoo.com.au>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Ingo Molnar wrote:
> 
>> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>
>>
>>> Of course this is weighed off against the improvements added to the
>>> kernel. I'm personally not too clear on what those improvements are; a
>>> bit better soft-realtime response? (I don't know) [...]
>>
>>
>>
>> what the -RT kernel (PREEMPT_RT) offers are guaranteed hard-realtime
>> responses. ~15 usecs worst-case latency on a 2GHz Athlon64. On
>> arbitrary (SCHED_OTHER) workloads. (I.e. i've measured such worst-case
>> latencies when running 1000 hackbench tasks or when swapping the box
>> to death, or when running 40 parallel copies of the LTP testsuite.)
>>
> 
> Oh OK, I didn't realise it is aiming for hard RT. Cool! but
> that wasn't so much the main point I was trying to make...
> 
>> so it's well worth the effort, but there's no hurry and all the
>> changes are incremental anyway. I can understand Daniel's desire for
>> more action (he's got a product to worry about), but upstream isnt
>> ready for this yet.
>>
> 
> Basically the same questions I think will still be up for debate.
> Not that I want to start now, nor do I really have any feelings
> on the matter yet (other than I'm glad you're not in a hurry :)).
> 
> For example, it may not be clear to everyone that it is
> automatically well worth the effort ;) And others may really
> want the functionality but prefer it to be done in a specialised
> software like Christoph said.
> 
> Nick
> 

There are definitely those who would prefer to have the functionality,
at least as an option, in the mainline kernel. The group that I contract
for get heartburn about having to patch every kernel running on every
development workstation and every production system. We need hard RT,
but currently when we have to have hard RT we go with a different
product. Another thing that some of us want/need is a hard real-time
Linux that doesn't create the segregation that most of these specialized
products create. Currently there are damn few choices for real posix
applications development with hard RT requirements running in a Unix
environment.

-- 
   kr
