Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVGBUrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVGBUrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 16:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVGBUrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 16:47:09 -0400
Received: from unknown.ghostnet.de ([217.69.161.74]:30874 "EHLO nexave.de")
	by vger.kernel.org with ESMTP id S261278AbVGBUrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 16:47:02 -0400
Message-ID: <42C6FD00.2060408@cyberoptic.de>
Date: Sat, 02 Jul 2005 22:45:52 +0200
From: CyberOptic <mail@cyberoptic.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ppa / parport zip-drive / kernel 2.6.12.2
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Scanner: exiscan *1Doot1-00049x-00*OXnlFRuuOYU*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wanted to activate my old dust-covered IOmega ZIP-Drive 100MB (PPA),
but didn´t get it working (see dmesg-extract). Sadly, google could not
help me in my case.
Therefore my decision to ask the good people at this newsgroup  :-)

---dmesg---
pnp: Device 00:0a activated.
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
SCSI subsystem initialized
ppa: Version 2.07 (for Linux 2.4.x)
ppa: Found device at ID 6, Attempting to use EPP 32 bit
ppa: Found device at ID 6, Attempting to use PS/2
ppa: Communication established with ID 6 using PS/2
scsi0 : Iomega VPI0 (ppa) interface
scsi: Device offlined - not ready after error recovery: host 0 channel 0
id 6 lun 0

---lsmod---
Module                  Size  Used by
parport_pc             41540  0
ppa                    12808  0
scsi_mod              137672  1 ppa
parport                37448  2 parport_pc,ppa


Things I´ve already tried:

- BIOS Settings switched to SPP, EPP, ECP, ECP/EPP
- Reconnected the cabling
- Rebooted with ZIP-Drive a) connected and powered b) disconnected
- Loaded modules with both disk inserted and ejected
- Tried kernel-settings CONFIG_SCSI_IZIP_EPP16 and
  CONFIG_SCSI_IZIP_SLOW_CTR

Other Information:

- Mainboard: VIA Apollo CLE266 (EPIA M10000 with VIA C3 1GHz CPU)
- Drive works with Windows 2000 on the same machine
- No printer connected to the ZIP-Drive
- Linux second 2.6.12.2 #3 Sat Jul 2 20:51:04 CEST 2005 i686 GNU/Linux

Surely there is someone out there knowing a hint or solution? At least
I´m hoping so.


Thanks in advance - Sebastian




