Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbVHZCzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbVHZCzj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 22:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbVHZCzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 22:55:39 -0400
Received: from prato.iplannetworks.net ([200.69.193.98]:45995 "EHLO
	proxy2.iplannetworks.net") by vger.kernel.org with ESMTP
	id S1751116AbVHZCzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 22:55:38 -0400
Message-ID: <430E8345.50302@latinsourcetech.com>
Date: Thu, 25 Aug 2005 23:49:41 -0300
From: =?ISO-8859-1?Q?M=E1rcio_Oliveira?= <moliveira@latinsourcetech.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linville@tuxdriver.com, linux-kernel@vger.kernel.org
Subject: [SOLVED] Re: Re: Problem with kernel image in a Prep Boot on PowerPC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John W. Linville wrote:

>On Wed, Aug 24, 2005 at 02:52:44PM -0300, Márcio Oliveira wrote:
>
>  
>
>>The command rdev can change the default root partition on x86 linux 
>>systems with pre-built kernels.
>>    
>>
> 
>Of course...I meant I don't know of anything like that for PPC.
>
>  
>
>>About the CONFIG_CMDLINE in the kernel configuration, I found it in lots 
>>of files in the kernel source tree and I'd like to know which file I 
>>need to change this value (/usr/src/linux/arch/ppc64/defconfig ?).
>>    
>>
> 
>Probably just in your .config file:
>
>	cp arch/ppc64/defconfig .config
>	vi .config # Change CONFIG_CMDLINE here
>	make oldconfig
>
>  
>
>>According to this doc: 
>>http://www-128.ibm.com/developerworks/eserver/library/es-SW_RAID_LINUX.html, 
>>ppc64 can use zImage-style boot wrapper, so I'm trying it.
>>    
>>
>
>Cool...I think you will like having that as an option.
>
>John
>  
>
John,

 I made the changes in the kernel that you recomended and the server 
boots ok!

Thank's a lot.

Márcio Oliveira.


