Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266809AbSKHRIf>; Fri, 8 Nov 2002 12:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266811AbSKHRIf>; Fri, 8 Nov 2002 12:08:35 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:31132 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266809AbSKHRIe>; Fri, 8 Nov 2002 12:08:34 -0500
Subject: Re: [PATCH] Fix typo in sl82c105.c driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       benh@kernel.crashing.org
In-Reply-To: <15817.54799.955377.260781@argo.ozlabs.ibm.com>
References: <15817.54799.955377.260781@argo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Nov 2002 17:38:29 +0000
Message-Id: <1036777109.16651.43.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-07 at 02:55, Paul Mackerras wrote:
> This patch fixes a minor typo in sl82c105.c which stops it from
> compiling.
> 
> Jens and/or Linus, please apply.
> 
> Paul.
> 
> diff -urN linux-2.5/drivers/ide/pci/sl82c105.c pmac-2.5/drivers/ide/pci/sl82c105.c
> --- linux-2.5/drivers/ide/pci/sl82c105.c	2002-10-12 14:40:28.000000000 +1000
> +++ pmac-2.5/drivers/ide/pci/sl82c105.c	2002-10-30 12:32:48.000000000 +1100
> @@ -284,7 +284,7 @@
>  
>  static int __devinit sl82c105_init_one(struct pci_dev *dev, const struct pci_device_id *id)
>  {
> -	ide_pci_device_t *d = &slc82c105_chipsets[id->driver_data];
> +	ide_pci_device_t *d = &sl82c105_chipsets[id->driver_data];
>  	if (dev->device != d->device)
>  		BUG();
>  	ide_setup_pci_device(dev, d);

Looks good to me

