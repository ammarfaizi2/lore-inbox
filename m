Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133023AbREERQj>; Sat, 5 May 2001 13:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133029AbREERQ3>; Sat, 5 May 2001 13:16:29 -0400
Received: from [24.93.67.55] ([24.93.67.55]:47120 "EHLO mail8.carolina.rr.com")
	by vger.kernel.org with ESMTP id <S133023AbREERQO>;
	Sat, 5 May 2001 13:16:14 -0400
From: Zilvinas Valinskas <zvalinskas@carolina.rr.com>
Date: Sat, 5 May 2001 13:15:05 -0400
To: linux-kernel@vger.kernel.org
Cc: zvalinskas@carolina.rr.com
Subject: ABit KT7A-RAIN random lock ups 
Message-ID: <20010505131505.A5386@clt88-175-140.carolina.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello listers,

as of yesterday I started to get random hard lockups. It was strange
because just before that I've never had one ... MB worked just fine
for now about two months. Until yesterday ...

I tried to boot 2.4.3-ac14, 2.4.4, 2.4.4-ac4 ... the same. Btw. I have
ACPI enabled, so sometimes I see lots of defunc processes 
kacpidpc defunct ... and that number keeps growing. Ok, I see that new
kernel might misbehave but for example 2.4.3-ac14 used to work as charm
and there I see the same ... tons of defunc processes ... until fork:
resource temporary unavailable error ...

So that's not the kernel (my guess.). Last night I booted up win 98 to
play unreal tournament. Then booted back to linux ... and there we go
I hit strange pile of the problems and I don't know how to deal with them.

Tinkered for a while. Disable acpi or so ... trying to recompile kernels
- random lock ups. Sometimes it works fine for longer time sometimes it
hangs much faster ... most of time I saw kacpidpc defuncs ...

Yet later 5am. in the morning I gave up. ... But then I realized that win 98
did something ... lets try clean up BIOS'es (with jumper). Now it works just
fine again as it used to ... 

Now I don't have a clue as to what was wrong ?

Win98 reprograms hardware ? and linux can't handle it in this "win98" state ?
Looks like it :(


No Ooops. Just plain hard lock up. No cpu not overclocked. Latest BIOS version.

My hardware :
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:08.0 Ethernet controller: Bridgecom, Inc: Unknown device 0985 (rev 11)
00:0f.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 07)
00:0f.1 Input device controller: Creative Labs SB Live! (rev 07)
01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5144

swoop@tweakster:~$ cat /proc/ide/via     
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.23
South Bridge:                       VIA vt82c686b
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ ????
Revision:                           ISA 0x40 IDE 0x6
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xd000
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit

swoop@tweakster:~$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 850.047
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1697.38

Any ideas ?
-- 
Zilvinas Valinskas
