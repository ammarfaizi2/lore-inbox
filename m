Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311396AbSCMWLD>; Wed, 13 Mar 2002 17:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311398AbSCMWKy>; Wed, 13 Mar 2002 17:10:54 -0500
Received: from [195.63.194.11] ([195.63.194.11]:64262 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311396AbSCMWKq>; Wed, 13 Mar 2002 17:10:46 -0500
Message-ID: <3C8FCE22.9090909@evision-ventures.com>
Date: Wed, 13 Mar 2002 23:09:38 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.6: ide driver broken in PIO mode
In-Reply-To: <Pine.LNX.4.21.0203131339050.26768-100000@serv> <a6o30m$25j$1@penguin.transmeta.com> <20020313203408.GD20220@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Mar 13 2002, Linus Torvalds wrote:
> 
>>In article <Pine.LNX.4.21.0203131339050.26768-100000@serv>,
>>Roman Zippel  <zippel@linux-m68k.org> wrote:
>>
>>>I first noticed the problem on my Amiga, but I can reproduce it on an ia32
>>>machine, when I turn off dma with hdparm.
>>>
>>With PIO, the current IDE/bio stuff doesn't like the write-multiple
>>interface and has bad interactions. 
>>
>>Jens, you talked about a patch from Supparna two weeks ago, any
>>progress?
>>
> 
> I can fix this tomorrow, the stuff from Supparna was just a small bio
> helper to retrieve the segments in a request. Just what we need for
> write-multi.

Yeep - I'm glad you are around :-).

