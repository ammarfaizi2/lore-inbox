Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVCIOi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVCIOi5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 09:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVCIOi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 09:38:56 -0500
Received: from mail0.lsil.com ([147.145.40.20]:46224 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261648AbVCIOiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 09:38:50 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230CC1B@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'Adrian Bunk'" <bunk@stusta.de>
Cc: "'Arjan van de Ven'" <arjan@infradead.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>
Subject: RE: [ANNOUNCE][PATCH 2.6.11 1/3] megaraid_sas: Announcing new mod
	 ule  for LSI Logic's SAS based MegaRAID controllers
Date: Wed, 9 Mar 2005 09:30:22 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >
>> >>  source "drivers/scsi/megaraid/Kconfig.megaraid"
>> >> +source "drivers/scsi/megaraid/Kconfig.megaraid_sas"
>> >>  
>> >
>> >why a fully separate file and not add your ONE config option to
>> >Kconfig.megaraid instead ??
>> >
>> 
>> Arjan, I didn't want to needlessly couple megaraid and megaraid_sas.
>> Since they are in the same directory, I couldn't avoid having single
>> Makefile. I thought at least these two should be separate to 
>be consistent
>> with their independent nature.
>> 
>> If this is not a good enough reason, I will merge these two files.
>
>Please merge them.
>
>Whether they are in the same Kconfig file or not does not in any way 
>imply any relation between them.
>
>E.g. drivers/scsi/Kconfig contains many drivers that are not 
>in any way 
>coupled to each other.
>

Understood. I will merge them.

>
>BTW: Why does the text say "(New Driver)"?
>

I thought I saw some new modules being labeled as such. I will remove
it in the next update if it not correct.

>-- 
>
>       "Is there not promise of rain?" Ling Tan asked suddenly out
>        of the darkness. There had been need of rain for many days.
>       "Only a promise," Lao Er said.
>                                       Pearl S. Buck - Dragon Seed
>
There is a 30% chance of rain here today.

Thanks,
Sreenivas
LSI Logic Corporation
