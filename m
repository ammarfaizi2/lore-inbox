Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWBGQdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWBGQdS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 11:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWBGQdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 11:33:18 -0500
Received: from hades.mk.cvut.cz ([147.32.96.3]:64186 "EHLO hades.mk.cvut.cz")
	by vger.kernel.org with ESMTP id S932095AbWBGQdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 11:33:18 -0500
Date: Tue, 7 Feb 2006 17:31:50 +0100
From: Martin Jansa <Martin.Jansa@mk.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: Problems with forcedeth on ASUS A8N-SLI premium
Message-ID: <20060207163150.GA14063@njama.mk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; x-action=pgp-signed
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I have some problems with forcedeth driver on ASUS A8N Premium SLI, and
maybe you can help me.

The card is:
00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d2100000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: I/O ports at b000 [size=8]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

All settings is the same, but with 2.6.15 kernel or 2.6.16-rc1 I always
get this errors when I try to ping the other side..

NETDEV WATCHDOG: eth1: transmit timed out
eth1: Got tx_timeout. irq: 00000000
eth1: Ring at 3c514000: next 63 nic 0
eth1: Dumping tx registers
  0: 00000000 000000ff 00000003 02c603ca 00000000 00000000 00000000 00000000
 20: 06255300 ff701365 00000000 00000000 00000000 00000000 00000000 00000000
 40: 0420e20e 0000a855 00002e20 00000000 00000000 00000000 00000000 00000000
 60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
 80: 003b0f3c 00000001 00000001 007f0088 0000061c 00000001 00000000 00002dad
 a0: 0016070f 00000016 50d41300 0000a89d 00000001 00000000 00000000 00000000
 c0: 10000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001
 e0: 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001
100: 3c514800 3c514000 007f003f 00000000 00010064 00000000 00000011 3c514800
120: 3c5144c0 39276812 a0000210 12414010 8000061c 3c51480c 3c5143ec 00200010
140: 00304120 00002600 00000000 00000000 00000000 00000000 00000000 00000000
160: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
180: 00000006 00000008 0994796d 00008103 00000125 000041e1 0994000d 00000003
1a0: 00000006 00000008 0994796d 00008103 00000125 000041e1 0994000d 00000003
1c0: 00000006 00000008 0994796d 00008103 00000125 000041e1 0994000d 00000003
1e0: 00000006 00000008 0994796d 00008103 00000125 000041e1 0994000d 00000003
200: 00007770 00000000 00000000 00000000 00000000 00000000 00000000 00000000
220: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
240: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
260: 00000000 00000000 fe020001 00000100 00000000 00000000 7e020001 00000100
280: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
2a0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
2c0: 00000000 00000000 00000000 00000000 00000000 00000001 00000001 00000001
2e0: 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001
300: 80210000 00000000 00000000 00000000 00000000 00002000 00000000 00000000
320: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
340: 00000000 00000000 00000000 00000000 00000000 00000000 0a0f25bc 00000000
360: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
380: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3a0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3c0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3e0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
eth1: Dumping tx ring
000: 00000000 3da41812 a000003b // 00000000 3b834c12 a000003b // 00000000 311d0c12 a000003b // 00000000 38201212 a000003b
004: 00000000 1fde5a12 a000003b // 00000000 22e45c12 a000003b // 00000000 373e5a12 a000003b // 00000000 0443f612 a000003b
008: 00000000 04601a12 a000003b // 00000000 0ea9c012 a000003b // 00000000 311d0812 a000003b // 00000000 0443fa12 a000003b
00c: 00000000 396a2212 a000003b // 00000000 396a2012 a000003b // 00000000 1fde5412 a000003b // 00000000 26cfce12 a000003b
010: 00000000 39178612 a000003b // 00000000 05fd4012 a000003b // 00000000 37411c12 a000003b // 00000000 224dc012 a000003b
014: 00000000 2693f812 a000003b // 00000000 0443f012 a000003b // 00000000 3a621e12 a000003b // 00000000 1fde5612 a000003b
018: 00000000 326c5612 a000003b // 00000000 04601212 a000003b // 00000000 05fd4c12 a000003b // 00000000 05fd4e12 a000003b
01c: 00000000 311d0212 a000003b // 00000000 22e45a12 a000003b // 00000000 396a2e12 a000003b // 00000000 39949012 a000003b
020: 00000000 38a59412 a000003b // 00000000 224dc412 a000003b // 00000000 373e5612 a000003b // 00000000 0ba8c612 a000003b
024: 00000000 04601e12 a000003b // 00000000 04601012 a000003b // 00000000 2693f012 a000003b // 00000000 39178a12 a000003b
028: 00000000 36dcee12 a000003b // 00000000 22e45612 a000003b // 00000000 22e45212 a000003b // 00000000 3949a012 a000003b
02c: 00000000 3949a412 a000003b // 00000000 3949aa12 a000003b // 00000000 1ad60812 a000003f // 00000000 311d0012 a000003b
030: 00000000 311d0e12 a000003b // 00000000 3949a812 a000003b // 00000000 3b0ee012 a000003b // 00000000 05fd4412 a000003f
034: 00000000 1eed0c12 a000003b // 00000000 3b0eec12 a000003b // 00000000 1eed0012 a000003f // 00000000 05fd4812 a000003b
038: 00000000 05fd4612 a000003b // 00000000 1eed0212 a000003b // 00000000 3949a212 a000003b // 00000000 1ad60e12 a000003f
03c: 00000000 05fd4a12 a000003b // 00000000 126cbe12 a000003b // 00000000 1eed0e12 a000003b // 00000000 00000000 00000000
nv_stop_tx: TransmitterStatus remained busy<7>eth1: tx_timeout: dead entries!

ethtool and mii tools didn't tell me anything strange ..
# ethtool eth1
Settings for eth1:
        Supported ports: [ MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 9
        Transceiver: external
        Auto-negotiation: on
        Supports Wake-on: g
        Wake-on: d
        Link detected: yes
# mii-diag eth1
SIOCGMIIPHY on eth1 failed: Operation not supported
# mii-tool eth1
SIOCGMIIPHY on 'eth1' failed: Operation not supported

I have tried few versions of forcedeth driver from older 0.41, 0.48 to
0.49.

I have found some similar problems on lkml (about irq, TSO, etc.). 
Maybe problem isn't in forcedeth itself, but suggested kernel params in 
http://lkml.org/lkml/2006/1/21/73
change nothing :(.

My motherboard is ASUS A8N Premium with nforce4 sli

There is dual gbit interface
one is (skge driver) 
05:0c.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller (rev 13)
and second is (forcedeth driver)
00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)

I'm using 802.1d Ethernet Bridging between this 2. Marvell is used for my internet connection and forcedeth is used for connecting my second PC.
But without bridge it's the same error.

my .config is

#
# PHY device support
#
CONFIG_PHYLIB=m

#
# MII PHY device drivers
#
CONFIG_MARVELL_PHY=m
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_CICADA_PHY is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
# CONFIG_TYPHOON is not set

CONFIG_NET_PCI=y
CONFIG_FORCEDETH=m
CONFIG_SKGE=m
CONFIG_SK98LIN=m

In 2.6.14 I have had option
CONFIG_PHYCONTROL=y
which is missing in 2.6.15 and 2.6.16-rc2
maybe this is the problem..

If you have any idea..

Best regards

- -- 
JaMa ~ Jansa Martin          UIN: 136542059        JID: JaMa@jabber.mk.cvut.cz
             You know what the problem with Windows is? 
 You can't compile it from source, and that makes it sooo boooring...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD6Mt1N1Ujt2V2gBwRAj7JAJ4ke8RdKpeNdXXXlgJ6akkrPlmQcQCZAc4O
91TtMyQS8MbNtYmWSY65nO0=
=PXzr
-----END PGP SIGNATURE-----
