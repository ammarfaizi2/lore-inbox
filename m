Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266010AbTATPXm>; Mon, 20 Jan 2003 10:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265998AbTATPXm>; Mon, 20 Jan 2003 10:23:42 -0500
Received: from [213.243.76.32] ([213.243.76.32]:15309 "EHLO emax.ru")
	by vger.kernel.org with ESMTP id <S266064AbTATPXl>;
	Mon, 20 Jan 2003 10:23:41 -0500
Date: Mon, 20 Jan 2003 18:32:31 +0300
From: "Andrey V. Ignatov" <andrey@emax.ru>
X-Mailer: The Bat! (v1.61) Business
Reply-To: "Andrey V. Ignatov" <andrey@emax.ru>
X-Priority: 3 (Normal)
Message-ID: <62115845787.20030120183231@emax.ru>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Incorrect CPUs (Xeon 1.8 with HT) frequency ?
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that kernel detect my CPUs not correctly. I have box with dual
Xeon CPU 1.80GHz and HT feature. Kernel successfully found all 4
virtual CPUs but frequency of each CPUs is incorrect as I mean.
My system build on Intel® E7500 chipset.
I try kernels : 2.4.20 & 2.4.21-pre3...
Output from /proc/cpuinfo (for each processor the same):
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 1.80GHz
stepping        : 7
cpu MHz         : 798.659
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 1592.52

P.S.
Please CC's to me because I am not list subscriber.


