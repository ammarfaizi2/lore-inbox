Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313165AbSDDNn1>; Thu, 4 Apr 2002 08:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313167AbSDDNnQ>; Thu, 4 Apr 2002 08:43:16 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:11934 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S313165AbSDDNnL>; Thu, 4 Apr 2002 08:43:11 -0500
Message-ID: <3CAC57B0.5090902@oracle.com>
Date: Thu, 04 Apr 2002 15:40:00 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020326
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stelian Pop <stelian.pop@fr.alcove.com>
CC: "Adam J. Richter" <adam@yggdrasil.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() at
 boot time
In-Reply-To: <20020404035910.A281@baldur.yggdrasil.com> <20020404125614.GE9820@come.alcove-fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:
> On Thu, Apr 04, 2002 at 03:59:10AM -0800, Adam J. Richter wrote:
> 
> 
>>	When I attempted to boot linux-2.5.8-pre1, I got a kernel
>>BUG() for exit.c line 519.  The was a small change to to kernel/exit.c
>>in 2.5.8-pre1 which deleted a kernel_lock() call.  Restoring that line
>>resulted in a kernel that booted fine.  I am sending this email from
>>the machine running that kernel (so I guess a matching release of
>>the kernel lock is already in the code).
> 
> 
> It should be added that the bug is hit only if CONFIG_PREEMPT is on.

Just to say that

  * I hit the bug
  * I have CONFIG_PREEMPT
  * Adam's fix "works for me (TM)"

--alessandro

  "time is never time at all / you can never ever leave
    without leaving a piece of youth"
                    (Smashing Pumpkins, "Tonight, tonight")

