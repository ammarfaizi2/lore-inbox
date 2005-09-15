Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbVIOKq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbVIOKq5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 06:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbVIOKq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 06:46:57 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:7067 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S932593AbVIOKq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 06:46:56 -0400
Message-ID: <43294E68.8080308@linuxtv.org>
Date: Thu, 15 Sep 2005 14:35:20 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralph Metzler <rjkm@metzlerbros.de>
CC: Rolf Eike Beer <eike-kernel@sf-tec.de>, Jiri Slaby <jirislaby@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com>	<200509150843.33849@bilbo.math.uni-mannheim.de>	<4329269E.1060003@linuxtv.org>	<200509151018.20322@bilbo.math.uni-mannheim.de>	<4329362A.1030201@linuxtv.org> <17193.19739.213773.593444@localhost.localdomain>
In-Reply-To: <17193.19739.213773.593444@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Ralph Metzler wrote:

>Hi Manu,
>
>  
>
Hello Ralph,

It's been a long time since heard your voice. I thought you had been 
damn busy.
Nice to hear from you.

>Manu Abraham writes:
> > [  102.261264] mantis_pci_probe: Got a device
> > [  102.262852] mantis_pci_probe: We got an IRQ
> > [  102.264392] mantis_pci_probe: We finally enabled the device
> > [  102.266020] Mantis Rev 1, irq: 23, latency: 32
> > [  102.266118]          memory: 0xefeff000, mmio: f9218000
> > [  102.269162] Trying to free free IRQ23
> > [  110.297341] mantis_pci_remove: Removing -->Mantis irq: 23,         
> > latency: 32
> > [  110.297344]  memory: 0xefeff000, mmio: 0xf9218000
> > [  110.301326] Trying to free free IRQ23
> > [  110.303445] Trying to free nonexistent resource <efeff000-efefffff>
>
>
>I think you should call pci_enable_device() before request_irq, etc. 
>  
>

Sure i will try that out..

>AFAIK, the pci_enable_device() can change resources like IRQ.
>That's probably what causes these errors. Just print out the irq 
>number before and after pci_enable_device() to check if that's the 
>problem.
>
>  
>

I will check this out. I will come back on this soon.


Regards,
Manu


