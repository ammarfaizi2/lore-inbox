Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263054AbTJEJw2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 05:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbTJEJw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 05:52:28 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:1408 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S263054AbTJEJw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 05:52:27 -0400
Subject: SiI3112 DMA? (2.6.0-test6)
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1065347429.1441.17.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Sun, 05 Oct 2003 11:50:29 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am currently running 2.6.0-test6 on an old PII which has a SiI3112
SATA PCI card in one of its PCI slots. It seems that the SiI3112 is not
using DMA so now it is even running slower then the onboard PIIX4 IDE
controller.

Is DMA supported on the Si3112? DMA is not being enabled by the SiI3112
card's BIOS (this is a cheap PCI card):

SiI3112 Serial ATA: IDE controller at PCI slot 0000:00:0b.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: 100% native mode on irq 11
    ide2: MMIO-DMA at 0xd8807000-0xd8807007, BIOS settings: hde:pio,
hdf:pio
    ide3: MMIO-DMA at 0xd8807008-0xd880700f, BIOS settings: hdg:pio,
hdh:pio
hde: ST3120026AS, ATA DISK drive
ide2 at 0xd8807080-0xd8807087,0xd880708a on irq 11

Greetings,

Jurgen

