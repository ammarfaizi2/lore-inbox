Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270556AbTGNHLZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 03:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270558AbTGNHLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 03:11:25 -0400
Received: from greenie.frogspace.net ([64.6.248.2]:13960 "EHLO
	greenie.frogspace.net") by vger.kernel.org with ESMTP
	id S270556AbTGNHLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 03:11:15 -0400
Date: Mon, 14 Jul 2003 00:26:02 -0700 (PDT)
From: Peter <cogwepeter@cogweb.net>
X-X-Sender: cogwepeter@greenie.frogspace.net
To: linux-kernel@vger.kernel.org
Subject: Linux v2.6.0-test1
In-Reply-To: <Pine.LNX.4.44.0305221240040.15298-100000@greenie.frogspace.net>
Message-ID: <Pine.LNX.4.44.0307140015390.9819-100000@greenie.frogspace.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The kernel compiled with no errors. On booting, I got this:

ACPI: Subsystem revision 20030619
ACPI breakpoint: Executed AML Breakpoint opcode

If I just wanted to boot, which option should I disable?

This is a vpr matrix 200a5 laptop with an ALi M1671 chipset and various 
ACPI options enabled, including CONFIG_X86_P4_CLOCKMOD=m. Details below.

2.5.69 has been running fine for a long time now, but there are some new 
ACPI options. 

Cheers,
Peter


System:

00:00.0 Host bridge: ALi Corporation M1671 Super P4 Northbridge [AGP4X,PCI and SDR/DDR] (rev 02)
00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:09.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan chipset (rev 01)
00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
00:0b.0 USB Controller: VIA Technologies, Inc. USB (rev 50)
00:0b.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
00:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
00:11.0 Bridge: ALi Corporation M7101 PMU
00:12.0 Ethernet controller: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 420 Go 32M] (rev a3)


Configuration:

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_PROC_INTF is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_24_API is not set
CONFIG_CPU_FREQ_TABLE=y

#
# CPUFreq processor drivers
#
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set



