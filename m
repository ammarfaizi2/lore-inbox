Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266442AbRGCGCI>; Tue, 3 Jul 2001 02:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266446AbRGCGB7>; Tue, 3 Jul 2001 02:01:59 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:1242 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S266442AbRGCGBj>; Tue, 3 Jul 2001 02:01:39 -0400
From: mdaljeet@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA256A7E.0020F52C.00@d73mta01.au.ibm.com>
Date: Tue, 3 Jul 2001 11:27:56 +0530
Subject: virt_to_bus and virt_to_phys on Apple G4 target
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running linux 2.4.2 on Apple G4 machine. I think the 'PCI bus
addresses' and 'physical addresses' are same on this architecture. I
expected the two be different but according to asm/io.h 'virt_to_bus(addr)
= virt_to_phys(addr) + PCI_DRAM_OFFSET'. I printed the value of
'PCI_DRAM_OFFSET' and that come out to be zero. Is this correct?

If I somehow get the physical address of a user space buffer in a module
and take this as a PCI bus address, will I be able to do DMA properly?

thanks,
Daljeet.


