Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVDBTZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVDBTZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 14:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVDBTZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 14:25:59 -0500
Received: from weber.sscnet.ucla.edu ([128.97.42.3]:23468 "EHLO
	weber.sscnet.ucla.edu") by vger.kernel.org with ESMTP
	id S261187AbVDBTZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 14:25:50 -0500
Message-ID: <424EF19B.7030105@cogweb.net>
Date: Sat, 02 Apr 2005 11:25:15 -0800
From: David Liontooth <liontooth@cogweb.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: venza@brownhat.org, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: ICS1883 LAN PHY not detected
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gigabyte's K8NS Ultra-939 mobo has a 100/10 LAN PHY chip, ICS1883, which
isn't detected by the 2.6.12-rc1 kernel (and likely not previous kernels).

http://www.giga-byte.com/MotherBoard/Products/Products_Spec_GA-K8NS%20Ultra-939.htm

On the other hand, the ports light up when connected.

The device may be similar to ICS1893, which is supported by the sis900 
driver.
However, I figure the device first has to be detected?

Any advice appreciated. 

Dave



# lspci
0000:00:00.0 Host bridge: nVidia Corporation: Unknown device 00e1 (rev a1)
0000:00:01.0 ISA bridge: nVidia Corporation: Unknown device 00e0 (rev a2)
0000:00:01.1 SMBus: nVidia Corporation: Unknown device 00e4 (rev a1)
0000:00:02.0 USB Controller: nVidia Corporation: Unknown device 00e7 
(rev a1)
0000:00:02.1 USB Controller: nVidia Corporation: Unknown device 00e7 
(rev a1)
0000:00:02.2 USB Controller: nVidia Corporation: Unknown device 00e8 
(rev a2)
0000:00:05.0 Bridge: nVidia Corporation: Unknown device 00df (rev a2)
0000:00:06.0 Multimedia audio controller: nVidia Corporation: Unknown 
device 00ea (rev a1)
0000:00:08.0 IDE interface: nVidia Corporation: Unknown device 00e5 (rev a2)
0000:00:0a.0 IDE interface: nVidia Corporation: Unknown device 00e3 (rev a2)
0000:00:0b.0 PCI bridge: nVidia Corporation: Unknown device 00e2 (rev a2)
0000:00:0e.0 PCI bridge: nVidia Corporation: Unknown device 00ed (rev a2)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:02:0b.0 Ethernet controller: Marvell Technology Group Ltd. Yukon 
Gigabit Ethernet 10/100/1000Base-T Adapter (rev 13)
0000:02:0d.0 Unknown mass storage controller: Silicon Image, Inc. 
(formerly CMD Technology Inc)SiI 3512 [SATALink/SATARaid] Serial ATA 
Controller (rev 01)
0000:02:0e.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b 
Link Layer Controller (rev 01)

