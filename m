Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbTKELVb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 06:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbTKELVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 06:21:31 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:20971 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262844AbTKELVa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 06:21:30 -0500
Message-ID: <3FA8DB9F.1090708@cyberone.com.au>
Date: Wed, 05 Nov 2003 22:14:39 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
References: <3FA69CDF.5070908@gmx.de> <20031105084007.GZ1477@suse.de> <3FA8C916.3060702@gmx.de> <20031105095457.GG1477@suse.de> <3FA8CA87.2070201@gmx.de> <20031105100120.GH1477@suse.de> <3FA8CCF9.6070700@gmx.de> <3FA8D059.7010204@cyberone.com.au> <20031105102904.GK1477@suse.de> <3FA8D2B6.5020508@gmx.de>
In-Reply-To: <3FA8D2B6.5020508@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Prakash K. Cheemplavam wrote:

> Jens Axboe wrote:
>
>> On Wed, Nov 05 2003, Nick Piggin wrote:
>>
>>>
>>> Prakash K. Cheemplavam wrote:
>>>
>>>
>>>> SOmething else I noticed with new 2.6tes9-mm2 kernel: Now the mouse 
>>>> stutters slighty when burning (in atapi mode). I am now using as 
>>>> sheduler. Shoudl I try deadline or do you this it is something 
>>>> else? Should I open a new topic?
>>>>
>>>
>>> This is more likely to be the CPU scheduler or something holding
>>> interrupts for too long. Are you running anything at a modified
>>
>>
>>                  ^^^^^^^^
>>
>> precisely, that's why the actual interface that cdrecord uses is the
>> primary key to knowing what the problem is.
>
>
> As said, I'll report back later...


please do the following while burning is in progress
ps -Afl > file
and send me the file.

>
> Prakash
>
> [OT] Something about this kernel list is stupid: It always wants to 
> reply to the author instead of the list, generating double the traffic 
> if one doesn't pay attention...
>

The lkml convention is reply to all. It works well for a high volume list.


