Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316882AbSFDWak>; Tue, 4 Jun 2002 18:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316900AbSFDWai>; Tue, 4 Jun 2002 18:30:38 -0400
Received: from kraid.nerim.net ([62.4.16.95]:32013 "HELO kraid.nerim.net")
	by vger.kernel.org with SMTP id <S316882AbSFDWab>;
	Tue, 4 Jun 2002 18:30:31 -0400
Message-ID: <3CFD3F86.7000302@inet6.fr>
Date: Wed, 05 Jun 2002 00:30:30 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nn@broadcom.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: SiS pci target abort?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I'm running a linux 2.4.18 kernel on a PC with SiS glue chip:
 >
 > cubox2.sj.broadcom.com$ lspci
 > 00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 
0650 (rev 01)
 > 00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
 > 00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
 > 00:02.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
 > 00:02.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
 > 00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] 
(rev d0)
 > 00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] 
SiS7012 PCI
 > +Audio Accelerator (rev a0)
 > 00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 
10/100
 > +Ethernet (rev 90)
 > 00:0f.0 Network controller: BROADCOM Corporation: Unknown device 4301
 > 01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]: 
Unknown device
 > +6325
 >
 > Reading a Broadcom device register which returns a pci target abort
 > will return the last value read, the SiS chip actually cycles thru the
 > last 4 recently read values, instead of returning 0xffffffff like all
 > other PC system chips I've ever seen.  Is this a known SiS chip bug?
 >
 > Thanks much for any info you could provide.
 >                 
 > neal nuckolls
 > nn@broadcom.com

Not much info as I don't have the hardware here to reproduce your 
config. From your e-mail address I assume you're developing Linux 
drivers for your network cards or debugging a problem with existing ones.
I took the liberty of forwarding your e-mail to the linux-kernel mailing 
list. If this problem is known there are chances one subscriber is aware 
of it (there are SiS people around here).

LB.

