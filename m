Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317816AbSGKLOj>; Thu, 11 Jul 2002 07:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317817AbSGKLOi>; Thu, 11 Jul 2002 07:14:38 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12296 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317816AbSGKLOh>; Thu, 11 Jul 2002 07:14:37 -0400
Subject: Re: [patch] 2.5.25 I2C driver id and Config updates
To: ac9410@bellsouth.net (Albert Cranford)
Date: Thu, 11 Jul 2002 12:41:04 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel List),
       torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <3D2D1712.DA5D89E8@bellsouth.net> from "Albert Cranford" at Jul 11, 2002 01:26:42 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17ScJk-0000h3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you please apply these 3 patches toward 2.5.26.
> They include Config.in updates, additions in i2c-id.h
> for "Video for Linux" and a compatibility fix for
> i2c-algo-bit.c
> 
> 
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
> + 		if (current->need_resched)
> + 			schedule();
> +#else
>  		cond_resched();
> +#endif

Why are you adding non 2.5 code to 2.5 ?

