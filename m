Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268027AbTBWEYH>; Sat, 22 Feb 2003 23:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268028AbTBWEYH>; Sat, 22 Feb 2003 23:24:07 -0500
Received: from host-213-178-168-14.dial.netic.de ([213.178.168.14]:3456 "EHLO
	solfire") by vger.kernel.org with ESMTP id <S268027AbTBWEYG>;
	Sat, 22 Feb 2003 23:24:06 -0500
Date: Sun, 23 Feb 2003 05:34:48 +0100 (MET)
Message-Id: <20030223.053448.74752298.mccramer@s.netic.de>
To: linux-kernel@vger.kernel.org
From: Meino Christian Cramer <mccramer@s.netic.de>
In-Reply-To: <1045952406.5685.12.camel@irongate.swansea.linux.org.uk>
References: <1045946551.5484.2.camel@irongate.swansea.linux.org.uk>
	<20030222205438.GA27893@torres.ka0.zugschlus.de>
	<1045952406.5685.12.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mew version 3.1 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Subject: [2.4.20]: IRQ Porbs ?
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 I have some strange problems here:
 My kernel is prompting me with teh following message:

 Feb 23 04:56:19 solfire kernel: PCI: No IRQ known for interrupt pin A
 of device 01:00.0.

 The according device seems to be:
 (cat /proc/pci...)
 
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc Radeon 7500 QW (rev 0).
      Master Capable.  Latency=32.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xe0000000 [0xe7ffffff].
      I/O at 0xa000 [0xa0ff].
      Non-prefetchable 32 bit memory at 0xed000000 [0xed00ffff].
 

 And something, which seems to be of the same kind is a report from
 my XFree86 4.2.99.3-Server:

 (II) RADEON(0): [drm] failure adding irq handler, there is a device
 already using that irq
 [drm] falling back to irq-free operation



 What is going on here ? I checked the BIOS of my motherboard but
 found nothing suspicious.

 My system:
 Radeon 7500 64 MB DDR (Sapphire) on AGP
 Epox 8K5A3+  (VIA KT333)
 Atlon 2400+
 256 MB DDR RAM

 Any help VERY appreciated, since my XFree will not work in
 DRM-mode. Everything is slow motion....

 Thank you very much in advance !
 Keep hacking!
  Meino
 
