Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289010AbSANUWz>; Mon, 14 Jan 2002 15:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289026AbSANUVU>; Mon, 14 Jan 2002 15:21:20 -0500
Received: from freeside.toyota.com ([63.87.74.7]:46597 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S289017AbSANUUX>; Mon, 14 Jan 2002 15:20:23 -0500
Message-ID: <3C433D7D.9030600@lexus.com>
Date: Mon, 14 Jan 2002 12:20:13 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: J Sloan <jjs@pobox.com>,
        Dieter =?ISO-8859-15?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020113201352Z288089-13997+4417@vger.kernel.org> <3C421946.6020607@pobox.com> <E16QAAF-0000mg-00@starship.berlin>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

>On January 14, 2002 12:33 am, J Sloan wrote:
>
>>Dieter Nützel wrote:
>>
>>>You told me that TUX show some problems with preempt before. What
>>>problems? Are they TUX specific?
>>>
>>On a kernel with both tux and preempt, upon
>>access to the tux webserver the kernel oopses
>>and tux dies...
>>
>
>Ah yes, I suppose this is because TUX uses per-cpu data as a replacement 
>for spinlocks.  Patches that use per-cpu shared data have to be 
>preempt-aware.  Ingo didn't know this when he wrote TUX since preempt didn't 
>exist at that time and didn't even appear to be on the horizon.  He's 
>certainly aware of it now.
>
I am looking forward to testing out the new code
;-)

>>OTOH the low latency patch plays quite well
>>with tux. As said, I have no anti-preempt agenda,
>>I just need for whatever solution I use to work,
>>and not crash programs and services we use.
>>
>
>Right, and of course that requires testing - sometimes a lot of it.  This one 
>is a 'duh' that escaped notice. temporarily.  It probably would have been 
>caught sooner if we'd started serious testing/discussion sooner.
>
Well I'm glad to hear that - I had been doing a lot of
preempt testing on my boxes, up until the time I started
using tux widely. When I told Robert of the tux/preempt
incompatibilties, he mentioned the per-cpu shared data
and said something to the effect that the tux problems
did not surprise him. I didn't get the feeling that tux was
high on his list of priorities.

Hopefully that is not the case after all -

Regards,

jjs



