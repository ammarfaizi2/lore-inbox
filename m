Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263068AbTDBROk>; Wed, 2 Apr 2003 12:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263069AbTDBROj>; Wed, 2 Apr 2003 12:14:39 -0500
Received: from mail.probe-networks.de ([81.2.144.6]:15115 "HELO
	server3.probe-networks.de") by vger.kernel.org with SMTP
	id <S263068AbTDBROi>; Wed, 2 Apr 2003 12:14:38 -0500
Subject: SiS648 Problems [fixed]
From: Jonas "Frey (Probe Networks)" <jf@probe-networks.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Apr 2003 19:26:03 +0200
Message-Id: <1049304364.16495.201.camel@jonas>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just tried 2.5.66....woohoo...works :)
Looks like its fixed in 2.5 already but not yet on 2.4.
I wont investigate further as i dont have the time :/

Jonas




From: Jonas Frey (Probe Networks) <jf@probe-networks.de>
To: linux-kernel@vger.kernel.org
Subject: SiS648 Problems
Date: 02 Apr 2003 17:02:27 +0200

Hi,

we got some Elitegroup P4S8AG Boards here, featuring SiS648/SiS963
Chipsets. They work fine as far as it comes to the onboard SiS900
onboard lan/network PCI cards.
No matter what kernel version (we tried 2.4.20, 2.4.20-ac2,
2.4.21-pre5-ac3) and no matter what network card (we tried some RealTek
8139C and the onboard card).
Using the onboard card the Kernel reports while trying to ping anything:
eth0: Unknown PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xdc00, IRQ 10, 00:0a:e6:6e:cd:6a.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 00000004 00000249

We tried all possible BIOS settings like PnP OS off/on etc. No go.

Has anyone gotten this board successfully running with the onboard lan?
I have seen these errors on some older boards, an update to the newest
kernel usually fixed them, so i guess its something with the SiS648's
PCIbus not beeing initialized correctly.

Cheers,
Jonas Frey


