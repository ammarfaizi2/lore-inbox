Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbTKLGTS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 01:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbTKLGTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 01:19:17 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:23568 "EHLO w.ods.org")
	by vger.kernel.org with ESMTP id S261771AbTKLGTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 01:19:16 -0500
Date: Wed, 12 Nov 2003 07:19:09 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Kaj-Michael Lang <milang@tal.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-rc1
Message-ID: <20031112061909.GB9634@alpha.home.local>
References: <Pine.LNX.4.44.0311101723110.2001-100000@logos.cnet> <009001c3a89a$af611130$54dc10c3@amos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009001c3a89a$af611130$54dc10c3@amos>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

for me, -rc1 compiles correctly on Alpha, but I don't use agpgart. So I
guess it's about your only problem here.

Regards,
Willy

On Tue, Nov 11, 2003 at 11:27:59PM +0200, Kaj-Michael Lang wrote:
> > Hi,
> >
> > Here goes -rc1.
> >
> > It contains network driver fixes (b44, tg3, 8139cp), several x86-64
> > bugfixes, amongst others.
> 
> Compiling for Alpha fails with:
> ...
> gcc -D__KERNEL__ -I/work/collection/talinux/kernel/kernel24/tmp/alpha/linux-
> 2.4.22/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-alia
> sing -fno-common -fomit-frame-pointer -pipe -mno-fp-regs -ffixed-8 -mcpu=ev5
>  -Wa,-mev6   -nostdinc -iwithprefix
> nclude -DKBUILD_BASENAME=agpgart_be  -DEXPORT_SYMTAB -c agpgart_be.c
> agpgart_be.c:52: asm/msr.h: No such file or directory
> agpgart_be.c:493: warning: `agp_generic_create_gatt_table' defined but not
> used
> agpgart_be.c:627: warning: `agp_generic_free_gatt_table' defined but not
> used
> ...
> 
> Same config works fine for 2.4.22
> 
> -- 
> Kaj-Michael Lang , milang@tal.org
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
