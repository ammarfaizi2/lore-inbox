Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269185AbRGaGIm>; Tue, 31 Jul 2001 02:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269186AbRGaGIc>; Tue, 31 Jul 2001 02:08:32 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:4049 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S269185AbRGaGIX>;
	Tue, 31 Jul 2001 02:08:23 -0400
Date: Tue, 31 Jul 2001 07:10:34 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: booting SMP P6 kernel on P4 hangs.
Message-ID: <Pine.LNX.4.21.0107310705580.1374-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi guys,

Isn't SMP P6 kernel supposed to boot fine on a P4? Btw, booting with
"nosmp" works but booting with "noapic" hangs just the same.

Here is where it hangs:

> 
> ---------------------System Info------------------------------------
> 
> Intel Pentium 4 processor: 1.3 GHz
> Level 2 Cache: 256 KB Integrated
> 
> System Memory 256 MB ECC RDRAM
> AGP Aperture  128 MB
> CPU Information::
>   CPU speed   Normal
>   Bus Speed  100 Mhz
>   Processor ID F0A
>   Clock Speed 1.30 Ghz
>   Cache Size  256KB
> 
> 
> 
> --------------------Messages on the screen---------------------------
> 
> 
> CPU0: Intel(R) Pentium(R) 4 CPU 1300 Mhz stepping 0a
> per-CPU timeslice cutoff: 731.49 usecs
> weird, boot CPU (#0) not listed by the BIOS
> Getting VERSION: f000acde
> Getting VERSION: f0ffac21
> leaving PIC mode, enabling symmetric IO mode.
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> CPU present map: 1
> Before bogomips.
> Error: only one processor found.
> Boot done.
> ENABLING IO-APIC IRQs
> Synchronizing Arb IDs.
> ..TIMER: vector=31 pin1=2 pin2=0
> activating NMI Watchdog...done
> CPU#0 NMI appears to be stuck
> testing the IO APIC.............
> ..........................done
> calibrating APIC timer...
> .....CPU clock speed is 1285.2614 Mhz
> ....host bus clock speed is 0.0000 Mhz
> cpu:0, clocks:0, slice:0
> 
> 
> 

