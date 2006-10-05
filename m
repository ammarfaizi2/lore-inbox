Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWJEVtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWJEVtI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWJEVtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:49:08 -0400
Received: from smtpserver.visit.se ([85.194.0.110]:23277 "EHLO mail.visit.se")
	by vger.kernel.org with ESMTP id S932254AbWJEVtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:49:03 -0400
Message-ID: <45257DCE.4080801@pelme.se>
Date: Thu, 05 Oct 2006 23:49:02 +0200
From: Andreas Pelme <andreas@pelme.se>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Intel ICH8 + JMicron 363
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am running Abit AB9 Pro with the Intel ICH8 SATA controller and
JMicron JMB363 PATA-controller. Both works very good in 2.6.19-rc1,
running x86_64.

(The PCI-E Realtek R1000 on-board GBIT-NIC works fine now too.)

2.6.19 will be a great release for people with new Intel Core 2 Duo systems.

stenros:~# uname -a
Linux stenros.pelme.se 2.6.19-rc1 #1 SMP Thu Oct 5 20:19:30 CEST 2006
x86_64 GNU/Linux

stenros:~# grep "model name" /proc/cpuinfo
model name      : Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz
model name      : Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz

stenros:~# lspci
00:00.0 Host bridge: Intel Corporation P965/G965 Memory Controller Hub
(rev 02)
00:01.0 PCI bridge: Intel Corporation P965/G965 PCI Express Root Port
(rev 02)
00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
#4 (rev 02)
00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
#5 (rev 02)
00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI
#2 (rev 02)
00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio
Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express
Port 1 (rev 02)
00:1c.2 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express
Port 3 (rev 02)
00:1c.4 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express
Port 5 (rev 02)
00:1c.5 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express
Port 6 (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
#1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
#2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
#3 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI
#1 (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev f2)
00:1f.0 ISA bridge: Intel Corporation 82801HB/HR (ICH8/R) LPC Interface
Controller (rev 02)
00:1f.2 SATA controller: Intel Corporation 82801HB (ICH8) SATA AHCI
Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller
(rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60
[Radeon X300 (PCIE)]
01:00.1 Display controller: ATI Technologies Inc RV370 [Radeon X300SE]
03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 01)
04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 01)
05:00.0 IDE interface: JMicron Technologies, Inc. JMicron 20360/20363
AHCI Controller (rev 02)
05:00.1 IDE interface: JMicron Technologies, Inc. JMicron 20360/20363
AHCI Controller (rev 02)

Thanks a lot!

-- 
Andreas Pelme <andreas@pelme.se>
