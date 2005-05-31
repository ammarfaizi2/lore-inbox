Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVEaA1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVEaA1n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 20:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVEaAYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 20:24:24 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61200 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261841AbVEaAXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 20:23:22 -0400
Date: Tue, 31 May 2005 02:23:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.11-mm3: megaraid_sas.c: stack usage
Message-ID: <20050531002315.GF3627@stusta.de>
References: <0E3FA95632D6D047BA649F95DAB60E570230CC3D@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230CC3D@exa-atlanta>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 10:13:17AM -0500, Bagalkote, Sreenivas wrote:
> >On Sat, Mar 12, 2005 at 03:42:22AM -0800, Andrew Morton wrote:
> >>...
> >> All 606 patches:
> >>...
> >> megaraid_sas-announcing-new-module-for.patch
> >>   megaraid_sas: Announcing new module for LSI Logic's SAS 
> >based MegaRAID controllers
> >>...
> >
> >Enormous stack usage:
> >- megasas_init_mfi (due to ctrl_info)
> >
> >Big stack usage:
> >- megasas_mgmt_ioctl (due to uioc and dv)
> >- megasas_mgmt_fw_ioctl (due to uioc)
> >
> >Please fix this.
> 
> Will do.

This issue is still present in 2.6.12-rc5-mm1.
Please fix at least the megasas_init_mfi stack usage.

> Thanks,
> Sreenivas

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

