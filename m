Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311597AbSCNMNl>; Thu, 14 Mar 2002 07:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311599AbSCNMNd>; Thu, 14 Mar 2002 07:13:33 -0500
Received: from [195.63.194.11] ([195.63.194.11]:33803 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311597AbSCNMN1>; Thu, 14 Mar 2002 07:13:27 -0500
Message-ID: <3C90939E.4070409@evision-ventures.com>
Date: Thu, 14 Mar 2002 13:12:14 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Roberto Nibali <ratz@drugphish.ch>, linux-kernel@vger.kernel.org
Subject: Re: Question about the ide related ioctl's BLK* in 2.5.7-pre1 kernel
In-Reply-To: <3C9007F5.1000003@drugphish.ch> <3C900A11.55BA4B32@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Roberto Nibali wrote:
> 
>>Hi,
>>
>>What for are BLKRAGET, BLKFRAGET and BLKSECTGET still needed?
>>
> 
> They got collaterally damaged in the IDE "cleanup".  The patch at
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6/dallocbase-10-readahead.patch
> resurrects them.

This is WRONG. What I did here was just removal of unused code.
They got obsoleted by the BIO infrastructure changes.

