Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVBOPFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVBOPFe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 10:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVBOPFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 10:05:33 -0500
Received: from vsmtp3alice.tin.it ([212.216.176.143]:44210 "EHLO vsmtp3.tin.it")
	by vger.kernel.org with ESMTP id S261744AbVBOPFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 10:05:21 -0500
Message-ID: <4212165D.7070105@freemail.it>
Date: Tue, 15 Feb 2005 16:33:49 +0100
From: Paolo <scrooge@freemail.it>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041208)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Nforce2 - usb 2.0 bug
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.
Asking on Irc (thanx riel!), they suggested to write a sort of bug-report.
I'm using a motherboard Asus A7N8X-Deluxe and the usb modules can't work 
with USB 2.0 devices (while 1.1 work with no problems).
The hardware tested is perfectly working on other computers, but with 
this motherboard the devices are recognized but can't be initialized. 
I've tried different distros (Gentoo, Debian & Debian based, Slackware, 
Mandrake ... and even Qnx, FreeBSD).
Usb 2.0 devices can correctly work if the system is booted using 
Windows, then software-rebooted in Linux, otherwise, they can't be 
initialized.
All the modules are correctly loaded. Usually i don't load uhci_hcd but, 
even modprobing it, the results don't change.
Now i'm using a Gentoo with a 2.6.10 kernel release, but i've tried 
different 2.6.x and 2.4.x kernel versions.

My lspci:

*************************************************************************
*************************************************************************

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different 
version?) (r
ev a2)
0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 
(rev a2)
0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 
(rev a2)
0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 
(rev a2)
0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 
(rev a2)
0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 
(rev a2)
0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a3)
0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a3)
0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a3)
0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet 
Controller
 (rev a1)
0000:00:05.0 Multimedia audio controller: nVidia Corporation nForce 
MultiMedia a
udio [Via VT82C686B] (rev a2)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 
AC97 Audio
Controler (MCP) (rev a1)
0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge 
(rev a3)
0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
0000:00:0c.0 PCI bridge: nVidia Corporation nForce2 PCI Bridge (rev a3)
0000:00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire 
(IEEE 139
4) Controller (rev a3)
0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev a2)
0000:01:0b.0 RAID bus controller: Silicon Image, Inc. (formerly CMD 
Technology I
nc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)
0000:02:01.0 Ethernet controller: 3Com Corporation 3C920B-EMB Integrated 
Fast Et
hernet Controller [Tornado] (rev 40)
0000:03:00.0 VGA compatible controller: ATI Technologies Inc R300 AD 
[Radeon 950
0 Pro]
0000:03:00.1 Display controller: ATI Technologies Inc R300 AD [Radeon 
9500 Pro]
(Secondary)

*************************************************************************
*************************************************************************

The problems are the same, using devfs or udev (with or without hotplug 
and coldplug).
The firmware is updated.

Thanks in advance
Paolo
