Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVG1RM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVG1RM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVG1RJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 13:09:56 -0400
Received: from 66.Red-80-38-104.pooles.rima-tde.net ([80.38.104.66]:53136 "EHLO
	fulanito.nisupu.com") by vger.kernel.org with ESMTP id S261763AbVG1RIv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 13:08:51 -0400
Message-ID: <42E91182.4050608@nisupu.com>
Date: Thu, 28 Jul 2005 19:10:26 +0200
From: Carlos Fernandez Sanz <cfs-lk@nisupu.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: mdew <some.nzguy@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: HPT370 errors under 2.6.13-rc3-mm1
References: <1c1c863605072219283716a131@mail.gmail.com> <1122148440.27629.6.camel@localhost.localdomain>
In-Reply-To: <1122148440.27629.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I experienced this same thing (with an HPT too, I might say), and the 
problem seemed to be an underpowered system. Replaced the power supply 
and the problem went away.

My box had 7 HDs, all of them worked fine using a different system but I 
got these errors when they where together. I thought it was the HTP card 
but replacing it didn't help. Turned out it was the PS...

Alan Cox wrote:

>On Sad, 2005-07-23 at 14:28 +1200, mdew wrote:
>  
>
>>I'm unable to mount an ext2 drive using the hpt370A raid card.
>>
>>upon mounting the drive, dmesg will spew these errors..I've tried
>>different cables and drive is fine.
>>    
>>
>
>  
>
>>Jul 23 01:30:21 localhost kernel: hdf: dma timeout error: status=0x25
>>{ DeviceFault CorrectedError Error }
>>Jul 23 01:30:21 localhost kernel: hdf: dma timeout error: error=0x25 {
>>DriveStatusError AddrMarkNotFound }, LBAsect=8830589412645,
>>high=526344, low=2434341, sector=390715711
>>    
>>
>
>Your drive disagrees with you. Note that it said
>
>"Device fault"
>"Error"
>"Drive Status Error"
>"Address Mark Not Found"
>
>
>that came from the drive not the OS.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
