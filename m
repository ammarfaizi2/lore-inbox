Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131386AbRDPM2Y>; Mon, 16 Apr 2001 08:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131407AbRDPM2O>; Mon, 16 Apr 2001 08:28:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3593 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131386AbRDPM2K>; Mon, 16 Apr 2001 08:28:10 -0400
Subject: Athlon problem report summary
To: linux-kernel@vger.kernel.org
Date: Mon, 16 Apr 2001 13:30:14 +0100 (BST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14p894-00009E-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There appear to be two common threads to this

1.  'It runs if I don't use Athlon optimisations'

This one is compiler independant. It seems to be unrelated to obvious 
candidates like vesafb. It isnt related to CPU version. Every victim has a 
VIA chipset machine.


2.  'My athlon box is fine until I am swapping' {and using DMA}

Compiler independant, CPU version independant. All victims have a VIA chipset.
This one may be linked to the reported problems with VIA PCI. Two of the 
reporters found disabling IDE DMA fixed this one


Nobody using an AMD chipset has reported either problem.

