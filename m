Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266578AbSKGUw0>; Thu, 7 Nov 2002 15:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266579AbSKGUw0>; Thu, 7 Nov 2002 15:52:26 -0500
Received: from smtp.orcon.net.nz ([210.55.12.4]:60569 "EHLO smtp.orcon.net.nz")
	by vger.kernel.org with ESMTP id <S266578AbSKGUwY>;
	Thu, 7 Nov 2002 15:52:24 -0500
Message-ID: <019901c286a0$64ea9620$6df058db@PC2>
From: "Craig Whitmore" <lennon@orcon.net.nz>
To: <linux-kernel@vger.kernel.org>
Subject: ACPI Errors on Intel Server Board SHG2
Date: Fri, 8 Nov 2002 09:58:16 +1300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having troubles with a few errors with ACPI when booting up on a Intel
SHG2 Motherboard (Dual Xeon2.4 with HT) (and SC5200 Chassis)  Are these
becuase its not totally supported yet in Linux?

Thanks
Craig Whitmore
Also someone might want to idenify and put in the kernel the labels for the
unidentified hardware if they can..

00:00.0 Host bridge: ServerWorks: Unknown device 0012 (rev 13)
00:00.1 Host bridge: ServerWorks: Unknown device 0012
00:00.2 Host bridge: ServerWorks: Unknown device 0000
00:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
0d)
00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 05)
00:0f.3 Host bridge: ServerWorks: Unknown device 0225
00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
01:04.0 Ethernet controller: Intel Corp. 82544GC Gigabit Ethernet Controller
(rev 02)
02:08.0 PCI bridge: Distributed Processing Technology PCI Bridge (rev 01)
02:08.1 I2O: Distributed Processing Technology SmartRAID V Controller (rev
01)


----------------------------------------------------------------------------
---


 tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing
Methods:....................................................................
................................................
............................................................................
..........................................
234 Control Methods found and parsed (565 nodes total)
ACPI Namespace successfully loaded at root c0400920
ACPI: Core Subsystem version [20011018]
evxfevnt-0081 [02] Acpi_enable           : Transition to ACPI mode
successful
Executing device _INI
methods:......................................evregion-0302 [21]
Ev_address_space_dispa: Region handler: AE_ER
ROR [PCIConfig]
 dswexec-0392 [12] Ds_exec_end_op        : [LEqual]: Could not resolve
operands, AE_ERROR
Ps_execute: method failed - \_SB_.PCI0.LAN1._STA (f7af43a8)
  uteval-0337 [05] Ut_execute_STA        : _STA on LAN1 failed AE_ERROR
...............
53 Devices found: 52 _STA, 0 _INI
Completing Region and Field initialization:.............
13/19 Regions, 0/0 Fields initialized (565 nodes total)
ACPI: Subsystem enabled
evregion-0302 [20] Ev_address_space_dispa: Region handler: AE_ERROR
[PCIConfig]
 dswexec-0392 [11] Ds_exec_end_op        : [LEqual]: Could not resolve
operands, AE_ERROR
Ps_execute: method failed - \_SB_.PCI0.LAN1._STA (f7af43a8)
  uteval-0337 [04] Ut_execute_STA        : _STA on LAN1 failed AE_ERROR
evregion-0302 [22] Ev_address_space_dispa: Region handler: AE_ERROR
[PCIConfig]
 dswexec-0392 [13] Ds_exec_end_op        : [LEqual]: Could not resolve
operands, AE_ERROR
Ps_execute: method failed - \_SB_.PCI0.LAN1._STA (f7af43a8)
evregion-0302 [25] Ev_address_space_dispa: Region handler: AE_BAD_PARAMETER
[Embedded_control]
Ps_execute: method failed - \_SB_.PCI0.ISA0.EC0_._REG (f7af69a8)
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1
Processor[1]: C0 C1
Processor[2]: C0 C1
Processor[3]: C0 C1
ACPI: Power Button (FF) found
ACPI: Sleep Button (CM) found

