Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261541AbSK1Pqf>; Thu, 28 Nov 2002 10:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSK1Pqf>; Thu, 28 Nov 2002 10:46:35 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:7319 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261541AbSK1Pqf>; Thu, 28 Nov 2002 10:46:35 -0500
Subject: Re: drivers/pci/quirks.c / Re: Linux v2.5.50
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sebastian Benoit <benoit-lists@fb12.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20021128111528.A28437@turing.fb12.de>
References: <Pine.LNX.4.44.0211271456160.18214-100000@penguin.transmeta.com> 
	<20021128111528.A28437@turing.fb12.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Nov 2002 16:25:43 +0000
Message-Id: <1038500743.10021.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-28 at 10:15, Sebastian Benoit wrote:
> 
> with CONFIG_X86_IO_APIC=y I get
> 
>   gcc -Wp,-MD,drivers/pci/.quirks.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=quirks -DKBUILD_MODNAME=quirks   -c -o drivers/pci/quirks.o drivers/pci/quirks.c
> drivers/pci/quirks.c: In function `quirk_ioapic_rmw':
> drivers/pci/quirks.c:354: `sis_apic_bug' undeclared (first use in this function)
> drivers/pci/quirks.c:354: (Each undeclared identifier is reported only once
> drivers/pci/quirks.c:354: for each function it appears in.)
> make[2]: *** [drivers/pci/quirks.o] Error 1
> make[1]: *** [drivers/pci] Error 2
> make: *** [drivers] Error 2
>

I'll send Linus the code I actually originally meant to send him, that
tidies this stuff up IMHO a lot better

