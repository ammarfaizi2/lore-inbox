Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbRDBQVs>; Mon, 2 Apr 2001 12:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130388AbRDBQVh>; Mon, 2 Apr 2001 12:21:37 -0400
Received: from srvr1.telecom.lt ([212.59.0.10]:59141 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S130038AbRDBQVY>;
	Mon, 2 Apr 2001 12:21:24 -0400
Reply-To: <nerijusb@takas.lt>
From: "Nerijus Baliunas" <nerijus@users.sourceforge.net>
To: "Andre Hedrick" <andre@linux-ide.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Promise 20267 "working" but no UDMA
Date: Mon, 2 Apr 2001 18:20:38 +0200
Message-ID: <MPBBJGBJAHHNDMMBBLMIKELIGLAB.nerijus@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.10.10104020024550.12531-100000@master.linux-ide.org>
X-Mimeole: Produced By Microsoft MimeOLE V5.00.2919.6600
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.

How does MASTER mode differ from PCI?

I have:
PDC20267: IDE controller on PCI bus 00 dev 50
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0xe8000000
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.

Another question - I have Promise Ultra100 and 2 disks:

hda: QUANTUM FIREBALL CX10.2A, 9787MB w/418kB Cache, CHS=19885/16/63, UDMA(33)
hdc: IBM-DTLA-305030, 29314MB w/380kB Cache, CHS=59560/16/63, UDMA(100)

Why Quantum is shown as UDMA 33 when Promise BIOS shows it as UDMA 66?

Why DMA Mode:       UDMA 4 in /proc/ide/pdc202xx for IBM disk?
Shouldn't it be UDMA 5?

Regards,
Nerijus

