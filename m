Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311596AbSCNMGa>; Thu, 14 Mar 2002 07:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311597AbSCNMGL>; Thu, 14 Mar 2002 07:06:11 -0500
Received: from [195.63.194.11] ([195.63.194.11]:28939 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311596AbSCNMGB>; Thu, 14 Mar 2002 07:06:01 -0500
Message-ID: <3C9091D6.6030301@evision-ventures.com>
Date: Thu, 14 Mar 2002 13:04:38 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Roberto Nibali <ratz@drugphish.ch>, linux-kernel@vger.kernel.org
Subject: Re: Question about the ide related ioctl's BLK* in 2.5.7-pre1 kernel
In-Reply-To: <3C9007F5.1000003@drugphish.ch> <3C900A11.55BA4B32@zip.com.au> <3C905894.90407@drugphish.ch> <3C905B9D.A1E3ACF6@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Roberto Nibali wrote:
> 
>>>They got collaterally damaged in the IDE "cleanup".  The patch at
>>>http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6/dallocbase-10-readahead.patch
>>>resurrects them.
>>>
>>Oh, I see. I've missed that patch of yours. I certainly enjoyed (maybe
>>much to your grief) the comments in the code :).
>>
> 
> hmm.  I'd better go back and check them then ;)
> 
> 
>>Is GFP_READAHEAD still a wish or did you drop that idea?
>>
> 
> Dropped.  Bad idea.  If we have to do I/O to gather the readahead pages
> then so be it.  That I/O will cluster well, as will the subsequent readahead,
> which is better than giving up on the readahead.
> 
> 
>>AFAICS you only
>>addressed the i386 arch with that patch, do you want the specific arch
>>maintainers to clean up their part when your patch is finished?
>>
> 
> ?  There's nothing arch-specific in any of this...

And there is nothing IDE related either. The code removed
at the time wasn't used!

