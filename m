Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbTI3M0t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 08:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbTI3M0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 08:26:49 -0400
Received: from dyn-ctb-210-9-243-176.webone.com.au ([210.9.243.176]:17937 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261397AbTI3M0r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:26:47 -0400
Message-ID: <3F797646.1070303@cyberone.com.au>
Date: Tue, 30 Sep 2003 22:25:42 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Steinmetz <ast@domdv.de>
CC: Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
References: <200309301144.h8UBiUUF004315@burner.fokus.fraunhofer.de> <20030930115411.GL2908@suse.de> <3F797316.2010401@domdv.de>
In-Reply-To: <3F797316.2010401@domdv.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andreas Steinmetz wrote:

> Jens Axboe wrote:
>
>>
>> I think I do.
>>
>>
>>> In order to use kernel interfaces you _need_ to include kernel include
>>> files.
>>
>>
>>
>> False. You need to include the glibc kernel headers.
>>
> Then please tell me why PPPIOCNEWUNIT is only defined in 
> linux/if_ppp.h and not net/if_ppp.h which is still true for 
> glibc-2.3.2. And please don't tell me to ask the glibc folks. There 
> are inconsistencies between kernel headers and userland headers which 
> force the inclusion of kernel headers in userland applications.
>

A problem was raised and Jens answered it. The simple fact is that right
now linux kernel include files are often not suitable to include in user
space.

You are free to do what you like. You can just stick a ifndef / define
at the top of your program to fix it up nicely, or wait for glibc to
include it, or try to include you kernel headers. Please don't be
hostile toward people who are answering questions.

FWIW I think some people are looking at this for 2.7


