Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281882AbRKSCMj>; Sun, 18 Nov 2001 21:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281878AbRKSCM3>; Sun, 18 Nov 2001 21:12:29 -0500
Received: from cpe.atm0-0-0-122182.0x3ef30264.bynxx2.customer.tele.dk ([62.243.2.100]:42889
	"HELO fugmann.dhs.org") by vger.kernel.org with SMTP
	id <S281877AbRKSCMY>; Sun, 18 Nov 2001 21:12:24 -0500
Message-ID: <3BF86A86.1010804@fugmann.dhs.org>
Date: Mon, 19 Nov 2001 03:12:22 +0100
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: John Jasen <jjasen1@umbc.edu>
Cc: John Jasen <jjasen@realityfailure.org>, linux-kernel@vger.kernel.org
Subject: Re: SiS630 chipsets && linux 2.4.x kernel == snails pace?
In-Reply-To: <Pine.SGI.4.31L.02.0111182006470.12243284-100000@irix2.gl.umbc.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/2001 02:07 AM, John Jasen wrote:

> On Sun, 18 Nov 2001, John Jasen wrote:
> 
> 
>>// RH 2.2.19-6.2.1
>>439.35user 54.86system 8:19.45elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
>>0inputs+0outputs (357039major+484758minor)pagefaults 0swaps
>>
>>// 2.4.12
>>
> 
> 5230.73user 52.88system 1:28:09elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (346527major+482788minor)pagefaults 0swaps


Funny how the system time is almost identical, while 10 times as much 
time is spend in userspace.
What does top say while compiling a kernel? (On a 2.4.12 system)

I just had this strange thought that the problem might not be with the 
disc, but a whole other place - like some process hogging the CPU, and 
not allowing gcc to do its job.

How does 'grep -r "somestring"' on 2.4.12 compre to 2.2.19?

Regards
Anders Fugmann


