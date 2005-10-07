Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030499AbVJGQg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030499AbVJGQg2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 12:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030502AbVJGQg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 12:36:28 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:24119 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1030499AbVJGQg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 12:36:27 -0400
Date: Fri, 07 Oct 2005 11:36:46 -0500
From: Wes Newell <w.newell@verizon.net>
Subject: Re: [PATCH 2.6.14-rc3] sis5513.c: enable ATA133 for the SiS965
 southbridge
In-reply-to: <20051007094135.GA16386@farad.aurel32.net>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Lionel.Bouton@inet6.fr,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Message-id: <4346A41E.3020505@verizon.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <20051005205906.GA4320@farad.aurel32.net>
 <58cb370e0510060240x2f2e31c3kd0609a06172d86a4@mail.gmail.com>
 <20051007094135.GA16386@farad.aurel32.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aurelien Jarno wrote:

>On Thu, Oct 06, 2005 at 11:40:15AM +0200, Bartlomiej Zolnierkiewicz wrote:
>  
>
>>Hi,
>>
>>On 10/5/05, Aurelien Jarno <aurelien@aurel32.net> wrote:
>>    
>>
>>>Hi,
>>>
>>>Here is a patch that enables the ATA133 mode for the SiS965 southbridge
>>>in the SiS5513 driver.
>>>      
>>>
>>The patch for SIS965(L) support is already in -mm tree:
>>http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm2/broken-out/sis5513-support-sis-965l.patch
>>
>>    
>>
>
>Oops, I forget to look at the -mm tree for this driver. You're right, it
>works, and it seems the patch is cleaner than mine. So please ignore my
>patch.
>
>Thanks,
>Aurelien
>
>  
>
It appears to me that this patch will try and apply itself to the real 
SIS_180 which has the same true_id of 0x180. Can someone tell me what 
will happen then?


-- 
KT133 MB, CPU @2400MHz (24x100): SIS755 MB CPU @2330MHz (10x233)
Need good help? Provide all system info with question.
My server http://wesnewell.no-ip.com/cpu.php
Verizon server http://mysite.verizon.net/res0exft/cpu.htm

