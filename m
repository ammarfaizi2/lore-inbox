Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbUB1MN2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 07:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbUB1MN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 07:13:28 -0500
Received: from c10053.upc-c.chello.nl ([212.187.10.53]:41361 "EHLO
	smurver.fakenet") by vger.kernel.org with ESMTP id S261796AbUB1MN0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 07:13:26 -0500
Message-ID: <404085EA.2030507@vanE.nl>
Date: Sat, 28 Feb 2004 13:13:30 +0100
From: Erik van Engelen <Info@vanE.nl>
User-Agent: Mozilla Thunderbird 0.5b (Windows/20040201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Errors on 2th ide channel of promise ultra100 tx2
References: <403F2178.70806@vanE.nl> <Pine.LNX.4.58L.0402271420250.18958@logos.cnet>
In-Reply-To: <Pine.LNX.4.58L.0402271420250.18958@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the fast reaction.

Marcelo Tosatti wrote:

> I'm clueless about this, anyway...
> 
> On Fri, 27 Feb 2004, Erik van Engelen wrote:
> 
> 
>>Hi,
>>
>>I've got a Proliant 2500 running a 2.4.25 kernel. It has 2 pentium pro
>>CPUs and a smart-2/E disk array on EISA bus from which it boots.
>>
>>I added a promise ultra100 tx2 ide cart and put on 3 disks. During boot
>>i get a couple of errors but everything seems to work ok. When
>>read/write to a disk on the first ide-channel everything is ok. When i
>>read/write to a disk on the second ide-channel everything is ok. But
>>when i try to read/write to both disks at once i get these errors:
>>
>>hdh: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>>hdh: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> 
> Are you using DMA?
>
I've tried it with and without DMA. But in both cases i got errors 
although the were different. I made some changes so i can't post the 
error with the DMA turned on. I can reverse the changes on Monday and 
post the errors for you.

> 
> 
> Can you please save and post the 2.6.3 panic?
> 
I'm trying to get a serial line connection working to log the bootlogs. 
I can make them as well on Monday.

I tried to boot with the cpqarray removed from the 2.6.3 kernel. In that 
case i don't get the errors from the ide devices during the kernel boot 
so i guess the solution made in the 2.6 according the ide problem is 
working. Again on Monday i want to try the patch from Erik B. Andersen 
on the 2.4 kernel. If i understood it all right. I'm not really into 
kernel hacking etc.

THX for the help so far..
Erik van Engelen
