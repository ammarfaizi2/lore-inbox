Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265998AbTATPeB>; Mon, 20 Jan 2003 10:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266043AbTATPeA>; Mon, 20 Jan 2003 10:34:00 -0500
Received: from chaos.analogic.com ([204.178.40.224]:55436 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265998AbTATPeA> convert rfc822-to-8bit; Mon, 20 Jan 2003 10:34:00 -0500
Date: Mon, 20 Jan 2003 10:45:03 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Andrey V. Ignatov" <andrey@emax.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Incorrect CPUs (Xeon 1.8 with HT) frequency ?
In-Reply-To: <62115845787.20030120183231@emax.ru>
Message-ID: <Pine.LNX.3.95.1030120104039.15924A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2003, Andrey V. Ignatov wrote:

> I think that kernel detect my CPUs not correctly. I have box with dual
> Xeon CPU 1.80GHz and HT feature. Kernel successfully found all 4
> virtual CPUs but frequency of each CPUs is incorrect as I mean.
> My system build on Intel® E7500 chipset.
> I try kernels : 2.4.20 & 2.4.21-pre3...
> Output from /proc/cpuinfo (for each processor the same):
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Xeon(TM) CPU 1.80GHz
> stepping        : 7
> cpu MHz         : 798.659
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> bogomips        : 1592.52
> 
> P.S.
> Please CC's to me because I am not list subscriber.

The CPU frequency is measured! So, either the programmable interrupt
timer isn't getting the right clock frequency or the CPU isn't getting
the right clock frequency.

Since the reported bogomips is about twice the CPU frequency, the
measured numbers look correct. So, maybe the jumpers on the mother-
board (or the BIOS) are not set correctly??

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


