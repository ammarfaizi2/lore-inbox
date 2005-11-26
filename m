Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVKZUxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVKZUxf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 15:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVKZUxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 15:53:35 -0500
Received: from smtp6.wanadoo.fr ([193.252.22.25]:30520 "EHLO smtp6.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1750747AbVKZUxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 15:53:34 -0500
X-ME-UUID: 20051126205327619.9721C1C000A5@mwinf0602.wanadoo.fr
Subject: Re: x86_64: Test patch for ATI/Nvidia timer problems
From: Olivier Fourdan <fourdan@xfce.org>
To: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Content-Type: multipart/mixed; boundary="=-7C3POlaw/Y1qFUsMW7bP"
Organization: http://www.xfce.org
Date: Sat, 26 Nov 2005 21:53:36 +0100
Message-Id: <1133038416.6253.5.camel@shuttle>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7C3POlaw/Y1qFUsMW7bP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

> Everybody who saw timing problems with ATI IXP based boards with x86-64 
> or some Nvidia NForce4 boards please test this patch. Please send 
> success/failure to me.

I've applied the patch on a clean 2.6.15-rc2 source tree, built it, and rebooted with high hopes...

Unfortunately, it makes no difference here (HP/Compaq R3200 laptop, AMD64 3400+, nforce3).

Bootlog available on demand.

Regards,
Olivier.

--=-7C3POlaw/Y1qFUsMW7bP
Content-Disposition: attachment; filename=lspci.txt
Content-Type: text/plain; name=lspci.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

0000:00:00.0 Host bridge: nVidia Corporation nForce3 Host Bridge (rev a4)
0000:00:01.0 ISA bridge: nVidia Corporation nForce3 LPC Bridge (rev a6)
0000:00:01.1 SMBus: nVidia Corporation nForce3 SMBus (rev a4)
0000:00:02.0 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5)
0000:00:02.1 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5)
0000:00:02.2 USB Controller: nVidia Corporation nForce3 USB 2.0 (rev a2)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce3 Audio (rev a2)
0000:00:06.1 Modem: nVidia Corporation: Unknown device 00d9 (rev a2)
0000:00:08.0 IDE interface: nVidia Corporation nForce3 IDE (rev a5)
0000:00:0a.0 PCI bridge: nVidia Corporation nForce3 PCI Bridge (rev a2)
0000:00:0b.0 PCI bridge: nVidia Corporation nForce3 AGP Bridge (rev a4)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 440 Go 64M] (rev a3)
0000:02:00.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link)
0000:02:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:02:02.0 Network controller: Broadcom Corporation BCM4306 802.11b/g Wireless LAN Controller (rev 03)
0000:02:04.0 CardBus bridge: Texas Instruments: Unknown device ac54 (rev 01)
0000:02:04.1 CardBus bridge: Texas Instruments: Unknown device ac54 (rev 01)
0000:02:04.2 System peripheral: Texas Instruments: Unknown device 8201 (rev 01)

--=-7C3POlaw/Y1qFUsMW7bP
Content-Disposition: attachment; filename=cpuinfo.txt
Content-Type: text/plain; name=cpuinfo.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 4
model name	: AMD Athlon(tm) 64 Processor 3400+
stepping	: 10
cpu MHz		: 797.451
cache size	: 1024 KB
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips	: 1596.11
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp


--=-7C3POlaw/Y1qFUsMW7bP--


