Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266868AbTCCQgF>; Mon, 3 Mar 2003 11:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbTCCQgF>; Mon, 3 Mar 2003 11:36:05 -0500
Received: from 195-219-31-160.sp-static.linix.net ([195.219.31.160]:51841 "EHLO
	r2d2.office") by vger.kernel.org with ESMTP id <S266868AbTCCQfs>;
	Mon, 3 Mar 2003 11:35:48 -0500
Message-ID: <3E6386B6.80301@walrond.org>
Date: Mon, 03 Mar 2003 16:45:42 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jordan.breeding@attbi.com, linux-kernel@vger.kernel.org,
       adam@yggdrasil.com
Subject: Re: Patch: 2.5.62.4 small devfs
References: <200303031638.h23GcH131618@gaea.projecticarus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm

I'm already using the existance of .devfsd to see if devfs was mounted 
by the kernel at boot. This suggests I need a new test for small devfs?

Andrew

jordan.breeding@attbi.com wrote:
> if [ -f /dev/.devfsd ]; then
>   you know you have old devfs
> fi
> 
> Jordan (I am fairly certain that it is /dev/.devfsd, you can always do ls -
> al /dev/.* to find the real name)
> 
>>Hi Adam
>>
>>Could you suggest a simple bit of sh script that will tell me if I have 
>>a devfs or small devfs kernel, (so my init scripts can decide whether or 
>>not to load devfsd?)
>>
>>Andrew Walrond
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


