Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbVLOSek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbVLOSek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVLOSek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:34:40 -0500
Received: from smtp-out.google.com ([216.239.33.17]:36572 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750881AbVLOSej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:34:39 -0500
Message-ID: <43A1B729.5040009@mbligh.org>
Date: Thu, 15 Dec 2005 10:34:17 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benoit Boissinot <bboissin@gmail.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-rc5-mm3 (new build failure)
References: <43A1A95D.10800@mbligh.org> <40f323d00512151009h5eece648w80882f0cda078507@mail.gmail.com>
In-Reply-To: <40f323d00512151009h5eece648w80882f0cda078507@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benoit Boissinot wrote:
> On 12/15/05, Martin Bligh <mbligh@mbligh.org> wrote:
> 
>>New build failure since -mm2:
>>Config is
>>http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/elm3b67
>>
>>I'm guessing it was using gcc 2.95.4, though not sure.
>>
>>   CC      arch/i386/kernel/asm-offsets.s
>>In file included from include/linux/stddef.h:4,
>>                  from include/linux/posix_types.h:4,
>>                  from include/linux/types.h:13,
>>                  from include/linux/capability.h:16,
>>                  from include/linux/sched.h:7,
>>                  from arch/i386/kernel/asm-offsets.c:7:
>>include/linux/compiler.h:46: #error Sorry, your compiler is too old/not
>>recognized.
> 
> 
> support for gcc-2.95 was dropped in -mm3.

Pah. For any good reason? or just people being lazy?
It's worked fine for about 5 years. Difficult to beleive it's suddenly 
unworkable.

m.
