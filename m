Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264176AbRFMRGv>; Wed, 13 Jun 2001 13:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264183AbRFMRGl>; Wed, 13 Jun 2001 13:06:41 -0400
Received: from dryline-fw.yyz.somanetworks.com ([216.126.67.45]:23080 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S264176AbRFMRGc>; Wed, 13 Jun 2001 13:06:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15143.40342.373565.892231@somanetworks.com>
Date: Wed, 13 Jun 2001 13:06:30 -0400
From: "Georg Nikodym" <georgn@somanetworks.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5-ac13, APM, and Dell Inspiron 8000
X-Mailer: VM 6.90 under 21.2  (beta44) "Thalia" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been running 2.4.5 on my new Dell I8000 without too many
problems.  Last night I built -ac13 (on my porch) and booted it
without incident.  Later, going inside and re-connecting the AC I
notice that the thing's hung.  I play around a bit and discover that
the act of plugging or unplugging the power cord will hang the box.

This lead me to disable all power manglement in the BIOS.  No joy.

This problem does not exist using straight 2.4.5.

Has anybody else seen this?  Any debugging suggestions?  Or stated
differently, has anybody with this machine arrived at a configuration
that avoids weirdness in the power management framework?

In case it's interesting, here's the lspci output:

00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corporation: Unknown device 1131 (rev 02)
00:1e.0 PCI bridge: Intel Corporation: Unknown device 2448 (rev 03)
00:1f.0 ISA bridge: Intel Corporation: Unknown device 244c (rev 03)
00:1f.1 IDE interface: Intel Corporation: Unknown device 244a (rev 03)
00:1f.2 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub A) (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility M4 AGP
02:03.0 Multimedia audio controller: ESS Technology ES1983S Maestro-3i PCI Audio Accelerator (rev 10)
02:06.0 Communication controller: Lucent Microelectronics WinModem 56k (rev 01)
02:0f.0 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller
02:0f.1 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller
02:0f.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8027
03:00.0 Ethernet controller: 3Com Corporation 3CCFE575BT Cyclone CardBus (rev 01)
