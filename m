Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbTEBVqA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 17:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTEBVqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 17:46:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:30031 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263182AbTEBVp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 17:45:59 -0400
Message-ID: <3EB2E9F7.9000708@gmx.net>
Date: Fri, 02 May 2003 23:58:15 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: "Javi Pardo (DAKOTA)" <dakota@dakotabcn.net>
CC: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ataraid-list@redhat.com
Subject: Re: promise NEITHER IDE PORT ENABLED
References: <040101c308df$452110f0$3200000a@dakotapiv> <3EA683A8.8040303@gmx.net> <036f01c30ff0$d2197fc0$3200000a@dakotapiv>
In-Reply-To: <036f01c30ff0$d2197fc0$3200000a@dakotapiv>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre, Alan,

could you please take a look at this? I thought the IDE code in
2.4.21-rc1 is able to force enable the ports of a promise controller.

Javi Pardo (DAKOTA) wrote:
> 
> i am probed with the kernel 2.4.21-rc1 and the result is... NEITHER IDE..  
> my Motheboard is Tyan Tiger 200T wit Dual processor and promise integrated and only works with the original kernel of RH 8
> 
>Carl-Daniel Hailfinger wrote:
> 
>>Javi Pardo (DAKOTA) wrote:
>>
>>>Hello
>>>I am Installed RH 8 with standard kernel 2.4.18
>>>i am downloaded the kernel 2.4.20 from kernel.org and i am problem with Promise 
>>
>>Could you please test 2.4.21-rc1? It has newer IDE and could help.
>>
>>
>>>PDC20267: Neither ide ports enabled in bios
>>>
>>>the motheboard is the tyan Tiger200T, this model have promise ATA100 inside
>>>
>>>i am selected this options in the kernel
>>
>>The options look good, but 2.4.20 has some Promise IDE flaws which could
>>cause your problem.
>>
>>
>>>CONFIG_BLK_DEV_PDC202XX=y
>>># CONFIG_PDC202XX_BURST is not set
>>>CONFIG_PDC202XX_FORCE=y
>>>CONFIG_BLK_DEV_VIA82CXXX=y
>>># CONFIG_IDE_CHIPSETS is not set
>>>CONFIG_IDEDMA_AUTO=y
>>># CONFIG_IDEDMA_IVB is not set
>>># CONFIG_DMA_NONPCI is not set
>>>CONFIG_BLK_DEV_IDE_MODES=y
>>>CONFIG_BLK_DEV_ATARAID=y
>>>CONFIG_BLK_DEV_ATARAID_PDC=y
>>># CONFIG_BLK_DEV_ATARAID_HPT is not set
>>>
>>>I need help, i am read this list and the option CONFIG_PDC202XX_FORCE=y is the solution, but no work.. why?
>>
>>Please try 2.4.21-rc1 and report back to this list.
>>

Thanks,
Carl-Daniel

