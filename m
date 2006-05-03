Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbWECRsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWECRsf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 13:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWECRse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 13:48:34 -0400
Received: from mail.priv.de ([80.237.225.190]:41390 "EHLO mail.priv.de")
	by vger.kernel.org with ESMTP id S1030271AbWECRse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 13:48:34 -0400
Message-ID: <4458ECF6.8060602@priv.de>
Date: Wed, 03 May 2006 19:48:38 +0200
From: =?ISO-8859-1?Q?Markus_M=FCller?= <mm@priv.de>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Andreas Steinmetz <ast@domdv.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reiserfsck dies
References: <4458C48B.8040703@priv.de> <Pine.LNX.4.61.0605031842260.13546@yvahk01.tjqt.qr> <4458E619.8090501@priv.de> <4458E8C4.3060902@domdv.de>
In-Reply-To: <4458E8C4.3060902@domdv.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas Steinmetz,
> Markus Müller wrote:
>   
>> no, the hdd is a software raid 5, /dev/md0, which is piped through aes
>> via cryptsetup, so it is accessed via /dev/mapper/hdb
>>     
>
> My experience with such a stacking and reiserfs was horrible. Continous
> filesystem corruption that finally required reformatting. I then
> replaced reiserfs with ext3 and the stacking works since then.
>
> It is not a dm-crypt problem as the symptoms also occurred with
> raid5/lvm2/reiserfs, so any raidx/dm/reiserfs stacking seems to be only
> something for the more adventurous folks. Thus I don't know if the
> problem still exists with current kernels.
>   
Ok, maybe. I try now to insert 512 MB more RAM into the machine, more 
than 1 Gig I don't have for this system. I only want the raid to work 
just one time, cause there is data I want to (but not in any case) be 
secured. Then I again install ext3 on it... this worked on this raid 
without any problems at all. And the fsck is about 2 houres, not 28 
hours (--rebuild-tree).

I don't think my kernel is to old, do you?

stacker:/# uname -a
Linux stacker.websrv.de 2.6.16.9 #2 SMP PREEMPT Sun Apr 30 09:44:06 CEST 
2006 i686 GNU/Linux
stacker:/#

Regards,
Markus Mueller

