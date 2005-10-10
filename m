Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbVJJPPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbVJJPPV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 11:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbVJJPPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 11:15:21 -0400
Received: from [66.45.247.194] ([66.45.247.194]:44754 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1750849AbVJJPPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 11:15:20 -0400
Message-ID: <434A828C.8080401@linuxtv.org>
Date: Mon, 10 Oct 2005 19:02:36 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <lnx4us@gmail.com>
CC: Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com> <43287712.3040503@gmail.com>	 <4328A3C8.6010501@linuxtv.org>	 <200510101403.02578@bilbo.math.uni-mannheim.de>	 <434A6334.4090407@linuxtv.org> <3888a5cd0510100725k579809a9o374930df9988bfa3@mail.gmail.com>
In-Reply-To: <3888a5cd0510100725k579809a9o374930df9988bfa3@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:

>On 10/10/05, Manu Abraham <manu@linuxtv.org> wrote:
>  
>
>>I have fixed most of the stuff, it is partly working, not ready yet as
>>there are some more things to be added to  ..
>>I have attached what i was working on.
>>    
>>
>One more thing.
>
>  
>
>>static int __devinit mantis_pci_init(void)
>>{
>>        return pci_register_driver(&mantis_pci_driver);
>>}
>>
>>static void __devexit mantis_pci_exit(void)
>>{
>>        pci_unregister_driver(&mantis_pci_driver);
>>}
>>    
>>
>These should be __init and __exit, which could be freed in more cases
>(only few bytes, but...).
>  
>

Ack'd..

Thanks,
Manu


