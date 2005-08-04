Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVHDGXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVHDGXJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 02:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVHDGXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 02:23:09 -0400
Received: from steakhouse.mbo.de ([213.20.229.118]:7371 "EHLO
	steakhouse.mbo.de") by vger.kernel.org with ESMTP id S261850AbVHDGXH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 02:23:07 -0400
Message-ID: <42F1B44A.9030203@mbo.de>
Date: Thu, 04 Aug 2005 08:23:06 +0200
From: Daniel Walter <walter@mbo.de>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: ReiserFS crashing
References: <42F0ADEE.7020405@mbo.de> <Pine.LNX.4.61.0508040808000.22272@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0508040808000.22272@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0125], KAS/Release
X-Spamtest-Info: Pass through
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt schrieb:

>>Acessing the (software-)raid1 results in crash of shell
>>raid worked ok for some days before
>>error message appeared upon first hangup:
>>
>>
>>Linux version 2.6.11.10BERNHADINERMBO.DE (root@shepard) (gcc version 3.3.4) #3
>>Fri Jul 15 11:53:00 CEST 2005
>>
>>
>>ReiserFS: warning: is_leaf: item location seems wrong (second one): *3.6* [2
>>2690 0x0 SD], item_len 492, item_location 3836, free_space(entry_count) 65535
>>ReiserFS: md0: warning: vs-5150: search_by_key: invalid format found in block
>>720896. Fsck?
>>    
>>
>
>Try do a reiserfsck. If it's gone then, it should be ok.
>
>
>
>
>  
>
Thank you very much for your replies. What was making me think it's 
probably a bug was this line:

 > kernel BUG at fs/reiserfs/journal.c:494!

Drive is accessible again - I just wanted to be sure this isn't a bug in 
ReiserFS.

