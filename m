Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbVK1P4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbVK1P4M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 10:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVK1P4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 10:56:12 -0500
Received: from kirby.webscope.com ([204.141.84.57]:3814 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1751270AbVK1P4L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 10:56:11 -0500
Message-ID: <438B287D.9030607@linuxtv.org>
Date: Mon, 28 Nov 2005 10:55:41 -0500
From: Mike Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: saa7134 broken in 2.6.15-rc2
References: <20051128135254.GA4218@wonderland.linux.it> <20051128141003.GA4806@wonderland.linux.it> <438B1F89.7000402@linuxtv.org> <200511281035.18541.gene.heskett@verizon.net>
In-Reply-To: <200511281035.18541.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>On Monday 28 November 2005 10:17, Mike Krufky wrote:
>  
>
>>Marco d'Itri wrote:
>>    
>>
>>>On Nov 28, Duncan Sands <duncan.sands@math.u-psud.fr> wrote:
>>>      
>>>
>>>>here seems to be something rotten in v4l land; here's one I got with
>>>>2.6.15-rc1-git1
>>>>        
>>>>
>>>Yes, I should have STFW better:
>>>http://lkml.org/lkml/fancy/2005/11/24/194 .
>>>
>>>video-buf is still broken for me in -rc2, I can make xawtv work if I
>>>set capture to "overlay", but it still complain about no input
>>>sources other than "default".
>>>      
>>>
>>Please try again, using the current -git snapshot.... The memory
>>problems have been fixed by Hugh Dickins in 2.6.15-rc2-git3 , and
>>Dmitry has submitted some input fixes after that.....
>>
>>I am running 2.6.15-rc2-git6 with no problems.
>>
>>    
>>
>Whats the patch sequence to arrive at rc2-git6 please?
>

Umm... If I am understanding your question correctly:

Start with 2.6.14
    http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.14.tar.bz2

Apply 2.6.15-rc2
    http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.15-rc2.bz2

Apply 2.6.14-rc2-git6
    
http://kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.15-rc2-git6.bz2

Is this what you're asking???

Hope this helps,

Michael Krufky


