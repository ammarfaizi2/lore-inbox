Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVEXJTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVEXJTh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVEXJRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:17:17 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:28816 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261876AbVEXJOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:14:32 -0400
Message-ID: <4292F074.7010104@yahoo.com.au>
Date: Tue, 24 May 2005 19:14:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Christoph Hellwig <hch@infradead.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
References: <1116890066.13086.61.camel@dhcp153.mvista.com> <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu> <4292DFC3.3060108@yahoo.com.au> <20050524081517.GA22205@elte.hu> <4292E559.3080302@yahoo.com.au> <20050524090240.GA13129@elte.hu>
In-Reply-To: <20050524090240.GA13129@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Oh OK, I didn't realise it is aiming for hard RT. Cool! but
>>that wasn't so much the main point I was trying to make...
>>
>>
>>>so it's well worth the effort, but there's no hurry and all the changes 
>>>are incremental anyway. I can understand Daniel's desire for more action 
>>>(he's got a product to worry about), but upstream isnt ready for this 
>>>yet.
>>>
>>
>>Basically the same questions I think will still be up for debate. Not 
>>that I want to start now, nor do I really have any feelings on the 
>>matter yet (other than I'm glad you're not in a hurry :)).
> 
> 
> i expect it to be pretty much like voluntary-preempt: there was much 
> flaming 9 months ago and by today 99% of the voluntary-preempt patches 
> are already in the upstream kernel and the remaining 1% (which just adds 
> the config option and touches one include file) i didnt submit yet.
> 

Oh? I thought the idea of the voluntary-preempt thing was to stick
cond_rescheds into might_sleep. At least that was the part I think
I objected to... but I don't think I was one of the participants in
that flamewar :)

> so i dont think there's much need to worry or even to decide anything 
> upfront: the merge is already happening. The two biggest preconditions 
> of PREEMPT_RT, the irq subsystem rewrite, and the spinlock-init API 
> cleanups are already upstream. The rest is just details or out-of-line 
> code. The discussions need to happen in small isolated steps, as the 
> component technologies are merged and discussed. The components are all 
> useful even without the final PREEMPT_RT step (which further proves the 
> usefulness of PREEMPT_RT - but you dont have to agree with that global 
> assertion).
> 

No definitely - if things can get merged bit by bit in small, agreeable
chunks then that is the best way of course.

> So i'm afraid nothing radical will happen anywhere. Maybe we can have 
> one final flamewar-party in the end when the .config options are about 
> to be added, just for nostalgia, ok? =B-)

Well from Daniel's message it seemed like things were not quite so far
along as you say.

Flamewar party? I'm afraid I don't have a thing to bring (... yet!)
I'm sure someone will invite themselves, for old time's sake :)


