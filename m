Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283721AbRK3T5v>; Fri, 30 Nov 2001 14:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283771AbRK3T5m>; Fri, 30 Nov 2001 14:57:42 -0500
Received: from mail2.home.nl ([213.51.129.226]:57237 "EHLO mail2.home.nl")
	by vger.kernel.org with ESMTP id <S283711AbRK3T5Y>;
	Fri, 30 Nov 2001 14:57:24 -0500
Message-ID: <3C07E4B7.1060109@home.nl>
Date: Fri, 30 Nov 2001 20:57:43 +0100
From: Gertjan van Wingerde <gwingerde@home.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011123
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Compile fixes for 2.5.1-pre4
In-Reply-To: <3C07D770.3010807@home.nl> <20011130201231.G22698@suse.de> <3C07DD68.30707@home.nl> <20011130203155.A25987@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> On Fri, Nov 30 2001, Gertjan van Wingerde wrote:
> 
>>Jens Axboe wrote:
>>
>>
>>>On Fri, Nov 30 2001, Gertjan van Wingerde wrote:
>>>
>>>
>>>>	3. Linear MD code
>>>>	4. RAID-0 MD code
>>>>
>>>>
>>>Have you verified that it works, or are these just compile fixes?
>>>
>>>
>>>
>>They are just compile fixes. However, these are pretty simple conversions.
>>
> 
> Note that there is no straight conversion between before having a 1-1
> mapping between a buffer_head and a data element and now potentially a
> 1-n mapping with bio. If you are just remapping, no problem.
> 
> So I'd rather not take these patches unless you've looked into why it
> _does_ (or maybe does not) work. I'll make note to review them soon, ok?
> 
> 

Okay. BTW I'm currently setting up my machine to run some tests on this 
code (I'll have to find some current version of raidtools first :-(.

-- 
	MvG,

		Gertjan

----------

Gertjan van Wingerde
Geessinkweg 177
7544 TX Enschede
The Netherlands
E-mail: gwingerde@home.nl

