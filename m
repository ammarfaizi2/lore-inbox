Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135919AbREDIdn>; Fri, 4 May 2001 04:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135920AbREDIdd>; Fri, 4 May 2001 04:33:33 -0400
Received: from unni.dsv.su.se ([130.237.161.27]:7349 "EHLO unni.dsv.su.se")
	by vger.kernel.org with ESMTP id <S135919AbREDIdW>;
	Fri, 4 May 2001 04:33:22 -0400
Date: Fri, 4 May 2001 10:33:16 +0200 (CEST)
From: Rasmus Gunnar <rasmus-g@dsv.su.se>
To: linux-kernel@vger.kernel.org
Subject: dhcp problem with realtek 8139 clone with rh 7.1
Message-ID: <Pine.LNX.4.21.0105041032020.16928-100000@triton.dsv.su.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have som problem with my realtek 8139 clone. It won't work with dhcp
against my isp. I've just installed redhat 7.1 on a i386 with to (exactly
the same) network cards, one that should be connected to my isp, and one
to
the local network. My local network works fine, but when I try to start
eth0
(which is the card connecting to my isp) I get

Determining IP configuration... Operation failed.
   failed.

If I manually try to run 'pump -i eth0' I also get Operation failed.

If I run 'mii-tool -v eth0' I get

eth0: autonegotiation failed, link ok
  product info: vendor 00:00:00, model 0 rev 0
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD

I've tried using the rtl8139 as well as the 8139too driver shipped with
linux kernel 2.4.4 which I'm using, and I'm trying to connect via a cable
modem.

My dmesg looks a bit strange too, I get som messages several times.

8139too Fast Ethernet driver 0.9.16
eth0: RealTek RTL8139 Fast Ethernet at 0xc4802000, 00:10:a7:08:2c:70, IRQ
11
eth0:  Identified 8139 chip type 'RTL-8139C'
eth1: RealTek RTL8139 Fast Ethernet at 0xc4804000, 00:10:a7:07:fc:83, IRQ
10
eth1:  Identified 8139 chip type 'RTL-8139C'
...
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
eth1: Setting half-duplex based on auto-negotiated partner ability 0000.
IP-Config: Incomplete network configuration information.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding Swap: 265032k swap-space (priority -1)
keyboard: Timeout - AT keyboard not present?
parport0: PC-style at 0x378 [PCSPP(,...)]
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
eth1: Setting 100mbps full-duplex based on auto-negotiated partner ability
41e1.
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.

Is this normal?

Can anybody please help getting the card to work properly?

Rgds,

/Rasmus



- The life which is unexamined is not worth living.
						-Plato

