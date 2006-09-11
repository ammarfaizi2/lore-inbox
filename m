Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWIKKDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWIKKDo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 06:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWIKKDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 06:03:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:30147 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932200AbWIKJsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 05:48:10 -0400
Date: Mon, 11 Sep 2006 11:48:06 +0200
From: Christian Volk <christian.volk@netcom.eu>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <450530D6.5030300@netcom.eu>
Subject: hangs during boot - EHCI: BIOS handoff failed (BIOS bug ?)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Content-Type: text/plain;
		charset="iso-8859-15";
		format="flowed"
Content-Transfer-Encoding: 7bit
X-AVK-Virus-Check: AVK 16.9620;30FA1
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:b46f439af04e62e38e11eb38595fc2a7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 5-6 seconds delay while booting the 2.6.17.8 Kernel with only 
EHCI support on a Jetway J7F2WE1G5-OC-PB motherboard.
What exactly does the error during bootprocess mean?

Bios
USB 2.0 Support = enabled
USB Device Legacy Support = All On


bootlog
....
0000:00:10.4 EHCI: BIOS handoff
0000:00:10.4 EHCI: BIOS handoff failed (BIOS bug ?) 01010001
....

lspci
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0314
00:00.1 Host bridge: VIA Technologies, Inc.: Unknown device 1314
00:00.2 Host bridge: VIA Technologies, Inc.: Unknown device 2314
00:00.3 Host bridge: VIA Technologies, Inc.: Unknown device 3208
00:00.4 Host bridge: VIA Technologies, Inc.: Unknown device 4314
00:00.7 Host bridge: VIA Technologies, Inc.: Unknown device 7314
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 
Gigabit Ethernet (rev 10)
00:0a.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 80)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 
Gigabit Ethernet (rev 10)
00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 
Gigabit Ethernet (rev 10)
00:0f.0 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge 
[KT600/K8T800 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] 
(rev 78)
01:00.0 VGA compatible controller: VIA Technologies, Inc.: Unknown 
device 3344 (rev 01)

-- 
Christian Volk
christian.volk@netcom.eu

Fon: (+49) 6131-6305 0
Fax: (+49) 6131-6305 40

NETCOM Sicherheitstechnik GmbH
Boppstr. 38
55118 Mainz
http://www.netcom.eu


____________
Virus checked by G DATA AntiVirusKit
Virus news: www.antiviruslab.com


