Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbSLGWTM>; Sat, 7 Dec 2002 17:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbSLGWTM>; Sat, 7 Dec 2002 17:19:12 -0500
Received: from ida.xs4all.nl ([213.84.39.78]:27441 "EHLO ida.dejong.info")
	by vger.kernel.org with ESMTP id <S264838AbSLGWTM>;
	Sat, 7 Dec 2002 17:19:12 -0500
Message-ID: <3DF2759F.1090403@dejong.info>
Date: Sat, 07 Dec 2002 23:26:39 +0100
From: Jorg de Jong <jorg@dejong.info>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en, nl
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: status of HPT374 support in 2.4.20 and 2.5.50
References: <3DF26772.8040502@dejong.info> <3DF26DF4.F1692AFA@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> jorg de jong wrote:
> 
>>Hi,
>>
>>I just bought a Highpoint Rocketraid 404 controler. To my suppirce I
>>found that
>>the kernel I was using does not like it one bit. The kernel entered a
>>kernel panic/BUG
>>in file hpt666.c:1031. The kernel was a Redhat stock kernel
>>2.4.18-18.8.0smp.
>>
>>Not afraid to build my own kernel I tried:
>>- 2.4.20; which also stoped with a kernel panic.
>>- 2.4.20-ac1; this kernel boots just fine. It even sees the controller
>>but does not detect
>>the drive.
>>- 2.5.46; sees the controler but no drive
>>- 2.5.50; sees the controler but no drive
>>
> 
> 
> This patch (against 2.4.20) is the one I use when I need to
> use the hpt374 in 2.4 kernels.
> 
> 
>
Hi Andrew,

Thanks for your reply. I tried the patch but it gives a kernel panic
at file hpt366.c:1344 :-(.

Jorg.

