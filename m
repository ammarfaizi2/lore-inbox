Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbUCOUQT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 15:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbUCOUQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 15:16:19 -0500
Received: from ns.suse.de ([195.135.220.2]:53947 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262739AbUCOUQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 15:16:18 -0500
Date: Mon, 15 Mar 2004 21:16:16 +0100
From: Olaf Hering <olh@suse.de>
To: "David S. Miller" <davem@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: consistent_sync_for_cpu() and friends on ppc32
Message-ID: <20040315201616.GA31268@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David, 

what is the fix for ppc32? This patch went into Linus tree:
people/akpm/patches/2.6/2.6.4/2.6.4-mm1/broken-out/dma_sync_for_device-cpu.patch

In file included from include/linux/pci.h:720,
                 from drivers/net/sunhme.c:62:
include/asm/pci.h: In function `pci_dma_sync_single_for_cpu':
include/asm/pci.h:203: warning: implicit declaration of function `consistent_sync_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_single_for_device':
include/asm/pci.h:212: warning: implicit declaration of function `consistent_sync_for_device'
include/asm/pci.h: In function `pci_dma_sync_sg_for_cpu':
include/asm/pci.h:230: warning: implicit declaration of function `consistent_sync_page_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_sg_for_device':
include/asm/pci.h:243: warning: implicit declaration of function `consistent_sync_page_for_device'


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
