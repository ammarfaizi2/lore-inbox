Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWECSSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWECSSp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 14:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWECSSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 14:18:44 -0400
Received: from mail.priv.de ([80.237.225.190]:42926 "EHLO mail.priv.de")
	by vger.kernel.org with ESMTP id S1751254AbWECSSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 14:18:44 -0400
Message-ID: <4458F407.9050101@priv.de>
Date: Wed, 03 May 2006 20:18:47 +0200
From: =?ISO-8859-15?Q?Markus_M=FCller?= <mm@priv.de>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Reiserfsck dies
References: <4458C48B.8040703@priv.de> <20060503215635.4b3a28bf.vsu@altlinux.ru>
In-Reply-To: <20060503215635.4b3a28bf.vsu@altlinux.ru>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey Vlasov,
>> stacker:/# cat /proc/meminfo
>> MemTotal:       512716 kB
>> MemFree:        413660 kB
>> Buffers:         20268 kB
>> Cached:          47324 kB
>> SwapCached:          0 kB
>> Active:          19500 kB
>> Inactive:        56656 kB
>> HighTotal:           0 kB
>> HighFree:            0 kB
>> LowTotal:       512716 kB
>> LowFree:        413660 kB
>> SwapTotal:           0 kB
>> SwapFree:            0 kB
>>     
>
> ... and you have only 512 MB with no swap.  Try to add some swap space -
> then reiserfsck might eventually complete.
>
> AFAIK, the only way to recover reiserfs after --rebuild-tree has been
> attempted is to run "reiserfsck --rebuild-tree" to completion.
>   
ok, you say that you think/know it is normal that reiserfsck needs more
than 512 MB ram... I just thought this is a bug. :-)

So I try with 1 GB real ram and another 1 GB of swap. You're sure
everything is normal, and we don't have a problem at all?

Regards,
Markus Mueller

