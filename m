Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264362AbTEaPpT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 11:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264357AbTEaPpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 11:45:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:20713 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264362AbTEaPpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 11:45:18 -0400
Date: Sat, 31 May 2003 17:58:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       akpm@digeo.com
Subject: Re: [PATCH] Eat keys on panic
Message-ID: <20030531155834.GA29425@fs.tum.de>
References: <20030531115653.GA11119@wotan.suse.de> <1054390488.27311.5.camel@dhcp22.swansea.linux.org.uk> <20030531154521.GA8602@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030531154521.GA8602@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 05:45:21PM +0200, Andi Kleen wrote:
>...
> --- linux/arch/i386/kernel/ioport.c	30 May 2003 20:12:29 -0000	1.17
> +++ linux/arch/i386/kernel/ioport.c	31 May 2003 14:24:16 -0000
> @@ -15,6 +15,8 @@
>  #include <linux/stddef.h>
>  #include <linux/slab.h>
>  #include <linux/thread_info.h>
> +#include <asm/io.h>
> +#include <linux/delay.h>
>...

Could you move the #include <linux/delay.h> above the
#include <asm/io.h> ?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

