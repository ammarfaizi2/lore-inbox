Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265228AbSK1HTw>; Thu, 28 Nov 2002 02:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbSK1HTv>; Thu, 28 Nov 2002 02:19:51 -0500
Received: from technicolor.pl ([62.21.19.63]:47625 "EHLO wilnet.info")
	by vger.kernel.org with ESMTP id <S265228AbSK1HTv>;
	Thu, 28 Nov 2002 02:19:51 -0500
Date: Thu, 28 Nov 2002 08:27:09 +0100 (CET)
From: Pawel Bernadowski <pbern@wilnet.info>
To: linux-kernel@vger.kernel.org
Subject: error in quirks.c
Message-ID: <Pine.LNX.4.50L.0211280826070.24209-100000@farma.wilnet.info>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use 2.5.50 and always get this error
  gcc -Wp,-MD,drivers/pci/.quirks.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-Iarch/i386/mach-generic -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=quirks -DKBUILD_MODNAME=quirks   -c -o 
drivers/pci/quirks.o drivers/pci/quirks.c
drivers/pci/quirks.c: In function `quirk_ioapic_rmw':
drivers/pci/quirks.c:354: `sis_apic_bug' undeclared (first use in this 
function)
drivers/pci/quirks.c:354: (Each undeclared identifier is reported only 
once
drivers/pci/quirks.c:354: for each function it appears in.)



