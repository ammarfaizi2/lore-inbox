Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVG0PcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVG0PcU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 11:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVG0PcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:32:19 -0400
Received: from pop-scotia.atl.sa.earthlink.net ([207.69.195.65]:60551 "EHLO
	pop-scotia.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S262388AbVG0Pbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:31:37 -0400
Message-ID: <42E7A8D8.1030809@earthlink.net>
Date: Wed, 27 Jul 2005 11:31:36 -0400
From: Stephen Clark <stephen.clark@earthlink.net>
Reply-To: sclark46@earthlink.net
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12 sound problem
References: <42E6C8DB.4090608@earthlink.net> <s5hr7dklko4.wl%tiwai@suse.de>
In-Reply-To: <s5hr7dklko4.wl%tiwai@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:

>At Tue, 26 Jul 2005 19:35:55 -0400,
>Stephen Clark wrote:
>  
>
>>Hello List,
>>
>>
>>I recently upgraded my laptop, HP Pavilion N5430, from a 2.4.21 kernel
>>to 2.6.12. As a result of
>>doing this my sound no longer works correctly. It plays the same thing
>>repeatedly some number
>>of times - if it plays at all.
>>
>>Any ideas on how to debug this would be appreciated.
>>
>>Additional info I don't see any interrupts in /proc/interrupts for the
>>Allegro which is on int 5.
>>I just tried the same laptop with knoppix and a 2.4.27 kernel and sound
>>works great and I do
>>see interrupts for Allegro on int 5.
>>    
>>
>
>The irq problem is likely related with ACPI.
>Try to boot once with pci=noacpi.
>
>
>Takashi
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hi Takashi,

I have boot the 2.6.12 kernel with acpi=off pci=noacpi,usepirqmask or I
get a panic or a hang.

I don't have to do this with 2.4.27, anybody know why?

Steve

