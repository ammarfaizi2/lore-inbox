Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUAJCWH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 21:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbUAJCWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 21:22:07 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:51663 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263893AbUAJCWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 21:22:05 -0500
Date: Sat, 10 Jan 2004 03:22:02 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Adam Belay <ambx1@neo.rr.com>, Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: What exactly is __ALIGN_STR in pnpbios/bioscalls.c for?
Message-ID: <20040110022202.GM25089@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

include/linux/linkage.h in kernel 2.6 includes #define's for __ALIGN and 
__ALIGN_STR. In include/asm-i386/linkage.h, their values are changed 
#ifdef CONFIG_X86_ALIGNMENT_16.

It isn't obvious what exacly CONFIG_X86_ALIGNMENT_16 is for (I've heard 
more than one opinion), and since the __ALIGN_STR usage in 
drivers/pnp/pnpbios/bioscalls.c is the only non-m68k usage of one of 
these two #define's I wonder whether you might be able to enlighten me 
what CONFIG_X86_ALIGNMENT_16 exactly is for?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

