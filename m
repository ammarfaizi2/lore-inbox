Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283293AbRK2QFU>; Thu, 29 Nov 2001 11:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283291AbRK2QFK>; Thu, 29 Nov 2001 11:05:10 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:49320 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S283288AbRK2QFD>; Thu, 29 Nov 2001 11:05:03 -0500
Message-ID: <3C065C0A.7050809@antefacto.com>
Date: Thu, 29 Nov 2001 16:02:18 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Wayne Scott <wscott@bitmover.com>, jmd@turbogeek.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Extraneous whitespace removal?
In-Reply-To: <20011129.094040.124092017.wscott@bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne Scott wrote:

> From: Jeremy M. Dolan <jmd@turbogeek.org>
> 
>>Pluses:
>> - clean up messy whitespace
>> - cut precious picoseconds off compile time
>> - cut kernel tree by 200k (+/- alot)
>>
>>Minuses:
>> - adds 3.8M bzip2 or 4.7M gzip to next diff
>>
> 
> As someone who has spend a lot of time working on version control and
> file merging, let be tell you the big minus you missed. 
> 
> After this patch go into the Linux kernel, everyone who is maintaining
> a set of patches in parallel with the main kernel has a lot of extra
> work resolving the conflicts caused by this change.


Which is why 2.5.1 is the only time it can go in.
It would save 140K compressed (bz2) which kernel.org
would probably appreciate, but it's probably too late
already so the next best is always do it for subsequent patches.
Perhaps their should be a patch_pp script that does runs
both Lindent and strip_ws? Actually Alan Cox mentioned to
me that pine had a bug where it stripped whitespace at end
of lines :-) can't depend on that though.

Padraig.

