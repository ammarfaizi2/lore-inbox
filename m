Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVBTRTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVBTRTa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 12:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVBTRTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 12:19:30 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:41648 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261896AbVBTRTY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 12:19:24 -0500
Message-ID: <4218C692.9040106@tiscali.de>
Date: Sun, 20 Feb 2005 18:19:14 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11rc4: irq 5, nobody cared
References: <20050220155600.GD5049@vanheusden.com> <20050220164010.GA17806@ime.usp.br>
In-Reply-To: <20050220164010.GA17806@ime.usp.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogério Brito wrote:

>On Feb 20 2005, Folkert van Heusden wrote:
>  
>
>>My linux laptop says:
>>irq 5: nobody cared!
>>    
>>
>(...)
>  
>
>>Does anyone care? :-)
>>    
>>
>
>Well, I'm getting similar stack traces with my system and those are sure
>scary, but it seems that my e-mails to the list are simply ignored,
>unfortunately.
>
>I am willing to test any patch and configuration (let's call me a "guinea
>pig"), but I don't know what I should do. I have, OTOH, reported my problem
>many times in the past few days. :-(
>
>I will retry sending my message to the list once again, with the details
>(in my case, the message I get is "irq 10: nobody cared!" and it is
>regarding my primary HD on my secondary Promise PDC20265 controller).
>
>
>Thanks for any help, Rogério.
>
>P.S.: I have already bought an 80-pin cable just for this drive in the hope
>that the message would go away, but it didn't.
>  
>
Report it to http://bugzilla.kernel.org/. Maybe you'll get help there. 
But "bugs" are _very_ hardware specific, so just a few people will have 
a similar problem and most of this people are just "normal" users -- not 
Linux Kernel developers. The developer (people who are familiar with the 
kernel code and who are maybe able to fix this problem) aren't able to 
reproduce this error and test code to get it working. So they're maybe 
(without knowing anything about the hardware (maybe it's broken 
hardware?)) not able to say something specific about the hardware -- 
they can just guess.
You see it's very difficult to fix such irq problems because some 
factors can cause such an error.
Maybe contacting specific malinglists (e.g. for "broken" pci cards the 
pci mailinglist, etc.), maintainers or developers would be more 
efficient (cc the lkml) and solve your problem (faster), because this 
people are specialists are this type of hardware (e.g. pci).

What hardware is connect through irq 5?

Matthias-Christian Ott
