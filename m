Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315515AbSECBEX>; Thu, 2 May 2002 21:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315517AbSECBEW>; Thu, 2 May 2002 21:04:22 -0400
Received: from [195.63.194.11] ([195.63.194.11]:57617 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315515AbSECBEV>; Thu, 2 May 2002 21:04:21 -0400
Message-ID: <3CD1D357.4050906@evision-ventures.com>
Date: Fri, 03 May 2002 02:01:27 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Tom Oehser <tom@toms.net>
CC: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: module choices affecting base kernel size???
In-Reply-To: <Pine.LNX.4.44.0205022054160.8024-100000@conn6m.toms.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Tom Oehser napisa?:
>>Tom Oehser <tom@toms.net> wrote:
>>
>>>Changing all =m to =n in my config makes a 4K difference in the kernel size.
>>
> 
> On Fri, 3 May 2002, Keith Owens wrote:
> 
> 
>>The majority of modules have no effect on kernel size but some modules
>>require base kernel code as well.  This is typically common code or low
>>level setup functions.  You will find that those modules will not load
>>now or will break.
> 
> 
> Great.  I must have missed the list of exactly *which* modules do this...
> 
> Any ideas on a reasonable way of how to identify them?

Please grep for EXPORT_SYMBOL().

