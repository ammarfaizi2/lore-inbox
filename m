Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVHBITN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVHBITN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 04:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVHBITM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 04:19:12 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:36856 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261430AbVHBISj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 04:18:39 -0400
Message-ID: <42EF2C56.1040304@gmx.net>
Date: Tue, 02 Aug 2005 10:18:30 +0200
From: Otto Meier <gf435@gmx.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Jeff Garzik <jgarzik@pobox.com>, Daniel Drake <dsd@gentoo.org>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Driver for sata adapter promise sata300 tx4
References: <42EDE918.9040807@gmx.net> <42EE3501.7010107@gentoo.org> <42EE3FB8.10008@gmx.net> <42EE4ADF.4080502@gentoo.org> <20050801201756.GQ22569@suse.de> <42EE866B.5030005@pobox.com> <20050801203540.GT22569@suse.de>
In-Reply-To: <20050801203540.GT22569@suse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:a9159ed0296f17902404cf1c2ac7671c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Aug 01 2005, Jeff Garzik wrote:
>   
>> Jens Axboe wrote:
>>     
>>> On Mon, Aug 01 2005, Daniel Drake wrote:
>>>
>>>       
>>>> Otto Meier wrote:
>>>>
>>>>         
>>>>> My question is also are these features (NCQ/TCQ) and the heigher 
>>>>> datarate be supported by this
>>>>> modification? or is only the basic feature set of sata 150 TX4 supported?
>>>>>           
>>>> NCQ support is under development. Search the archives for Jens Axboe's 
>>>> recent patches to support this. I don't know about TCQ.
>>>>         
>>> It's done for ahci, because we have documentation. I have no intention
>>> on working on NCQ for chipset where full documentation is not available.
>>> But the bulk of the code is the libata core support, adding NCQ support
>>> to a sata_* driver should now be fairly trivial (with docs).
>>>       
>> I have docs for the Promise NCQ stuff.  Once NCQ is fully fleshed out (I 
>> haven't wrapped my brain around it in a couple weeks), it shouldn't be 
>> difficult to add NCQ support to sata_promise.
>>     
>
> Excellent!
>
>   
Sounds great. If you have implemented NCQ  for sata_promise it would be 
nice if you
could forward me the patch, because i'm not  subscribed to the ML's

best regards
Otto Meier
