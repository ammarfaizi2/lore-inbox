Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVD3VhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVD3VhU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 17:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVD3VhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 17:37:20 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:26323 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261437AbVD3VhN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 17:37:13 -0400
Message-ID: <4273FA88.1060405@free.fr>
Date: Sat, 30 Apr 2005 23:37:12 +0200
From: Boris Fersing <mastermac@free.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050430)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: HyperThreading, kernel 2.6.10, 1 logical CPU idle !!
References: <3Z3u8-28Z-9@gated-at.bofh.it> <4273E2BB.9010509@shaw.ca>
In-Reply-To: <4273E2BB.9010509@shaw.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock a écrit :

> Boris Fersing wrote:
>
>> Hi there,
>> I've a p4 HT 3,06Ghz, I've HT enabled in the BIOS and in the kernel :
>>
>> Linux electron 2.6.10-cj5 #6 SMP Fri Mar 4 02:18:08 CET 2005 i686 Mobile
>> Intel(R) Pentium(R) 4     CPU 3.06GHz GenuineIntel GNU/Linux .
>>
>> But it seems that one of my cpus is idle (gkrellm monitor or top) :
>>
>> Cpu0  : 88.0% us, 12.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,
>> 0.0% si
>> Cpu1  :  0.0% us,  0.3% sy,  0.0% ni, 99.7% id,  0.0% wa,  0.0% hi,
>> 0.0% si
>>
>>
>> I'm actually compiling thunderbird with MAKEOPTS="-j3", so , the second
>> should be used, shouldn't it ?
>
>
> Are you sure that it is actually compiling multiple files at once?
>
Yes I'm sure, Even if I launch more than 1 gcc, or for example, start a
compilation + video encoding (mencoder) + ... the second CPU won't work
(idle 100% or sometimes 99,9%).

Regards,

Boris.
