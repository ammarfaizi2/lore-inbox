Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264584AbTKNUIo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 15:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264586AbTKNUIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 15:08:43 -0500
Received: from viefep15-int.chello.at ([213.46.255.19]:51552 "EHLO
	viefep15-int.chello.at") by vger.kernel.org with ESMTP
	id S264584AbTKNUIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 15:08:36 -0500
From: Krisztian Mark Szentes <office@produktivIT.com>
Organization: produktivIT - Open Source Solution Provider
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: great AGP related stability achievements with 2.6.0 vs. 2.4.18+
Date: Fri, 14 Nov 2003 21:06:47 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311142106.47683.office@produktivIT.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I want to congratulate whoever is involved...

I use the relatively new Asus A7N8X mainboard (based on the nVidia nForce2 
chipset) and nVidia based AGP graphics card.

With this setup and plain Debian "unstable" 2.4.18 up to 2.4.22 kernels, 
this machine got locked up at least once a day, in a seamingly random way. 
Lowering memory or CPU frequency in BIOS from default to more generous 
levels improved stability somewhat, but it still remained at intolerable 
levels. (With lock up I mean not even Magic SysRq works.) 

Changing the graphics card from AGP to PCI (to Matrox) solved the issue 
with kernel 2.4.18+ but I wanted to have an AGP card. Other AGP cards 
caused problems too (TNT2), although they proved less unstable (1 crash in 
2-3 days). This also helped to exclude other issues such as IDE DMA or bad 
memory from consideration (I checked the hardware thoroughly).

Kernel 2.6.0 hasn't crashed on me once for weeks, although I use exactly 
the same hardware now (see below). It is just stable. 

I do not load the agpgart and related modules, but I didn't load them with 
2.4.18-2.4.22 either.



# lspci
00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) 
(rev c1)
00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller 
(rev a1)
00:05.0 Multimedia audio controller: nVidia Corporation nForce MultiMedia 
audio [Via VT82C686B] (rev a2)
00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio 
Controler (MCP) (rev a1)
00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:0c.0 PCI bridge: nVidia Corporation nForce2 PCI Bridge (rev a3)
00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE 
1394) Controller (rev a3)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
01:0a.0 USB Controller: VIA Technologies, Inc. USB (rev 04)
01:0b.0 RAID bus controller: CMD Technology Inc Silicon Image SiI 3112 
SATARaid Controller (rev 02)
02:01.0 Ethernet controller: 3Com Corporation 3C920B-EMB Integrated Fast 
Ethernet Controller (rev 40)
03:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 
400] (rev b2)

Thanks!

Salut

Mark

-- 
Krisztian Mark Szentes
produktivIT   -  Open-Source Solution Provider
Siebenbrunnengasse 55/7
A-1050 Wien
http://www.produktivit.com

