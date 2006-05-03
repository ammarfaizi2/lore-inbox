Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWECRwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWECRwR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 13:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWECRwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 13:52:17 -0400
Received: from hermes.domdv.de ([193.102.202.1]:57614 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S1750741AbWECRwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 13:52:16 -0400
Message-ID: <4458EDCF.4030402@domdv.de>
Date: Wed, 03 May 2006 19:52:15 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Markus_M=FCller?= <mm@priv.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reiserfsck dies
References: <4458C48B.8040703@priv.de> <Pine.LNX.4.61.0605031842260.13546@yvahk01.tjqt.qr> <4458E619.8090501@priv.de> <4458E8C4.3060902@domdv.de> <4458ECE0.7030901@priv.de>
In-Reply-To: <4458ECE0.7030901@priv.de>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Müller wrote:
>  Hi Andreas Steinmetz,
> 
>>Markus Müller wrote:
>>  
>>
>>>no, the hdd is a software raid 5, /dev/md0, which is piped through aes
>>>via cryptsetup, so it is accessed via /dev/mapper/hdb
>>>    
>>>
>>My experience with such a stacking and reiserfs was horrible. Continous
>>filesystem corruption that finally required reformatting. I then
>>replaced reiserfs with ext3 and the stacking works since then.
>>
>>It is not a dm-crypt problem as the symptoms also occurred with
>>raid5/lvm2/reiserfs, so any raidx/dm/reiserfs stacking seems to be only
>>something for the more adventurous folks. Thus I don't know if the
>>problem still exists with current kernels.
>>  
>>
> Ok, maybe. I try now to insert 512 MB more RAM into the machine, more
> than 1 Gig I don't have for this system. I only want the raid to work
> just one time, cause there is data I want to (but not in any case) be
> secured. Then I again install ext3 on it... this worked on this raid
> without any problems at all. And the fsck is about 2 houres, not 28
> hours (--rebuild-tree).
> 
> I don't think my kernel is to old, do you?

So it seems the problem still exists (lucky me had lots of backup tapes
plus firewire disk backups). I only remember that finally the fs was to
foobar for reiserfsck to recover in my case.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
