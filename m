Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbUKUR5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbUKUR5E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 12:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUKUR5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 12:57:03 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33802 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261733AbUKUR5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 12:57:00 -0500
Date: Sun, 21 Nov 2004 18:56:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Adam Belay <ambx1@neo.rr.com>, Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: What exactly is __ALIGN_STR in pnpbios/bioscalls.c for?
Message-ID: <20041121175659.GD2924@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
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
