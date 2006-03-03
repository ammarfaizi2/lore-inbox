Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752095AbWCCAe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbWCCAe2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 19:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752096AbWCCAe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 19:34:28 -0500
Received: from rtr.ca ([64.26.128.89]:63407 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1752094AbWCCAe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 19:34:27 -0500
Message-ID: <44078F11.1010904@rtr.ca>
Date: Thu, 02 Mar 2006 19:34:25 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <lkml@rtr.ca>, "Eric D. Mudama" <edmudama@gmail.com>,
       Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>,
       Nicolas Mailhot <nicolas.mailhot@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
References: <1141239617.23202.5.camel@rousalka.dyndns.org>	 <4405F471.8000602@rtr.ca>	 <1141254762.11543.10.camel@rousalka.dyndns.org>	 <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>	 <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com>	 <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>	 <44065C7C.6090509@pobox.com> <311601c90603011900q7fe21fbx1020e4ba4062dc24@mail.gmail.com> <44066132.4010205@pobox.com> <44066378.1080408@rtr.ca> <44066400.6070503@pobox.com>
In-Reply-To: <44066400.6070503@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Mark Lord wrote:
>> Jeff Garzik wrote:
>> ..
>>
>>> Sounds like un-blacklisting the drive, and adding ATA_FLAG_NO_FUA is 
>>> the way to go...
>>
>>
>> Might as well add sata_mv to that blacklist as well.
> 
> Have you confirmed that it doesn't work with FUA?

Ooops.  Defective memory here.

The Marvell documentation for the 6081/6041 does indeed state
that the FUA DMA commands *are* supported (queued or non-queued).

So it should be okay, at least for those two specific chips.
