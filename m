Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269326AbRIFXYx>; Thu, 6 Sep 2001 19:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269356AbRIFXYo>; Thu, 6 Sep 2001 19:24:44 -0400
Received: from cpe-24-221-114-147.az.sprintbbd.net ([24.221.114.147]:20611
	"EHLO localhost.digitalaudioresources.org") by vger.kernel.org
	with ESMTP id <S269326AbRIFXYe>; Thu, 6 Sep 2001 19:24:34 -0400
Message-ID: <3B980590.3010405@digitalaudioresources.org>
Date: Thu, 06 Sep 2001 16:24:00 -0700
From: David Hollister <david@digitalaudioresources.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dan Hollis <goemon@anime.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, tegeran@home.com,
        linux-kernel@vger.kernel.org
Subject: Re: K7/Athlon optimizations and Sacrifices to the Great Ones.
In-Reply-To: <Pine.LNX.4.30.0109061330420.8699-100000@anime.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Hollis wrote:
> On Thu, 6 Sep 2001, Alan Cox wrote:
> 
>>>At this point, I'd like to sacrifice a Red Hat Linux 6.2 CD to Alan Cox.
>>>I would also like to sacrifice Minix 1.3(?) installation diskettes to
>>>Linus Torvalds.
>>>I perform these sacrifices in the hope that enlightenment comes to me.
>>>
>>A deep booming voice says "I have no idea either"
>>
> 
> We need a good tester (floppy-bootable k7-killer, something along the
> lines of memtest86) and many more data points.
> 
> Anyone yet verified if burnMMX2 causes the same failures the
> athlon-optimized kernel does?
> 
> -Dan

MMX2 does not cause any problems for me.  Robert (the guy who wrote these) has 
provided me with two more versions that mimic the Athlon optimized 
fast_page_copy and fast_page_clear functions in mmx.c.  They aren't exact 
copies, but are close.  One fails for me consistently, the other does not.  The 
one that fails consistently is the one that mimics the fast_page_copy code.  I'm 
still trying to provide him more datapoints about the failures to see if we can 
uncover anything.

-- 
David Hollister
Driversoft Engineering:  http://devicedrivers.com
Digital Audio Resources: http://digitalaudioresources.org

