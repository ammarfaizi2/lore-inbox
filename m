Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965767AbWKIAfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965767AbWKIAfs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 19:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965935AbWKIAfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 19:35:48 -0500
Received: from smtpout04-04.prod.mesa1.secureserver.net ([64.202.165.199]:45777
	"HELO smtpout04-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S965767AbWKIAfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 19:35:47 -0500
Message-ID: <455277E1.3040803@seclark.us>
Date: Wed, 08 Nov 2006 19:35:45 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Abysmal PATA IDE performance
References: <455206E7.2050104@seclark.us> <45526D50.5020105@rtr.ca>
In-Reply-To: <45526D50.5020105@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:

>Remove the drivers/ide stuff from you system and let libata (ata_piix)
>manage the ICH7.  That should speed things up quite a bit.
>
>-ml
>
>  
>
Isn't already enabled?

ata_piix 0000:00:1f.2: version 2.00
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 233
ata: 0x170 IDE port busy
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
scsi0 : ata_piix

also this laptop has nothing on ide0 - both the harddrive and dvdrom are 
on ide1.
is this confusing things?

Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



