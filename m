Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267141AbSLDWkr>; Wed, 4 Dec 2002 17:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267142AbSLDWkr>; Wed, 4 Dec 2002 17:40:47 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:12778 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267141AbSLDWkq>; Wed, 4 Dec 2002 17:40:46 -0500
Date: Wed, 4 Dec 2002 23:48:06 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "White, Charles" <Charles.White@hp.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20 cciss  patch 01 - adds support for the SA641, SA642 and SA6400 controllers.
Message-ID: <20021204224806.GJ2544@fs.tum.de>
References: <A2C35BB97A9A384CA2816D24522A53BB03991726@cceexc18.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A2C35BB97A9A384CA2816D24522A53BB03991726@cceexc18.americas.cpqcorp.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 04:23:37PM -0600, White, Charles wrote:

>...
> --- linux-2.4.20.orig/drivers/block/cciss.c	Thu Nov 28 18:53:12 2002
> +++ linux-2.4.20.cciss_p01/drivers/block/cciss.c	Wed Dec  4
> 15:09:39 2002
> @@ -56,6 +56,11 @@
>  #include "cciss.h"
>  #include <linux/cciss_ioctl.h>
>  
> +/* remove when PCI_DEVICE_ID_COMPAQ_CCISSC is in pci_ids.h */
> +#ifndef PCI_DEVICE_ID_COMPAQ_CCISSC
> +#define PCI_DEVICE_ID_COMPAQ_CCISSC 0x46
> +#endif
> +
>...

Why doesn't your patch include it into pci_ids.h?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

