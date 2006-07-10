Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965282AbWGJWai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965282AbWGJWai (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965283AbWGJWah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:30:37 -0400
Received: from lucidpixels.com ([66.45.37.187]:11500 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S965282AbWGJWag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:30:36 -0400
Date: Mon, 10 Jul 2006 18:30:35 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: Kernel 2.6.17 and RAID5 Grow Problem (critical section backup)
In-Reply-To: <Pine.LNX.4.61.0607110026030.5420@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0607101830130.2603@p34.internal.lan>
References: <Pine.LNX.4.64.0607070830450.2648@p34.internal.lan>
 <Pine.LNX.4.64.0607070845280.2648@p34.internal.lan>
 <Pine.LNX.4.64.0607070849140.3010@p34.internal.lan>
 <Pine.LNX.4.64.0607071037190.5153@p34.internal.lan> <17582.55703.209583.446356@cse.unsw.edu.au>
 <Pine.LNX.4.64.0607101747160.2603@p34.internal.lan>
 <Pine.LNX.4.61.0607110026030.5420@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Jul 2006, Jan Engelhardt wrote:

>> md3 : active raid5 sdc1[7] sde1[6] sdd1[5] hdk1[2] hdi1[4] hde1[3] hdc1[1]
>> hda1[0]
>>      2344252416 blocks super 0.91 level 5, 512k chunk, algorithm 2 [8/8]
>> [UUUUUUUU]
>>      [>....................]  reshape =  0.2% (1099280/390708736)
>> finish=1031.7min speed=6293K/sec
>>
>> It is working, thanks!
>>
> Hm, what's superblock 0.91? It is not mentioned in mdadm.8.
>
>
> Jan Engelhardt
> -- 
>

Not sure, the block version perhaps?

I am using:

$ mdadm -V
mdadm - v2.5 -  26 May 2006

Debian Etch.

Justin.
