Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbSLJUzZ>; Tue, 10 Dec 2002 15:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264795AbSLJUzZ>; Tue, 10 Dec 2002 15:55:25 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:19072 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S264907AbSLJUzW>;
	Tue, 10 Dec 2002 15:55:22 -0500
Date: Tue, 10 Dec 2002 22:03:03 +0100 (CET)
From: Stephan van Hienen <ultra@a2000.nu>
To: sparclinux@vger.kernel.org, "" <linux-kernel@vger.kernel.org>
Subject: Alteon AceNIC Coper Seen as Fibre ? (and incorrect settings)
Message-ID: <Pine.LNX.4.50.0212102157440.1634-100000@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun UltraSparc 10
kernel 2.4.20

eth2: Alteon AceNIC Gigabit Ethernet at 0x1ff02900000, irq 6,7d0
  Tigon II (Rev. 6), Firmware: 12.4.11, MAC: 00:60:cf:20:92:fc
  PCI bus width: 32 bits, speed: 33MHz, latency: 64 clks
eth2: Firmware up and running

unplugging the utp cable, and plugging back in gives :

eth2: 10/100BaseT link UP
eth2: Optical link DOWN
eth2: 10/100BaseT link UP

but this card is not an Fibre (Optical) card ?

also ethtool gives incorrect information :
(ethtool 1.7)
---
Settings for eth2:
        Supported ports: [ FIBRE ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  Not reported
        Advertised auto-negotiation: No
        Speed: 1000Mb/s
        Duplex: Half
        Port: FIBRE
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: off
---

card is connected to 100mbit switch at full duplex
and i think Auto-negotiation is on ?


