Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312053AbSCTJRl>; Wed, 20 Mar 2002 04:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312054AbSCTJRW>; Wed, 20 Mar 2002 04:17:22 -0500
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:18093 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S312053AbSCTJRP>;
	Wed, 20 Mar 2002 04:17:15 -0500
Message-ID: <3C985399.2090709@tmsusa.com>
Date: Wed, 20 Mar 2002 01:17:13 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jaroslav Kysela <perex@suse.cz>
CC: J Sloan <jjs@lexus.com>, "Wayne.Brown@altec.com" <Wayne.Brown@altec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.7 make modules_install error (oss)
In-Reply-To: <Pine.LNX.4.33.0203200923380.715-100000@pnote.perex-int.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaroslav Kysela wrote:

>On Tue, 19 Mar 2002, J Sloan wrote:
>
>>Agreed, the oss drivers should _at least_
>>be maintained as an alternative, e.g. for
>>those of us who want reliable sound with
>>*low latency*
>>
>><explanation>
>>I haven't checked lately, but not too long
>>ago the alsa drivers were found to be one
>>of the worst sources of latency in the kernel.
>></explanation>
>>
>
>You should really take care about your words. You've not written any
>technical reason to say these sentences. 
>
Fair enough - I don't see any technical
reasons why alsa *couldn't* perform as
well, latency wise, as oss.

>We are not aware about any
>problems against low-latency. 
>
Some folks on this list had been doing latency
profiling on their kernels during the past year
(sorry, I don't remember the exact dates) and
surprisingly the alsa driver was showing up
as one of the top sources of latency - IIRC one
possible explanation was "in-kernel mixing".

>Sure, OSS API emulation is only emulation,
>so there is additional layer which can be a bit slower than simplified
>native OSS drivers, but using ALSA API, we get really serious latencies
>even for multichannel hardware.
>
Thanks for the feedback, I'll have to do some
testing of my own and see what the situation
is at this point - I'd be very happy to learn that
my concerns are outdated and already resolved.

Joe

 					




