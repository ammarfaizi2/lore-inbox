Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbWGJMpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbWGJMpq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 08:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWGJMpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 08:45:46 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:41659 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S1030351AbWGJMpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 08:45:46 -0400
From: CIJOML <cijoml@volny.cz>
To: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: pcmcia-cs package kills 2.6.18-rc1 kernel?
Date: Mon, 10 Jul 2006 14:22:37 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607101422.37174.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have Acer TravelMate 242 laptop

00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to 
I/O Controller (rev 02)
00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV 
Processor to I/O Controller (rev 02)
00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV 
Processor to I/O Controller (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82852/855GM Integrated 
Graphics Device (rev 02)
00:02.1 Display controller: Intel Corporation 82852/855GM Integrated Graphics 
Device (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #3 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI 
Controller (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 83)
00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface Bridge 
(rev 03)
00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE Controller (rev 
03)
00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus 
Controller (rev 03)
00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 
Modem Controller (rev 03)
02:04.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus Controller 
(rev 01)
02:04.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus Controller 
(rev 01)
02:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)

up to 2.6.16 everythink worked fine for me.

in 2.6.17 uplugging my xi-325 card sometimes killed kernel, but loading 
pcmcia-cs was fine...

in 2.6.18-rc1, only running pcmcia-cs package caused kernel freeze! :(

Any solution? Any workaround?

My distribution is Debian testing

cijoml@notas:~$ dpkg -l |grep pcmc
ii  pcmcia-cs                        3.2.8-8                     PCMCIA Card 
Services for Linux (deprecated)
ii  pcmciautils                      013-2                       PCMCIA 
utilities for Linux 2.6


Thanks a lot for help

Michal

