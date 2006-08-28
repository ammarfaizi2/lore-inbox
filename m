Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWH1Oln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWH1Oln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 10:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWH1Oln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 10:41:43 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:53949 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751011AbWH1Olm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 10:41:42 -0400
Message-ID: <44F300A8.2000408@watson.ibm.com>
Date: Mon, 28 Aug 2006 10:41:44 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Olaf Hering <olaf@aepfle.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc5
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>	<20060827231421.f0fc9db1.akpm@osdl.org>	<20060828061940.GA12671@aepfle.de> <20060827232437.821110f3.akpm@osdl.org>
In-Reply-To: <20060827232437.821110f3.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 28 Aug 2006 08:19:40 +0200
> Olaf Hering <olaf@aepfle.de> wrote:
> 
>> On Sun, Aug 27, Andrew Morton wrote:
>>
>>> On Sun, 27 Aug 2006 21:30:50 -0700 (PDT)
>>> Linus Torvalds <torvalds@osdl.org> wrote:
>>>
>>>> Linux 2.6.18-rc5 is out there now
>>> (Reporters Bcc'ed: please provide updates)
>>> Subject: oops in __delayacct_blkio_ticks with 2.6.18-rc4
>> This patch is supposed to fix it.
>>
>> http://lkml.org/lkml/2006/8/22/245
>> http://lkml.org/lkml/2006/8/24/299
> 
> Yes, there are two delay-accounting fixes pending - this and a memory leak. 
> Shailabh is off preparing the final versions (I hope).
> 

Both the problems are solved by the same patch.

I'll submit the same by eod. Wanted to get some more stress testing
of the fix using not just the /proc interface (which caused the oops reported)
but also the command interface provided by taskstats/delay accounting.

Thanks,
Shailabh
