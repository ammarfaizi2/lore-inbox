Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbREFCCQ>; Sat, 5 May 2001 22:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130487AbREFCCH>; Sat, 5 May 2001 22:02:07 -0400
Received: from femail14.sdc1.sfba.home.com ([24.0.95.141]:7367 "EHLO
	femail14.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S130485AbREFCBw>; Sat, 5 May 2001 22:01:52 -0400
Date: Sat, 5 May 2001 22:01:50 -0400
From: Tom Vier <tmv5@home.com>
To: linux-kernel@vger.kernel.org
Subject: pci_map_sg() failure on alpha
Message-ID: <20010505220150.A3611@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

has anyone else had problems with pci_map_sg() in 2.4.4-ac*? i get the
message from line 512 in pci_iommu.c, "pci_map_sg failed: could not
allocate dma page tables" printed about 10 times, then a second or two
later, it kills the interrupt handler. it's being called by the sym53c8xx
driver. it's easily reproducible, by bunzip linux.tar.bz | tar x.

this is on a pws 500ua, btw.

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
