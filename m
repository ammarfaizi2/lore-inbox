Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVCIQJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVCIQJe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 11:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVCIQFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 11:05:30 -0500
Received: from mail0.lsil.com ([147.145.40.20]:36760 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261652AbVCIQCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 11:02:17 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230CC1E@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'Arjan van de Ven'" <arjan@infradead.org>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>
Subject: RE: [ANNOUNCE][PATCH 2.6.11 2/3] megaraid_sas: Announcing new mod
	 ule  for LSI Logic's SAS based MegaRAID controllers
Date: Wed, 9 Mar 2005 11:01:40 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> . And since this is compile time
>> system-wide property, I kept it as driver global.
>
>that step I don't understand... why is it a global *VARIABLE* if it's
>compile time system-wide property...
>

I see your point! Are you saying I should use if(sizeof(dma_addr_t)==8)
instead of the shortcut if(is_dma64)? Are you thinking of "const" modifier?
Please advice.
