Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbVHYLCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbVHYLCW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 07:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbVHYLCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 07:02:22 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42767 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964935AbVHYLCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 07:02:21 -0400
Date: Thu, 25 Aug 2005 13:02:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: libata-dev queue updated
Message-ID: <20050825110218.GN4851@stusta.de>
References: <BF571719A4041A478005EF3F08EA6DF001617907@pcsmail03.pcs.pc.ome.toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BF571719A4041A478005EF3F08EA6DF001617907@pcsmail03.pcs.pc.ome.toshiba.co.jp>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 03:56:23PM +0900, Tomita, Haruo wrote:

> Hi Jeff,
> 
> 2.6.13- rc7-libata1.patch.bz2 was used. 
> A combined mode of ata_piix seems not to work. 
> Is the following patches correct?
> 
> diff -urN linux-2.6.13-rc7.orig/drivers/scsi/Kconfig linux-2.6.13-rc7/drivers/scsi/Kconfig
> --- linux-2.6.13-rc7.orig/drivers/scsi/Kconfig	2005-08-25 13:44:33.000000000 +0900
> +++ linux-2.6.13-rc7/drivers/scsi/Kconfig	2005-08-25 14:33:38.000000000 +0900
> @@ -424,7 +424,7 @@
>  source "drivers/scsi/megaraid/Kconfig.megaraid"
>  
>  config SCSI_SATA
> -	tristate "Serial ATA (SATA) support"
> +	bool "Serial ATA (SATA) support"
>  	depends on SCSI
>  	help
>  	  This driver family supports Serial ATA host controllers

No, this bug reintroduces a problem with SCSI=m.

Which problem do you face?
And how did this change alone fix it for you?

> Haruo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

