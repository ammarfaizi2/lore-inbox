Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbTEFKpv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 06:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbTEFKpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 06:45:51 -0400
Received: from mail.gmx.de ([213.165.64.20]:601 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262526AbTEFKpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 06:45:49 -0400
Message-ID: <3EB79542.5000903@gmx.net>
Date: Tue, 06 May 2003 12:58:10 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: "Javi Pardo (DAKOTA)" <dakota@dakotabcn.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ataraid-list@redhat.com
Subject: Re: promise NEITHER IDE PORT ENABLED
References: <040101c308df$452110f0$3200000a@dakotapiv> <3EA683A8.8040303@gmx.net> <036f01c30ff0$d2197fc0$3200000a@dakotapiv> <3EB2E9F7.9000708@gmx.net> <1051974189.24562.0.camel@dhcp22.swansea.linux.org.uk> <008e01c31224$844c2050$3200000a@dakotapiv>
In-Reply-To: <008e01c31224$844c2050$3200000a@dakotapiv>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

could you please elaborate which of the options you meant is missing
below? Thanks.

Javi Pardo (DAKOTA) wrote:
> Alan Cox wrote:
>>Carl-Daniel Hailfinger wrote:
>>
>>>could you please take a look at this? I thought the IDE code in
>>>2.4.21-rc1 is able to force enable the ports of a promise controller.
>>
>>It can - if you set the configuration option to do so
>>
> 
> i am the problem with the PDC20267 Chipset.
> 
> i am downloaded the kernel 2.4.20 and 2.4.21-rc1
> and i am set this options for IDE
> 
> CONFIG_BLK_DEV_PDC202XX=y
> # CONFIG_PDC202XX_BURST is not set
> CONFIG_PDC202XX_FORCE=y                      <- this options force IDE detections 
> CONFIG_BLK_DEV_VIA82CXXX=y
> # CONFIG_IDE_CHIPSETS is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_IDEDMA_IVB is not set
> # CONFIG_DMA_NONPCI is not set
> CONFIG_BLK_DEV_IDE_MODES=y
> CONFIG_BLK_DEV_ATARAID=y
> CONFIG_BLK_DEV_ATARAID_PDC=y
> # CONFIG_BLK_DEV_ATARAID_HPT is not set
> 
> 
> the kernel 2.4.20 and 2.4.21-rc1 NO detect the ide channels and mi system crashes
> 
> wath is the problem? i am select all correct options but no work...

Regards,
Carl-Daniel

