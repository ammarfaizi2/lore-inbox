Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314512AbSE2HYr>; Wed, 29 May 2002 03:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314494AbSE2HYr>; Wed, 29 May 2002 03:24:47 -0400
Received: from hicks.adgrafix.com ([64.55.193.2]:40913 "EHLO
	hicks.adgrafix.com") by vger.kernel.org with ESMTP
	id <S314227AbSE2HYp>; Wed, 29 May 2002 03:24:45 -0400
Message-ID: <3CF481EF.9010106@tungstengraphics.com>
Date: Wed, 29 May 2002 08:23:27 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.18: DRM + cmpxchg issues
In-Reply-To: <3CF33C10.1090302@tungstengraphics.com> <3CF427E4.79042F@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> Keith Whitwell wrote:
> 
>>Adam,
>>
>>I expect the answer is that we need to dig out the old one.
>>
>>Previously I don't think the full cmpxchg semantics werere required unless the
>>box is smp -- there's no case where atomic operations are required for
>>hardware interaction, for example.  ...
>>
>>Probably this changed with preempt, though, so we need one even on UP boxes...
>>
>>
> I can not think of any reason to need a lock or atomic
> operation because of preempt.  Even the management of the
> preempt on/off flags at most requires memory barriers, even
> in SMP boxen.  Do you have an example?

No, I was just pointing out grey areas in my own knowledge.

Keith

