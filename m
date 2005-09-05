Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbVIEBtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVIEBtD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 21:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVIEBtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 21:49:03 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:42909
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S932161AbVIEBtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 21:49:01 -0400
Subject: Re: Brand-new notebook useless with Linux...
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Reply-To: abonilla@linuxwireless.org
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200509031859_MC3-1-A720-F705@compuserve.com>
References: <200509031859_MC3-1-A720-F705@compuserve.com>
Content-Type: text/plain
Date: Sun, 04 Sep 2005 19:49:13 -0600
Message-Id: <1125884953.4947.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-09-03 at 18:58 -0400, Chuck Ebbert wrote:
> I just bought a new notebook.  Here is the output from lspci using the latest
> pci.ids file from sourceforge:
> 
> 00:00.0 Host bridge: ATI Technologies Inc RS480 Host Bridge (rev 01)
> 00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 5a3f
> 00:13.0 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
> 00:13.1 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
> 00:13.2 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host Controller
> 00:14.0 SMBus: ATI Technologies Inc IXP SB400 SMBus Controller (rev 11)
> 00:14.1 IDE interface: ATI Technologies Inc Standard Dual Channel PCI IDE Controller ATI
> 00:14.3 ISA bridge: ATI Technologies Inc IXP SB400 PCI-ISA Bridge
> 00:14.4 PCI bridge: ATI Technologies Inc IXP SB400 PCI-PCI Bridge
> 00:14.5 Multimedia audio controller: ATI Technologies Inc IXP SB400 AC'97 Audio Controller (rev 02)
This is an ac97, try the intel sound driver.
> 00:14.6 Modem: ATI Technologies Inc: Unknown device 4378 (rev 02)
No Way.
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
> 01:05.0 VGA compatible controller: ATI Technologies Inc ATI Radeon XPRESS 200M 5955 (PCIE)
> 05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
Should work.
> 05:02.0 Network controller: Broadcom Corporation BCM4318 [AirForce One 54g] 802.11g Wireless LAN Controller (rev 02)
linuxant.com or ndiswrapper. I believe they do not have a driver for
Linux.
> 05:09.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
> 05:09.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE 1394 Host Controller
> 05:09.3 Mass storage controller: Texas Instruments PCIxx21 Integrated FlashMedia Controller
> 05:09.4 Class 0805: Texas Instruments PCI6411, PCI6421, PCI6611, PCI6621, PCI7411, PCI7421, PCI7611, PCI7621 Secure Digital (SD) Controller
> 
> None of these work and I can find no support anywhere for them:
> 
> SMBus
> Audio ("unknown codec")
> Modem ("no codec available")
> Wireless
> FlashMedia
Doubt it.
> SD/MMC
Doubt it.
> 
> Additionally, the system clock runs at 2x normal speed with PowerNow enabled.
Most likely an ACPI or Windowish ACPI with your laptop.

You are not even saying which laptop you are with. Check google and the
linux on laptops website.

.Alejandro

> 
> Am I stuck with running XP on this thing?
> 
> __
> Chuck
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

