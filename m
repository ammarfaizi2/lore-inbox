Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263405AbRFTXCb>; Wed, 20 Jun 2001 19:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263160AbRFTXCL>; Wed, 20 Jun 2001 19:02:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43020 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263686AbRFTXCE>; Wed, 20 Jun 2001 19:02:04 -0400
Subject: Re: Unknown PCI Net Device
To: adilger@turbolinux.com (Andreas Dilger)
Date: Thu, 21 Jun 2001 00:00:17 +0100 (BST)
Cc: ingram@symsys.com (Greg Ingram), linux-kernel@vger.kernel.org,
        jgarzik@mandrakesoft.com (Jeff Garzik)
In-Reply-To: <200106202253.f5KMrX2X029668@webber.adilger.int> from "Andreas Dilger" at Jun 20, 2001 04:53:33 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15CqxN-0000IY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 00:0b.0 Ethernet controller: MYSON Technology Inc: Unknown device 0803
> > 	Subsystem: MYSON Technology Inc: Unknown device 0803
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> 
> Add the PCI vendor ID and device ID (0803) to drivers/net/8139too.c, in
> the rtl8139_pci_tbl[] and board_info[] and if it works, send a patch to
> Jeff (CC'd).

The myson is a beastie of its own not afaik a rtl8139 chip. 2.4.x has a
driver for it (fealnx)


