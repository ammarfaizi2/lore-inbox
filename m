Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRCKTFI>; Sun, 11 Mar 2001 14:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbRCKTE6>; Sun, 11 Mar 2001 14:04:58 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47117 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129078AbRCKTEq>; Sun, 11 Mar 2001 14:04:46 -0500
Subject: Re: HP Vectra XU 5/90 interrupt problems
To: jw2357@hotmail.com (John William)
Date: Sun, 11 Mar 2001 19:07:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <F61uN6tdqVvPdLFYxc900008c66@hotmail.com> from "John William" at Mar 11, 2001 06:50:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14cBBe-0000VT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> maintainers about the problem. If this isn't ok, then maybe the sanity check 
> in pci-irq.c would be to force level triggering only on shared PCI 
> interrupts?

This seems a sensible path to take for such machines

> I'm going down this path because I can't see a good way to check for the 
> presence of a valid ELCR, so I'm hoping a PCI IRQ sanity check would fix my 
> problem (but someone please correct me if I'm wrong). Are SMP standard type 
> #5 machines (ISA/PCI) or just the Vectra's so rare that I'm the only one 
> having this problem? Or am I the only one to try putting a PCI card in one 
> of it's two slots... :-)

HP/XU boxes have a history of weird (and sometimes invalid) MP tables. In this
case its not clear to me whether HP or the kernel is right (or indeed if both
are right and the standard doesnt help)

