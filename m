Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbTDBTgN>; Wed, 2 Apr 2003 14:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261453AbTDBTgN>; Wed, 2 Apr 2003 14:36:13 -0500
Received: from cmail-2.worldonline.co.za ([196.41.128.92]:59348 "EHLO
	cmail-2.worldonline.co.za") by vger.kernel.org with ESMTP
	id <S261449AbTDBTgM>; Wed, 2 Apr 2003 14:36:12 -0500
Subject: cpufreq not supported on ALi / ATI chipset
From: Gerassimo Tselentis <g_tselentis@worldonline.co.za>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1049312788.2048.51.camel@goku.asylum>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk 
Date: 02 Apr 2003 21:46:30 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I see someone posted a message about cpufreq not being supported on an
Intel 440BX motherboard so I thought I'd post mine too. I have a Compaq
Evo N1050v laptop with a combination of ALi and ATI bridges. It has an
Intel Pentium 4-M 1.8GHz I'm not sure which is which, but here is an
lspci :

00:00.0 Host bridge: ATI Technologies Inc: Unknown device cab2 (rev 02)
00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 7010
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link
Controller Audio Device (rev 02)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:08.0 Modem: ALi Corporation Intel 537 [M5457 AC-Link Modem]
00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
00:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21
IEEE-1394a-2000 Controller (PHY/Link)
00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
00:11.0 Bridge: ALi Corporation M7101 PMU
00:12.0 Ethernet controller: National Semiconductor Corporation DP83815
(MacPhyter) Ethernet Controller
01:05.0 VGA compatible controller: ATI Technologies Inc Radeon IGP 340M

Also, here is the relevant dmesg output :

...
cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.7.2.6 $
cpufreq: Intel(R) SpeedStep(TM) for this processor not (yet) available.
...

I've also tried the 2.5.65 kernel release. The above was from a
2.4.21-0.13mdk kernel. The ATI bridge itself is not supported, as I
gathered, so maybe that's why and maybe I should rather address this
email to a different development group instead of cpufreq. I'd gladly
provide more verbose info if wanted.

Regards,
G. Tselentis


