Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272246AbRHWMRF>; Thu, 23 Aug 2001 08:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272257AbRHWMQ4>; Thu, 23 Aug 2001 08:16:56 -0400
Received: from hq.nawigator.pl ([212.160.254.2]:27402 "HELO hq.nawigator.pl")
	by vger.kernel.org with SMTP id <S272249AbRHWMQs>;
	Thu, 23 Aug 2001 08:16:48 -0400
Date: Thu, 23 Aug 2001 14:16:16 +0200 (CEST)
From: Lukasz Trabinski <lukasz@polvoice.pl>
X-X-Sender: <lukasz@hq.nawigator.pl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.7-9 - kernel panic with K7 optymilization on KT133/KM133
Message-ID: <Pine.LNX.4.33.0108231403350.21008-100000@hq.nawigator.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I belive that is known problem, but I have write about it... :)

I have just tried to start kernels 2.4.7 2.4.8  & 2.4.9 with K7
optimization (Athlon/Duron/K7 - Processor family) on mainboard with
VT8363/8365 [KT133/KM133] chipset. Always, I had got "kernel panic" on
start. It's works correctly with K6 optimization.

[root@vendeta /root]# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)


[root@vendeta /root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) Processor
stepping        : 0
cpu MHz         : 600.045
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1196.03



-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @polvoice.com


