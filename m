Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264969AbTK3R22 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 12:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbTK3R21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 12:28:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38578 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264969AbTK3RZp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 12:25:45 -0500
Message-ID: <3FCA280A.40805@pobox.com>
Date: Sun, 30 Nov 2003 12:25:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
CC: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: FYI: My current suspend bigdiff
References: <20031128171323.GG303@elf.ucw.cz> <3FC7860C.2060505@gmx.de> <20031128173312.GH303@elf.ucw.cz> <3FC789F5.2000208@gmx.de> <20031128175503.GB18072@elf.ucw.cz> <3FC7908A.9030007@gmx.de> <20031128235623.GB18147@elf.ucw.cz> <3FC8C0DB.9050107@gmx.de> <20031129172537.GB459@elf.ucw.cz> <3FC9C560.2070902@gmx.de> <20031130171833.GB516@elf.ucw.cz> <3FCA2742.8070107@gmx.de>
In-Reply-To: <3FCA2742.8070107@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> Pavel Machek wrote:
> 
>> Hi!
>>
>>
>>>> Well... it could work with scsi. You can try it, but be carefull. [If
>>>> it goes wrong it might eat your data.]
>>>
>>>
>>> Thats why I use xfs on my main system to test... And I tried with 
>>> libata and it won't work as it complains that the "katad" process 
>>> cannot be stopped, so swsusp immediatly comes back.
>>
>>
>>
>> I do not know how much more support is needed to allow powermanagment
>> for libata, but this one should be easy...
> 
> 
> Uhm, Jeff already fixed it in libata using the same call. Can both fixes 
> "hurt" each other or are the safe?


As you suspect, you want only one of the fixes.

I would probably prefer Pavel's patch over mine, as he knows the suspend 
subsystem better than me :)

	Jeff



