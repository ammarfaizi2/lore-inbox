Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288580AbSADKAW>; Fri, 4 Jan 2002 05:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288578AbSADKAM>; Fri, 4 Jan 2002 05:00:12 -0500
Received: from goliath.sylaba.poznan.pl ([195.216.104.3]:24808 "EHLO
	goliath.sylaba.poznan.pl") by vger.kernel.org with ESMTP
	id <S288577AbSADKAG>; Fri, 4 Jan 2002 05:00:06 -0500
Date: Fri, 4 Jan 2002 10:59:40 +0100
From: Olaf =?iso-8859-2?Q?Fr=B1czyk?= <olaf@cbk.poznan.pl>
To: linux-kernel@vger.kernel.org
Subject: Spurious interrupts and VIA chipsets
Message-ID: <20020104105940.A7113@venus.local.navi.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Are these chipsets dangerous to use?
I found that other people reported similar problems to this one.
I have Asus ATV133-C motherboard, Duron 1000 MHz.
It does NOT have a Promise controller on board.
And I get such message, everytime after I reboot:
Jan  4 08:53:53 venus kernel: spurious 8259A interrupt: IRQ7.
My other hardware is OK: I putted everything from my previous Intel box.

In /proc/interrupts after 1:53 uptime I have:
ERR:        435

Here is what tells /proc/pci about chipset:

PCI devices found:
   Bus  0, device   0, function  0:
     Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 3).
       Master Capable.  Latency=8.        Prefetchable 32 bit memory at 
0xe6000000 [0xe7ffffff].
   Bus  0, device   1, function  0:
     PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (rev 
0).
       Master Capable.  No bursts.  Min Gnt=8.
   Bus  0, device   4, function  0:
     ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
64).

Please CC me, as I'm not subscribed to this list.

Regards,

Olaf Fraczyk
