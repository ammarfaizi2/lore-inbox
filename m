Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbTAIBa3>; Wed, 8 Jan 2003 20:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbTAIBa3>; Wed, 8 Jan 2003 20:30:29 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:25030 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261302AbTAIBa1>; Wed, 8 Jan 2003 20:30:27 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200301090139.h091d9G26412@devserv.devel.redhat.com>
Subject: Linux 2.4.21pre3-ac2
To: linux-kernel@vger.kernel.org
Date: Wed, 8 Jan 2003 20:39:09 -0500 (EST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The skb_padto bug is quite ugly so people really want to be using ac2 not
ac1. 

Linux 2.4.21pre3-ac2
o	Fix the dumb bug in skb_pad			(Dave Miller)
o	Confirm some sparc bits are wrong and drop them	(Dave Miller)
o	Remove a wrong additional copyright comment	(Dave Miller)
o	Upgrade IPMI driver to v16			(Corey Minyard)
o	Fix 3c523 compile				(Francois Romieu)
o	Handle newer rpm where -ta is rpmbuild not rpm	(me)
o	Driver for Aurora Sio16 PCI adapter series	(Joachim Martillo)
	(SIO8000P, 16000P, and CPCI)
	| Initial merge
o	Backport Hammer 32bit mtrr/nmi changes		(Andi Kleen)
o	Add the fast IRQ path to via 8233/5 audio	(me)

Linux 2.4.21pre3-ac1
+	Handle battery quirk on the Vaio Z600-RE	(Paul Mitcheson)
*	EHCI USB updates				(David Brownell)
+	IDE Raid support for AMI/SI 'Medley' IDE Raid	(Arjan van de Ven)
+	NVIDIA nForce2 IDE PCI identifiers		(Johannes Deisenhofer,
							 Tim Krieglstein)
*	CPU bitmask truncation fix			(Bjorn Helgaas)
o	HP100 cleanup					(Pavel Machek)
o	Fix initial capslock handling on USB keyboard	(Pete Zaitcev)
+	Update dscc4 driver for new wan			(Francois Romieu)
+	Fix boot on Chaintech 4BEA/4BEA-R and		(Alexander Achenbach)
	Gigabyte 9EJL by handing wacky E820 memory
	reporting
o	SysKonnect driver updates			(Mirko Lindner)
o	Fix memory leak in n_hdlc			(Paul Fulghum)
o	Fix missing mtd dependancy			(Herbert Xu)
+	Clean up ide-tape printk stuff			(Pete Zaitcev)
+	IDE tape fixes					(Pete Zaitcev)
o	Fix size reporting of large disks in scsi	(Andries Brouwer)
+	Fix excessive stack usage in NMI handlers	(Mikael Pettersson)
+	Add support for Epson 785EPX USB printer pcmcia	(Khalid Aziz)
*	Quirk handler to sort out IDE compatibility	(Ivan Kokshaysky)
	mishandling
+	Model 1 is valid for PIV in MP table		(Egenera)
+	Ethernet padding fixes for various drivers	(me)
o	Allow trident codec setup to time out		(Ian Soboroff)
	This can happen with non PM codecs
o	Fix broken documentation link			(Henning Meier-Geinitz)
o	Update video4linux docbook			(William Stimson)
o	Correct kmalloc check in dpt_i2o		(Pablo Menichini)
o	Shrink kmap area to required space only		(Manfred Spraul)
o	Fix irq balancing				(Ben LaHaise)
o	CPUfreq updates					(Dominik Brodowski)
o	Fix typo in pmagb fb				(John Bradford)
o	EDD backport					(Matt Domsch)


REMOVED FOR NOW

-	RMAP

REMOVED FOR GOOD

-	LLC 	(See 2.5)
-	VaryIO  (Never accepted mainstream)
