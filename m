Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVACWdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVACWdm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVACWa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:30:56 -0500
Received: from banana.active-ns.com ([213.230.202.60]:950 "EHLO
	banana.catalyst2.com") by vger.kernel.org with ESMTP
	id S261911AbVACW0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:26:11 -0500
Message-ID: <41D9C5C2.5010606@linuxmod.co.uk>
Date: Mon, 03 Jan 2005 22:22:58 +0000
From: Joel Cant <lkml@linuxmod.co.uk>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Wong <kernel@implode.net>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Promise IDE DMA issue
References: <20050102173704.GA14056@gambit.implode.net> <41D9885B.9090304@pobox.com> <20050103215250.GA9409@gambit.implode.net>
In-Reply-To: <20050103215250.GA9409@gambit.implode.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - banana.catalyst2.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxmod.co.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Wong wrote:

>Latest 1.009 BIOS flashed last night.  I'll try out some BIOS settings, 
>but the settings work fine with Windows XP.  That's why I think it could 
>be something with the driver.  This is with the PDC202XX_NEW on kernel 
>2.6.10  The DMA timeout happens sporadically, but as of yet, has yet to
>reoccur.  The change from 1.008 to 1.009 mentions nothing about the
>Promide IDE.  
>
>John
>
>On Mon, Jan 03, 2005 at 01:00:59PM -0500, Jeff Garzik wrote:
>  
>
>>John Wong wrote:
>>    
>>
>>>I recently upgraded fron a nVidia nForce2 MCP-T based A7NX-DX
>>>motherboard to an A8V DX, Via K8T800 Pro.  Now occassionally, I get 
>>>DMA issues on a drive attached to a Promise 133 TX2 controller (20269).
>>>      
>>>
>>I would try fiddling with BIOS settings, and make sure you have the 
>>latest BIOS.
>>
>>	Jeff
>>
>>
>>
>>
>>    
>>
Sounds simlar to the problems i'm having with the channels resetting 
under heavy load, and then fudging DMA, and i'm not the only one havign 
these issues, seems its a common problem with these cards, not sure if 
theres been some slight changes in the chip itself or wether there is a 
fault with the kernel driver, as you say, it seems that the problem does 
not occour under windows.

Joel
