Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318302AbSHUOMo>; Wed, 21 Aug 2002 10:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318305AbSHUOMo>; Wed, 21 Aug 2002 10:12:44 -0400
Received: from angband.namesys.com ([212.16.7.85]:1920 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S318302AbSHUOMn>; Wed, 21 Aug 2002 10:12:43 -0400
Date: Wed, 21 Aug 2002 18:16:45 +0400
From: Oleg Drokin <green@namesys.com>
To: linux-kernel@vger.kernel.org
Cc: jhartmann@precisioninsight.com
Subject: agpgart support for AMD 765 support broken in 2.4.20-pre4?
Message-ID: <20020821181645.A827@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   I found that I cannot boot into 2.4.20-pre4 if I have CONFIG_AGP_AMD set
   kernel's agpgart driver displays that it have found AMD-765 and 
   reboots. Next reboot into any kernel is also failed with
   APIC 08 error on CPU0 (continuously scrolled over the screen until I press
   reset).
   I have dual athlon box with Tiyan tiger motherboard.
# lspci
00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-765 [Viper] ISA (rev 02)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-765 [Viper] IDE (rev 01)00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-765 [Viper] ACPI (rev 01)
00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-765 [Viper] USB (rev 07)
00:0a.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 05)00:0c.0 Multimedia audio controller: Yamaha Corporation YMF-724F [DS-1 Audio Controller] (rev 03)
01:05.0 VGA compatible controller: nVidia Corporation: Unknown device 0200 (rev
a3)

   Is this known issue, is anybody interested in that?

Bye,
    Oleg

