Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265810AbUATWoG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 17:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265814AbUATWoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 17:44:06 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:47589 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265810AbUATWoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 17:44:02 -0500
Date: Tue, 20 Jan 2004 23:43:52 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: in <i.n@netcabo.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] <drivers/usb/storage/dpcm.c>, kernel <2.6.1>
Message-ID: <20040120224352.GL12027@fs.tum.de>
References: <20040117134256.09046469.i.n@netcabo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117134256.09046469.i.n@netcabo.pt>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17, 2004 at 01:42:56PM +0000, in wrote:
> [PATCH] <drivers/usb/storage/dpcm.c>, kernel <2.6.1>
> 
> It just takes out the unused int! just takes of the warning when compiling!


It isn't unused #ifdef CONFIG_USB_STORAGE_SDDR09 .



> --- a/drivers/usb/storage/dpcm.c  2003-12-18 02:59:15.000000000 +0000
> +++ linux/drivers/usb/storage/dpcm.c    2004-01-17 13:22:49.000000000 +0000
> @@ -43,8 +43,6 @@
>   */
>  int dpcm_transport(Scsi_Cmnd *srb, struct us_data *us)
>  {
> -  int ret;
> -
>    if(srb == NULL)
>      return USB_STOR_TRANSPORT_ERROR;

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

