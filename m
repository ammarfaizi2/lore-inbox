Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264867AbSKVOAB>; Fri, 22 Nov 2002 09:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264872AbSKVOAB>; Fri, 22 Nov 2002 09:00:01 -0500
Received: from mail.gmx.de ([213.165.64.20]:47927 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S264867AbSKVOAB>;
	Fri, 22 Nov 2002 09:00:01 -0500
Message-Id: <5.1.1.6.2.20021122145546.00c236e8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Fri, 22 Nov 2002 15:04:04 +0100
To: jim.houston@attbi.com, linux-kernel@vger.kernel.org
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.47 scheduler problems?
Cc: riel@conectiva.com.br
In-Reply-To: <5.1.1.6.2.20021122134045.00cc9680@pop.gmx.net>
References: <5.1.1.6.2.20021122120405.00c236e8@pop.gmx.net>
 <3DDDC37F.5AC219D5@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:51 PM 11/22/2002 +0100, Mike Galbraith wrote:
>At 12:07 PM 11/22/2002 +0100, Mike Galbraith wrote:
>>At 12:41 AM 11/22/2002 -0500, Jim Houston wrote:
>>
>>>I just gave this a spin with.  The patches still apply cleanly
>>>to linux-2.5.48 and it seems well behaved:-)
>>
>>It seems a little choppy still for a not swapping load, but greatly improved.
>>
>>Thanks!
>
>(I put it into virgin 2.5.47 fwiw)   I have some very odd behavior.  I 
>wanted to see how the kernel did at make -j30 bzImage on my test box to 
>see what effect it has on throughput (box is 500 Mhz PIII + 128Mb ram), 
>and get vmstat output like the attached.  I should be roughly 30Mb into 
>swap and paging heftily at this point.

Never mind the vmstat output.. it seems you need both patches.  With both 
in 2.5.48, the build progressed in a much more normal looking fashion.  I'm 
not losing control of my box any more under load.

         -Mike  

