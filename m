Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318370AbSGRWyQ>; Thu, 18 Jul 2002 18:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318375AbSGRWyQ>; Thu, 18 Jul 2002 18:54:16 -0400
Received: from nextgeneration.speedroad.net ([195.139.232.50]:29579 "HELO
	nextgeneration.speedroad.net") by vger.kernel.org with SMTP
	id <S318370AbSGRWyP>; Thu, 18 Jul 2002 18:54:15 -0400
Message-ID: <20020718225716.491.qmail@nextgeneration.speedroad.net>
From: "Arnvid Karstad" <arnvid@karstad.org>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: kernel 2.4.18-rc1-ac6 - dmesg errors?!
Date: Fri, 19 Jul 2002 00:57:16 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya, 

Upgrade my laptop to use 2.4.18-rc1-ac6, and I noticed it had support for 
more of my hardware. But it seems it also get's these "errors" in dmesg... 

1)  Prism2 - used to use the Wlan-NG drivers but since the rc/ac kernel has 
this included I decided to test it 

orinoco.c 0.11b (David Gibson <hermes@gibson.dropbear.id.au> and others)
PCI: Found IRQ 9 for device 02:02.0
PCI: Sharing IRQ 9 with 00:1d.2
PCI: Sharing IRQ 9 with 00:1f.1
Detected Orinoco/Prism2 PCI device at 02:02.0, mem:0xEC000000 to 0xEC000FFF 
 -> 0xe978e000, irq:9
Reset 
done........................................................................ 
............................................................
............................................................................ 
...................................;
Clear Reset
pci_cor : reg = 0x0 - 8F4B - 8F19
eth1: Station identity 001f:0006:0001:0003
eth1: Looks like an Intersil firmware version 1.03
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:20:E0:8A:FC:BE
eth1: Station name "Prism  I"
eth1: ready 

I'm getting this message every now and then.. 

Jul 19 00:50:04 mgr kernel: eth1: Undersized frame received (19 bytes)
Jul 19 00:51:05 mgr last message repeated 2 times
Jul 19 00:51:26 mgr kernel: eth1: Undersized frame received (12 bytes)
Jul 19 00:51:36 mgr kernel: eth1: Undersized frame received (19 bytes) 

The connection works, but these packages are a bit strange even tho ;) 

The AP is an AiroNet AP 3400. 

2) 2.4.18+* works great in console mode. 

but when ever I get into X my logs get filled with :
mtrr: no more MTRRs available
mtrr: no more MTRRs available
mtrr: no more MTRRs available
mtrr: no more MTRRs available 

Is there any way to battle this? 


On the brighter side of life.. 2.4.18-rc1-ac6 seems to be recognizing my 
hardware better than the 2.4.18-vanilla kernel. Now my cpu is detected 
correctly instead of being a 733MHZ.. 

Best regards 

Arnvid
