Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbSLIOPS>; Mon, 9 Dec 2002 09:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbSLIOPS>; Mon, 9 Dec 2002 09:15:18 -0500
Received: from ida.xs4all.nl ([213.84.39.78]:31291 "EHLO ida.dejong.info")
	by vger.kernel.org with ESMTP id <S265532AbSLIOPQ>;
	Mon, 9 Dec 2002 09:15:16 -0500
Message-ID: <3DF4A736.9010104@dejong.info>
Date: Mon, 09 Dec 2002 15:22:46 +0100
From: jorg de jong <jorg@dejong.info>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: status of HPT374 support in 2.4.20 and 2.5.50
References: <3DF26772.8040502@dejong.info> <3DF26DF4.F1692AFA@digeo.com>	<3DF2759F.1090403@dejong.info>  <3DF27AF9.7BA0D1B5@digeo.com> <1039310973.27923.0.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sat, 2002-12-07 at 22:49, Andrew Morton wrote:
> 
>>Well, you must have a card which is newer than the driver understands.
>>That's one for the IDE guys...
> 
> 
> My guess is he has a card whose timings we don't support. In that case
> we punt to avoid crashing later or data loss. Timings for that is one
> for Andre & HPT

Well it is about timing indeed. It turned out that as a result for
a quest for speed, some time ago, I left the pci bus running as 35Mhz.

As soon as I reset it to 33Mhz the attached drive was detected and
kernel panics dissapeard. (Redhat kernel 2.4.18..., 2.4.20-ac1. )
Other I have not tested.

thanks for your help

Jorg de Jong



