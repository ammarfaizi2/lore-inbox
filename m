Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263199AbVGAElo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbVGAElo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 00:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbVGAElo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 00:41:44 -0400
Received: from [218.94.38.154] ([218.94.38.154]:13974 "EHLO xianan.com.cn")
	by vger.kernel.org with ESMTP id S263199AbVGAElg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 00:41:36 -0400
X-AuthUser: chengq@xianan.com.cn
Message-ID: <42C4C964.2090200@gmail.com>
Date: Fri, 01 Jul 2005 12:41:08 +0800
From: Benbenshi <benbenshi@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>, linux-kernel@vger.kernel.org
Subject: Re: route reload after interface restart
References: <dc849d8505063004136573e59e@mail.gmail.com>	 <200506301418.04419.vda@ilport.com.ua> <dc849d850506300711a92042@mail.gmail.com> <42C492A8.3020702@trash.net> <42C49511.3060307@gmail.com> <42C498ED.4050400@trash.net>
In-Reply-To: <42C498ED.4050400@trash.net>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy wrote:

>Benbenshi wrote:
>  
>
>>you mean i have to specify the netmask when i startup the device ?
>>    
>>
>
>Yes.
>
>  
>
i have done an experiment as follow:

1. default route was add to eth0
2.ifconfig eth0 down
3.ifconfig eth0 192.168.10.57 netmask 255.255.255.0 up

no default route was re-added to kernel, failed!

>>can you tell more details ?
>>    
>>
>
>Just try yourself.
>
>  
>

