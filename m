Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315170AbSFELJc>; Wed, 5 Jun 2002 07:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315335AbSFELJc>; Wed, 5 Jun 2002 07:09:32 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:60178 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S315170AbSFELJa>; Wed, 5 Jun 2002 07:09:30 -0400
Message-ID: <3CFDF1E9.4040601@loewe-komp.de>
Date: Wed, 05 Jun 2002 13:11:37 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
In-Reply-To: <Pine.LNX.4.44.0206041418460.2614-100000@waste.org> <E17FQPj-0001Rr-00@starship>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> On Tuesday 04 June 2002 21:29, Oliver Xymoron wrote:
> 
>>On Mon, 3 Jun 2002, Daniel Phillips wrote:
>>
>>
>>>traditional IT.  Not to mention that I can look forward to a sound
>>>system where I can be *sure* my mp3s won't skip.
>>>
>>Not unless you're loading your entire MP3 into memory, mlocking it down,
>>and handing it off to a hard RT process. And then your control of the
>>playback of said song through a non-RT GUI could be arbitrarily coarse,
>>depending on load.
>>
> 
> Thanks for biting :-)
> 
> First, these days it's no big deal to load an entire mp3 into memory.  
> 
> Second, and of more interest to broadcasting industry professionals and the 
> like, it's possible to write a real-time filesystem that bypasses all the 
> normal non-realtime facilities of the operating system, and where the latency 
> of every operation is bounded according to the amount of data transferred.  
> Such a filesystem could use its own dedicated disk, or, more practically, the 
> RTOS (or realtime subsystem) could operate the disk's block queue.
> 
> If I recall correctly, XFS makes an attempt to provide such realtime 
> guarantees, or at least the Solaris version does.  However, the operating 
> system must be able to provide true realtime guarantees in order for the 
> filesystem to provide them, and I doubt that the combination of XFS and 
> Solaris can do that.
> 
> 

It's XFS with a realtime volume under Irix.
With the React extension Irix is also capable of "hard realtime".
But these days the term realtime is a lot misused - and leeds to
assumption of a better "system".

