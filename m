Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbSKRKpM>; Mon, 18 Nov 2002 05:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262214AbSKRKpM>; Mon, 18 Nov 2002 05:45:12 -0500
Received: from hermes.domdv.de ([193.102.202.1]:7684 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S262210AbSKRKpJ>;
	Mon, 18 Nov 2002 05:45:09 -0500
Message-ID: <3DD8C702.4090505@domdv.de>
Date: Mon, 18 Nov 2002 11:54:58 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vergoz Michael <mvergoz@sysdoor.com>
CC: Michael Knigge <Michael.Knigge@set-software.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.xx: 8139 isn't working
References: <20021118.10200352@knigge.local.net> <00e701c28ee5$16c501e0$76405b51@romain> <20021118.11265925@knigge.local.net> <015f01c28eed$f112ce10$76405b51@romain> <20021118.11392845@knigge.local.net> <019401c28eef$492bcb50$76405b51@romain>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You may want to check if you have IO-APIC enabled in your kernel. Try to 
boot with "noapic" and see if this helps. I do have a SiS based test 
system with an on board RTL8139 around that doesn't behave with IO-APIC 
enabled...

Vergoz Michael wrote:
> hmmm
> 
> life is strange.....
> 
> i'v the same card as u and it work for me !
> 
> Michael-
> 
> Sent: Monday, November 18, 2002 12:39 PM
> Subject: Re: 2.4.xx: 8139 isn't working
> 
> 
> 
>>>are u sure that you do :
>>>cat 8139too.c | patch -p0
>>
>>Yes I am ;-)  I've compiled the module under 2.2.20, installed it, 
>>rebootet 2.4.19 and.... same results as with the vanilla driver...
>>
>>
>>bye
>>  Michael
>>
>>
>>
>>
>>
>>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

