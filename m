Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263540AbRFNSH1>; Thu, 14 Jun 2001 14:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263584AbRFNSHR>; Thu, 14 Jun 2001 14:07:17 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38413 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263540AbRFNSHD>; Thu, 14 Jun 2001 14:07:03 -0400
Subject: Re: Minor "cleanup" patches for 2.4.5-ac kernels
To: michal@harddata.com (Michal Jaegermann)
Date: Thu, 14 Jun 2001 19:05:55 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20010612183832.A29923@mail.harddata.com> from "Michal Jaegermann" at Jun 12, 2001 06:38:32 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15AbVD-00053n-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-2.4.5ac/drivers/pci/quirks.c~	Tue Jun 12 16:31:12 2001
> +++ linux-2.4.5ac/drivers/pci/quirks.c	Tue Jun 12 17:13:18 2001
> @@ -18,6 +18,7 @@
>  #include <linux/pci.h>
>  #include <linux/init.h>
>  #include <linux/delay.h>
> +#include <linux/sched.h>

Ok

>  
> This one is replacing a symbol in sg.c to one which is exported
> so 'sg.o' can be compiled as a valid module.

Export the right symbol on Alpha ?

>  
> +/* Forward declaration */
> +struct mm_struct;
> +

Ok
