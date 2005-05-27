Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVE0J0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVE0J0l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 05:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVE0JYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 05:24:14 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:26264 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262401AbVE0JL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 05:11:59 -0400
Message-ID: <4296E45B.1080509@yahoo.com.au>
Date: Fri, 27 May 2005 19:11:55 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] improve SMP reschedule and idle routines
References: <4296CA7A.4050806@cyberone.com.au> <20050527085726.GA20512@elte.hu>
In-Reply-To: <20050527085726.GA20512@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <piggin@cyberone.com.au> wrote:
> 
> 
>>OK, done a bit of work on all other architectures, and diffed to the
>>latest -mm. Any chance you can put it in -mm, Andrew?
>>
>>Also, while I was there, I thought I'd add the set_need_resched() 
>>thing to all the other architectures. I couldn't be bothered doing 2 
>>patches, sorry.
> 
> 
> the need_resched changes are not needed meanwhile - we can do the first 
> schedule() in rest_init() just fine. (See my earlier patch below.) So 
> please keep the need_resched thing out of your patch.
> 

OK that's better. Sorry I didn't see your patch earlier.

I'll redo this patch. Coming up...

Send instant messages to your online friends http://au.messenger.yahoo.com 
