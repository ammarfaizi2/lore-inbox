Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbVKDNhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbVKDNhB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 08:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbVKDNhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 08:37:01 -0500
Received: from 210-194-250-142.rev.home.ne.jp ([210.194.250.142]:10205 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751435AbVKDNhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 08:37:00 -0500
Date: Fri, 04 Nov 2005 22:36:54 +0900 (JST)
Message-Id: <20051104.223654.432830398.whatisthis@jcom.home.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: [x86_64] Freeze using IDE as upper than ATA33
From: Kyuma Ohta <whatisthis@jcom.home.ne.jp>
X-Mailer: Mew version 4.2.53 on Emacs 22.0.50 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm using ASUS Mainboard for Athlon 64 3000+ with VIA K8T800Pro
Host Bridge and VIA VT8237 South Bride for IDE.

I'm running linux-kernel-2.6.14 , when re-constructureing RAID1 
 with two ATA100 Drives (IBM/Hitachi) a, kernel was locked with no 
message.

I tried to be booting with  "ide0=ata66 ide1=ata66", but freezed yet.

I tried  booting with "idebus=33", very stable,not freezed.


Devices are:
--
~$ lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
0000:00:00.1 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
0000:00:00.2 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
0000:00:00.3 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
0000:00:00.4 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
0000:00:00.7 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800/K8T890 South]
0000:00:09.0 Multimedia video controller: Internext Compression Inc iTVC16 (CX23416) MPEG-2 Encoder (rev 01)
0000:00:0a.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller (rev 13)
0000:00:0c.0 Multimedia controller: Philips Semiconductors SAA7134 Video Broadcast Decoder (rev 01)
0000:00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:00:0e.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800/K8T890 South]
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
0000:01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200] (rev a1)
--

Best Regards,
Ohta.
