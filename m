Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVCIBPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVCIBPa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 20:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVCIBPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 20:15:30 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23821 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261360AbVCIBPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 20:15:17 -0500
Date: Wed, 9 Mar 2005 02:15:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'Arjan van de Ven'" <arjan@infradead.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>
Subject: Re: [ANNOUNCE][PATCH 2.6.11 1/3] megaraid_sas: Announcing new mod ule  for LSI Logic's SAS based MegaRAID controllers
Message-ID: <20050309011516.GE3146@stusta.de>
References: <0E3FA95632D6D047BA649F95DAB60E570230CC17@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230CC17@exa-atlanta>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 06:05:11PM -0500, Bagalkote, Sreenivas wrote:
> >
> >>  source "drivers/scsi/megaraid/Kconfig.megaraid"
> >> +source "drivers/scsi/megaraid/Kconfig.megaraid_sas"
> >>  
> >
> >why a fully separate file and not add your ONE config option to
> >Kconfig.megaraid instead ??
> >
> 
> Arjan, I didn't want to needlessly couple megaraid and megaraid_sas.
> Since they are in the same directory, I couldn't avoid having single
> Makefile. I thought at least these two should be separate to be consistent
> with their independent nature.
> 
> If this is not a good enough reason, I will merge these two files.

Please merge them.

Whether they are in the same Kconfig file or not does not in any way 
imply any relation between them.

E.g. drivers/scsi/Kconfig contains many drivers that are not in any way 
coupled to each other.

> Thanks,
> Sreenivas

cu
Adrian

BTW: Why does the text say "(New Driver)"?

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

