Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbQKPIbc>; Thu, 16 Nov 2000 03:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129636AbQKPIbX>; Thu, 16 Nov 2000 03:31:23 -0500
Received: from 24.68.3.210.on.wave.home.com ([24.68.3.210]:28152 "EHLO
	phlegmish.com") by vger.kernel.org with ESMTP id <S129112AbQKPIbL>;
	Thu, 16 Nov 2000 03:31:11 -0500
From: David Won <phlegm@home.com>
Date: Thu, 16 Nov 2000 02:56:50 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: Gregory Maxwell <greg@linuxpower.cx>, linux-kernel@vger.kernel.org
To: "Arnaud S . Launay" <asl@launay.org>
In-Reply-To: <00111214191100.01043@phlegmish.com> <00111307592400.01166@phlegmish.com> <20001113162205.A30602@profile4u.com>
In-Reply-To: <20001113162205.A30602@profile4u.com>
Subject: Re: Newby help. Tons and tons of Oops
MIME-Version: 1.0
Message-Id: <00111602565000.00835@phlegmish.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to track down a hardware conflict since the memtest went fine. Does 
this look normal or can you recommend a place where I can get help tracking 
this down? Is it normal to have so many devices on IRQ 9?

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 3).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 3).
      Master Capable.  Latency=64.  Min Gnt=136.
  Bus  0, device   4, function  0:
    ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 2).
  Bus  0, device   4, function  1:
    IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=32.  
      I/O at 0xd800 [0xd80f].
  Bus  0, device   4, function  2:
    USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 1).
      IRQ 9.
      Master Capable.  Latency=32.  
      I/O at 0xd400 [0xd41f].
  Bus  0, device   4, function  3:
    Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 2).
  Bus  0, device   9, function  0:
    Multimedia video controller: Brooktree Corporation Bt878 (rev 2).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xe1000000 [0xe1000fff].
  Bus  0, device   9, function  1:
    Multimedia controller: Brooktree Corporation Bt878 (rev 2).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=255.
      Prefetchable 32 bit memory at 0xe0800000 [0xe0800fff].
  Bus  0, device  10, function  0:
    SCSI storage controller: Adaptec AHA-7850 (rev 1).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=4.
      I/O at 0xd000 [0xd0ff].
      Non-prefetchable 32 bit memory at 0xdf000000 [0xdf000fff].
  Bus  0, device  13, function  0:
    Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 7).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=20.
      I/O at 0xb800 [0xb81f].
  Bus  0, device  13, function  1:
    Input device controller: Creative Labs SB Live! (rev 7).
      Master Capable.  Latency=32.  
      I/O at 0xb400 [0xb407].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 4).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0xe2000000 [0xe3ffffff].
      Non-prefetchable 32 bit memory at 0xe0000000 [0xe0003fff].
      Non-prefetchable 32 bit memory at 0xdf800000 [0xdfffffff].
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
