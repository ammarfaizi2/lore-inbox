Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291323AbSBMDk7>; Tue, 12 Feb 2002 22:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291325AbSBMDkk>; Tue, 12 Feb 2002 22:40:40 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:50444 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id <S291323AbSBMDki>;
	Tue, 12 Feb 2002 22:40:38 -0500
Message-Id: <200202130456.g1D4u5L21909@clueserver.org>
Content-Type: text/plain;
  charset="us-ascii"
From: Alan <alan@clueserver.org>
Reply-To: alan@clueserver.org
To: linux-kernel@vger.kernel.org
Subject: 2.5.4 sound module problem
Date: Tue, 12 Feb 2002 18:22:09 -0800
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I checked the last few days of the kernel list, but did not find this 
problem. (Found the other compile problem (in more ways than one) though.)

Everything seems to compile correctly, but I get the following error message 
on "make modules_install".

depmod: *** Unresolved symbols in 
/lib/modules/2.5.4/kernel/drivers/sound/sound.o
depmod: 	virt_to_bus_not_defined_use_pci_map

Something is not right.  Had not seen that message though...

I get the same error if I build modules for PCMCIA drivers for aerotech cards 
and probably more.

Anyone have a quick idea what is wrong?  I can provide more info if this is 
new. (Which i doubt...)
