Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317204AbSEXQDQ>; Fri, 24 May 2002 12:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317200AbSEXQCM>; Fri, 24 May 2002 12:02:12 -0400
Received: from [195.63.194.11] ([195.63.194.11]:13840 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317181AbSEXP6Z>; Fri, 24 May 2002 11:58:25 -0400
Message-ID: <3CEE5415.7060906@evision-ventures.com>
Date: Fri, 24 May 2002 16:54:13 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jan Kara <jack@suse.cz>,
        Nathan Scott <nathans@sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: Quota patches
In-Reply-To: <3CEE51A4.9010308@evision-ventures.com> <E17BHfh-0006lp-00@the-village.bc.nu> <20020524165514.A20631@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Christoph Hellwig napisa?:
> On Fri, May 24, 2002 at 05:12:05PM +0100, Alan Cox wrote:
> 
>>>>Of course you can.  Even the latest OpenLinux release (shipping 2.4.13-ac)
>>>>uses a libc4/a.out based installer fo space reasons.  Not to forget the
>>>>old quake1 binary from some redhat 4.x CD I run from time to time :)
>>>
>>>OK thanks for the *substantial* answer. That was the reason I was asking about.
>>>Somehow this is of course surprising me of course.
>>
>>So why didn't you -test- the theory before suggesting it. It btw goes beyond
>>Libc4. Currently we have almost 100% compatibility back to libc 2.2.2. The
>>dated libc before that doesn't work because we dropped some very very
>>early obscure versions of a few syscalls.
>>
>>Is it too much to ask that you go and look through the syscall tables of
>>old and new kernels ? 
> 
> 
> For 2.5 I have some plans to make obsolete syscalls depend on CONFIG_COMPAT_*,
> this allows to compile big and bloated kernel for compatiblity and smaller
> kernels without that (e.g. for embedded devices).  And in fact we have quite
> a loft of cruft that can go away for setups only having very modern userspace..

I second this!

