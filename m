Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbTKNLAW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 06:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTKNLAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 06:00:22 -0500
Received: from mta.sara.nl ([145.100.16.144]:19881 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id S262337AbTKNLAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 06:00:15 -0500
Message-ID: <3FB4B5B8.9020800@sara.nl>
Date: Fri, 14 Nov 2003 12:00:08 +0100
From: Bas van der Vlies <basv@sara.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9 network problems on some specific hardware
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not subscribed to the list. So send a reply to me and the list.

On our cluster we have 3 different kind of motherboards and we use the 
same kernel on all the nodes. I installed the 2.6-test9 kernel on the
3 different kind of motherboards and in 2 of the cases it works. The
kernel runs and i have network. The other one only the kernel runs
and i have no network. The kernel reports that all kernel interfaces
are up and working, but a ping to another node fails.

We use the same network cards in all the machines, Intel eepro100 with 
PXE. I have tried the drivers Supplied by Intel and Donald Becker.

Here is the hardware of the machinei that does not work:
========================================================
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] 
System Controller (rev 25)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP 
Bridge (rev 01)
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA 
(rev 01)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE 
(rev 03)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI (rev 03)
00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] USB 
(rev 06)
00:08.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
00:0a.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
01:05.0 VGA compatible controller: ATI Technologies Inc 3D Rage LT Pro 
AGP-133 (rev dc)
========================================================================

lspci of the machines that work:
=======================================================================
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] 
(rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] 
(rev 40)
00:09.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 0c)
00:0a.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 0c)
01:00.0 VGA compatible controller: S3 Inc. 86c368 [Trio 3D/2X] (rev 02)
=======================================================================

Next one:
========================================================================
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
KT266/A/333 AGP]
00:0c.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 08)
00:0d.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 08)
00:0e.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet 
Controller (rev 02)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b)
01:00.0 VGA compatible controller: nVidia Corporation NV6 [Vanta/Vanta 
LT] (rev 15)
=========================================================================



-- 
--
********************************************************************
*                                                                  *
*  Bas van der Vlies                     e-mail: basv@sara.nl      *
*  SARA - Academic Computing Services    phone:  +31 20 592 8012   *
*  Kruislaan 415                         fax:    +31 20 6683167    *
*  1098 SJ Amsterdam                                               *
*                                                                  *
********************************************************************


