Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271673AbRHUNq2>; Tue, 21 Aug 2001 09:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271670AbRHUNqR>; Tue, 21 Aug 2001 09:46:17 -0400
Received: from ns.ithnet.com ([217.64.64.10]:56072 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S271668AbRHUNqE>;
	Tue, 21 Aug 2001 09:46:04 -0400
Date: Tue, 21 Aug 2001 15:46:17 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Memory Problem in 2.4.9 ?
Message-Id: <20010821154617.4671f85d.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

can anybody enlighten me about the following kernel-message:

Aug 21 14:37:39 admin kernel: __alloc_pages: 3-order allocation failed.
Aug 21 14:37:39 admin kernel: __alloc_pages: 2-order allocation failed. 
Aug 21 14:37:39 admin kernel: __alloc_pages: 3-order allocation failed.
Aug 21 14:37:39 admin kernel: __alloc_pages: 3-order allocation failed.
Aug 21 14:37:39 admin kernel: __alloc_pages: 2-order allocation failed.
Aug 21 14:37:39 admin kernel: __alloc_pages: 3-order allocation failed.
Aug 21 14:37:39 admin last message repeated 69 times

I get tons of them during verifying burned CDs with xcdroast (which takes a really long time, and must have some problem therefore). 
I would not worry you if it didn't work with earlier kernel-versions, but in fact it did. 

Hardware: (Asus CUV4X-D, yes it works :-)
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:09.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
00:0a.0 Network controller: Elsa AG QuickStep 1000 (rev 01)
00:0b.0 SCSI storage controller: Adaptec 7892A (rev 02)
00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 07)
00:0d.1 Input device controller: Creative Labs SB Live! (rev 07)
01:00.0 VGA compatible controller: nVidia Corporation NV11 (rev b2)
02:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
02:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
02:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
02:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)

cpu:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 1004.525
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 2005.40

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 1004.525
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 2005.40

MEM:
        total:    used:    free:  shared: buffers:  cached:
Mem:  1053675520 1047502848  6172672        0 20930560 939307008
Swap: 271392768 15880192 255512576
MemTotal:      1028980 kB
MemFree:          6028 kB
MemShared:           0 kB
Buffers:         20440 kB
Cached:         911860 kB
SwapCached:       5432 kB
Active:         571980 kB
Inact_dirty:    362480 kB
Inact_clean:      3272 kB
Inact_target:     2336 kB
HighTotal:      131056 kB
HighFree:         2036 kB
LowTotal:       897924 kB
LowFree:          3992 kB
SwapTotal:      265032 kB
SwapFree:       249524 kB

