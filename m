Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVCHXOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVCHXOp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 18:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVCHXO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 18:14:27 -0500
Received: from mail0.lsil.com ([147.145.40.20]:9927 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262193AbVCHXFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:05:51 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230CC17@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'Arjan van de Ven'" <arjan@infradead.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>
Subject: RE: [ANNOUNCE][PATCH 2.6.11 1/3] megaraid_sas: Announcing new mod
	ule  for LSI Logic's SAS based MegaRAID controllers
Date: Tue, 8 Mar 2005 18:05:11 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>>  source "drivers/scsi/megaraid/Kconfig.megaraid"
>> +source "drivers/scsi/megaraid/Kconfig.megaraid_sas"
>>  
>
>why a fully separate file and not add your ONE config option to
>Kconfig.megaraid instead ??
>

Arjan, I didn't want to needlessly couple megaraid and megaraid_sas.
Since they are in the same directory, I couldn't avoid having single
Makefile. I thought at least these two should be separate to be consistent
with their independent nature.

If this is not a good enough reason, I will merge these two files.

Thanks,
Sreenivas
