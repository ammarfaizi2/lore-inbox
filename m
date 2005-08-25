Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbVHYJFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbVHYJFz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 05:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbVHYJFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 05:05:55 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:19647 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964885AbVHYJFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 05:05:54 -0400
Date: Thu, 25 Aug 2005 11:05:51 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@www.linux.org.uk>
cc: geert@linux-m68k.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH] (5/22) static vs. extern in amigaints.h
In-Reply-To: <E1E8ADe-0005b9-51@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.61.0508251104380.24552@scrub.home>
References: <E1E8ADe-0005b9-51@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 25 Aug 2005, Al Viro wrote:

> ----
> diff -urN RC13-rc7-sun3_pgtable/include/asm-m68k/amigaints.h RC13-rc7-amigaints/include/asm-m68k/amigaints.h
> --- RC13-rc7-sun3_pgtable/include/asm-m68k/amigaints.h	2005-06-17 15:48:29.000000000 -0400
> +++ RC13-rc7-amigaints/include/asm-m68k/amigaints.h	2005-08-25 00:54:07.000000000 -0400
> @@ -109,8 +109,6 @@
>  extern void amiga_do_irq(int irq, struct pt_regs *fp);
>  extern void amiga_do_irq_list(int irq, struct pt_regs *fp);
>  
> -extern unsigned short amiga_intena_vals[];
> -
>  /* CIA interrupt control register bits */
>  
>  #define CIA_ICR_TA	0x01

I have larger changes pending in this area, so I'd prefer you drop this 
one.

bye, Roman
