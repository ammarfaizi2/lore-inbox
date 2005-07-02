Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVGBS1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVGBS1w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 14:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVGBS1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 14:27:52 -0400
Received: from cantor.suse.de ([195.135.220.2]:25516 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261221AbVGBS1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 14:27:50 -0400
Date: Sat, 2 Jul 2005 20:27:49 +0200
From: Andi Kleen <ak@suse.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ISA DMA suspend for x86_64
Message-ID: <20050702182749.GJ21330@wotan.suse.de>
References: <42B1A08B.8080601@drzeus.cx.suse.lists.linux.kernel> <20050616170622.A1712@flint.arm.linux.org.uk.suse.lists.linux.kernel> <42C3A698.9020404@drzeus.cx.suse.lists.linux.kernel> <1120130926.6482.83.camel@localhost.localdomain.suse.lists.linux.kernel> <42C3E3A4.3090305@drzeus.cx.suse.lists.linux.kernel> <42C432BB.407@drzeus.cx.suse.lists.linux.kernel> <p73u0jeg5lg.fsf@verdi.suse.de> <42C6CF40.4040308@drzeus.cx> <20050702174055.GI21330@wotan.suse.de> <42C6D3D5.6070909@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C6D3D5.6070909@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Like this?

You still need to add it to the obj-ys

-Andi

> 
> Rgds
> Pierre
> 

> Index: linux-wbsd/arch/x86_64/kernel/Makefile
> ===================================================================
> --- linux-wbsd/arch/x86_64/kernel/Makefile	(revision 153)
> +++ linux-wbsd/arch/x86_64/kernel/Makefile	(working copy)
> @@ -44,3 +45,4 @@
>  microcode-$(subst m,y,$(CONFIG_MICROCODE))  += ../../i386/kernel/microcode.o
>  intel_cacheinfo-y		+= ../../i386/kernel/cpu/intel_cacheinfo.o
>  quirks-y			+= ../../i386/kernel/quirks.o
> +i8237-y				+= ../../i386/kernel/i8237.o

