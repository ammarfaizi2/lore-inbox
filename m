Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315230AbSEDWre>; Sat, 4 May 2002 18:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315232AbSEDWre>; Sat, 4 May 2002 18:47:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32260 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315230AbSEDWrd>; Sat, 4 May 2002 18:47:33 -0400
Message-ID: <3CD464CA.8010309@zytor.com>
Date: Sat, 04 May 2002 15:46:34 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020312
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Subject: Re: IO stats in /proc/partitions
In-Reply-To: <E1748Oo-0000Ub-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>Earlier I noticed that RedHat did put some statistics in
>>/proc/partitions. That was bad, but I assumed that it was
>>their laziness, being too busy to do a proper job.
> 
> It was put there in the 2.2 era after discussion with various folks. Its
> been in most vendor kernels for about four years.
> 
>>On the other hand, disk statistics should not be in
>>/proc/partitions. They should be in /proc/diskstatistics.
>>I see a heading today "rio rmerge rsect ruse wio wmerge"
>>"wsect wuse running use aveq". No doubt next year we'll
>>want different statistics. So /proc/diskstatistics should
>>start with a header line including a version field.
> 
> The stats have been unchanged for years too. As to version lines 
> why ? This is lets mke /proc XML hell again
> 
>>Please keep these disk statistics apart from /proc/partitions.
> 
> It has to contain each partiiton anyway. 

If we're going to add stuff to /proc/partitions, I'd really like to see 
it contain: a) parent device, and b) offset.

	-hpa

