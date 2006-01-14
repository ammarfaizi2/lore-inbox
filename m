Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWANIVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWANIVx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 03:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWANIVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 03:21:53 -0500
Received: from dd6424.kasserver.com ([83.133.49.41]:47745 "EHLO
	dd6424.kasserver.com") by vger.kernel.org with ESMTP
	id S1751047AbWANIVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 03:21:53 -0500
Message-ID: <43C8B498.8010201@feuerpokemon.de>
Date: Sat, 14 Jan 2006 09:21:44 +0100
From: dragoran <dragoran@feuerpokemon.de>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: marvell lan and hwmon broken on dfi lan party expert
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello!
I bought a new mobo and have to problems with it:
I keep getting such messages in dmesg:
eth1: -- ERROR --
        Class:  internal Software error
        Nr:  0x19e
        Msg:  Vpd: Cannot read VPD keys
looked into the source and found that there is a hack to fix this for 
asus boards. can this be done for this mobo too? if yes which kind of 
info should I provide?
second problem(hwmon):
sensor-detect lets the system look up
modprobe it87 does imeadeatley reboot.
any idea what is causing this?
I am using 2.6.15-1.1824_FC4
lspci:
00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller 
(rev a3)
00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev a2)
00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller 
(rev a3)
00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller 
(rev a3)
00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
01:07.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
01:07.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 0a)
01:09.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 80)
01:0a.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 
Gigabit Ethernet Controller (rev 13)
05:00.0 VGA compatible controller: nVidia Corporation GeForce 7800 GTX 
(rev a1)

PS: please CC me
