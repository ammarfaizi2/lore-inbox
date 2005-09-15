Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbVIOMn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbVIOMn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 08:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbVIOMn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 08:43:59 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:42687 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1030363AbVIOMn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 08:43:58 -0400
Message-ID: <432969D6.1040400@linuxtv.org>
Date: Thu, 15 Sep 2005 16:32:22 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Antonino A. Daplas" <adaplas@gmail.com>
CC: Ralph Metzler <rjkm@metzlerbros.de>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com>	<200509150843.33849@bilbo.math.uni-mannheim.de>	<4329269E.1060003@linuxtv.org>	<200509151018.20322@bilbo.math.uni-mannheim.de>	<4329362A.1030201@linuxtv.org> <17193.19739.213773.593444@localhost.localdomain> <43295E41.8010808@linuxtv.org> <43296445.8040805@gmail.com>
In-Reply-To: <43296445.8040805@gmail.com>
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

Antonino A. Daplas wrote:

>This is your failure path, return nonzero here, preferable describing the
>error condition.
>  
>
Thanks a lot guys, I mean all of you. Otherwise i would have pulled out 
my hair for some more time !

The IRQ issue still i don't feel a too comfortable though.

Thanks,
Manu




[ 3689.479339] mantis_pci_probe: <1:>IRQ=23
[ 3689.479518] mantis_pci_probe: <2:>IRQ=23
[ 3689.479685] mantis_pci_probe: Got a device
[ 3689.479869] mantis_pci_probe: We got an IRQ
[ 3689.480036] mantis_pci_probe: We finally enabled the device
[ 3689.480290] Mantis Rev 1, irq: 23, latency: 32
[ 3689.480403]          memory: 0xefeff000, mmio: f92a4000
[ 3695.984470] mantis_pci_remove: Removing -->Mantis irq: 23,         
latency: 32
[ 3695.984473]  memory: 0xefeff000, mmio: 0xf92a4000
[ 3695.984934] Trying to free free IRQ23
