Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316844AbSFKGMw>; Tue, 11 Jun 2002 02:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316845AbSFKGMv>; Tue, 11 Jun 2002 02:12:51 -0400
Received: from [195.63.194.11] ([195.63.194.11]:25870 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316844AbSFKGMu>; Tue, 11 Jun 2002 02:12:50 -0400
Message-ID: <3D0594DB.9070508@evision-ventures.com>
Date: Tue, 11 Jun 2002 08:12:43 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
In-Reply-To: <5.1.0.14.2.20020610114308.09306358@mail1.qualcomm.com> <Pine.GSO.4.05.10206102055280.17299-100000@mausmaki.cosy.sbg.ac.at> <20020610191959.GJ14252@opus.bloom.county> <3D04FE64.B92706E8@zip.com.au>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Tom Rini wrote:
> 
>>On Mon, Jun 10, 2002 at 08:57:02PM +0200, Thomas 'Dent' Mirlacher wrote:
>>
>>>On Mon, 10 Jun 2002, Maksim (Max) Krasnyanskiy wrote:
>>>
>>>
>>>>Hi Martin,
>>>>
>>>>How about replacing __FUNCTION__ with __func__ ?
>>>>GCC 3.x warns that __FUNCTION__ is obsolete and will be removed.
>>>
>>>is __func__ already supported for gcc 2.96?
>>
>>Well it works with 2.95.3, which is the important part...
> 
> 
> The 2.5 kernel must be buildable on gcc-2.91.66, aka egcs-1.1.2.
> 
> The 2.95.x requirement was reverted because sparc (or sparc64?)
> needs egcs-1.1.2.
> 
> __func__ does *not* work on egcs-1.1.2 and so cannot be used in Linux.
> 
> `struct blah = { .open = driver_open };' *does* work in egcs-1.1.2
> and is OK to use.

As far as I know all GCC compilers before 3.1 where utter crap on sparc64!


