Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVHAAwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVHAAwF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 20:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVHAAwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 20:52:00 -0400
Received: from delta.securenet-server.net ([72.9.248.26]:37322 "EHLO
	delta.securenet-server.net") by vger.kernel.org with ESMTP
	id S262305AbVHAAvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 20:51:15 -0400
Message-ID: <42ED71FB.2070009@machinehasnoagenda.com>
Date: Mon, 01 Aug 2005 10:51:07 +1000
From: "Shayne O'Connor" <forums@machinehasnoagenda.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: realtime-preempt-2.6.13-rc4-RT-V0.7.52-07
References: <42ED4E53.2010508@machinehasnoagenda.com> <1122850274.29050.0.camel@c-67-188-6-232.hsd1.ca.comcast.net>
In-Reply-To: <1122850274.29050.0.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PopBeforeSMTPSenders: forums@machinehasnoagenda.com,machine@machinehasnoagenda.com,shunichi@machinehasnoagenda.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - delta.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - machinehasnoagenda.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> You can resolve it if you enable SMP .
> 
> Daniel
> 



thanx - that's done it.


shayne






> On Mon, 2005-08-01 at 08:18 +1000, Shayne O'Connor wrote:
> 
>>trying to compile 2.6.13.rc4 with ingo's RT patch 
>>(realtime-preempt-2.6.13-rc4-RT-V0.7.52-07) but keep getting this error 
>>near the end of compilation:
>>
>>   GEN     .version
>>   CHK     include/linux/compile.h
>>   UPD     include/linux/compile.h
>>   CC      init/version.o
>>   LD      init/built-in.o
>>   LD      .tmp_vmlinux1
>>net/built-in.o(.text+0x2220c): In function `rt_check_expire':
>>: undefined reference to `__bad_spinlock_type'
>>net/built-in.o(.text+0x2222e): In function `rt_check_expire':
>>: undefined reference to `__bad_spinlock_type'
>>net/built-in.o(.text+0x22321): In function `rt_run_flush':
>>: undefined reference to `__bad_spinlock_type'
>>net/built-in.o(.text+0x22339): In function `rt_run_flush':
>>: undefined reference to `__bad_spinlock_type'
>>net/built-in.o(.text+0x22593): In function `rt_garbage_collect':
>>: undefined reference to `__bad_spinlock_type'
>>net/built-in.o(.text+0x225c1): more undefined references to 
>>`__bad_spinlock_type' follow
>>make: *** [.tmp_vmlinux1] Error 1
>>[mrmachine@localhost linux-2.6.12]$
>>
>>
>>i am trying to compile it with PREEMPT_DESKTOP ....
>>
>>
>>(please CC me on any replies!)
>>
>>
>>shayne
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
> 
> 

