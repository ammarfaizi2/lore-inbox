Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSEYAfq>; Fri, 24 May 2002 20:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313114AbSEYAfp>; Fri, 24 May 2002 20:35:45 -0400
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:54150 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S313113AbSEYAfo>; Fri, 24 May 2002 20:35:44 -0400
Date: Fri, 24 May 2002 17:35:40 -0700 (PDT)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: whitney@math.berkeley.edu
To: LKML <linux-kernel@vger.kernel.org>
Subject: AMD 760MP vs AMD 760MPX -ac kernel support
Message-ID: <Pine.LNX.4.44.0205241711490.21993-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Since Alan Cox has a machine with the AMD 760MPX chipset (AMD 762
northbridge and AMD 768 southbridge), the -ac kernel tree contains support
for various AMD 760MPX functionality:

arch/i386/kernel/pci-irq.c	AMD 768 IRQ Router
drivers/char/amd768_rng.c	AMD 768 Random Number Generator
driver/char/amd768_pm.c		AMD 762/768 Power Management
drivers/sound/i810_audio.c	AMD 768 AC97 Audio

I was wondering which of this functionality might also exist in the 760MP
chipset (AMD 762 northbridge and AMD 766 southbridge).  According to its
datasheet, the AMD 766 does not have a RNG or AC97 Audio.  But what about
the IRQ Router and Power Management support, should these work on the AMD
766?  If so, should it be possible to support the AMD 766 by just adding
entries to the PCI device tables in each file?

Thanks,
Wayne


