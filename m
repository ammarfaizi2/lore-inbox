Return-Path: <linux-kernel-owner+w=401wt.eu-S1422786AbXAMUzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422786AbXAMUzv (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 15:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422794AbXAMUzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 15:55:51 -0500
Received: from squeaker.ratbox.org ([66.212.148.233]:59620 "EHLO
	squeaker.ratbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422786AbXAMUzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 15:55:50 -0500
Date: Sat, 13 Jan 2007 15:55:47 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Damien Wyart <damien.wyart@free.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jon Smirl <jonsmirl@gmail.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.20-rc5: known unfixed regressions
In-Reply-To: <20070113155956.GP7469@stusta.de>
Message-ID: <Pine.LNX.4.64.0701131555220.19856@squeaker.ratbox.org>
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
 <20070113071125.GG7469@stusta.de> <87bql2ylfb.fsf@brouette.noos.fr>
 <20070113155956.GP7469@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 13 Jan 2007, Adrian Bunk wrote:

> On Sat, Jan 13, 2007 at 04:51:36PM +0100, Damien Wyart wrote:
>> * Adrian Bunk <bunk@stusta.de> [070113 08:11]:
>>> This still leaves the old regressions we have not yet fixed...
>>> This email lists some known regressions in 2.6.20-rc5 compared to 2.6.19.
>>
>>> Subject    : BUG: scheduling while atomic: hald-addon-stor/...
>>>              cdrom_{open,release,ioctl} in trace
>>> References : http://lkml.org/lkml/2006/12/26/105
>>>              http://lkml.org/lkml/2006/12/29/22
>>>              http://lkml.org/lkml/2006/12/31/133
>>> Submitter  : Jon Smirl <jonsmirl@gmail.com>
>>>              Damien Wyart <damien.wyart@free.fr>
>>>              Aaron Sethman <androsyn@ratbox.org>
>>> Status     : unknown
>>
>> I have not seen the problem since using rc3, so I guess it is ok now.
>> Maybe the commit 9414232fa0cc28e2f51b8c76d260f2748f7953fc has fixed the
>> problem, but I am not 100% sure.
>
> Thanks for this information.
>
> Jon, Aaron, can you confirm it's fixed in -rc5?

I haven't seen it in a while anyways, fwiw.

-Aaron
