Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVLPDPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVLPDPi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 22:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVLPDPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 22:15:37 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:41879 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751143AbVLPDPh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 22:15:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CqE+69CkXIvrtkMdbhKmGXjcHFiCXO9thx9p++7rYg6sZhFM+9YVUxpsZG3omoCAAwWPPS15fBKwanWl0rDvo9IDVwaCahPH/MQ/U3YfFwo7bcuq7Gjwh6vOqLjoTopD04A8YQiNZh7yD4eU6icIyrvM/Hb1RJTPpoCPjRzLSqM=
Message-ID: <be2547710512151915k3ff5ba78j@mail.gmail.com>
Date: Fri, 16 Dec 2005 04:15:35 +0100
From: Huess <huexxx@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Error compiling linux-2.6.9
In-Reply-To: <be2547710512151912w1593ff4eh@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <be2547710512151912w1593ff4eh@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Error compiling linux-2.6.9
[2.] When I try to compile the kernel, executing make, the script
returns an error.
[3.]
[4.] Linux version 2.6.13-15-smp (geeko@buildhost) (gcc version 4.0.2
20050901 (prerelease) (SUSE Linux)) #1 SMP Tue Sep 13 14:56:15 UTC
2005
[5.]
[6.] Running make, I obtain the following:
piv2800ht:/usr/src/linux-2.6.9 # make vmlinux
  CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' está actualizado.
  CHK     include/linux/compile.h

  CC      arch/i386/kernel/process.o
arch/i386/kernel/process.c: In function 'show_regs':
arch/i386/kernel/process.c:252: warning: pointer targets in passing
argument 2 of 'show_trace' differ in signedness
{entrada estándar}: Mensajes del ensamblador:

{entrada estándar}:741: Error: sufijo u operandos inválidos para `mov'
{entrada estándar}:742: Error: sufijo u operandos inválidos para `mov'
{entrada estándar}:950: Error: sufijo u operandos inválidos para `mov'

{entrada estándar}:951: Error: sufijo u operandos inválidos para `mov'
{entrada estándar}:1027: Error: sufijo u operandos inválidos para `mov'
{entrada estándar}:1028: Error: sufijo u operandos inválidos para `mov'

{entrada estándar}:1125: Error: sufijo u operandos inválidos para `mov'
{entrada estándar}:1126: Error: sufijo u operandos inválidos para `mov'
{entrada estándar}:1220: Error: sufijo u operandos inválidos para `mov'

{entrada estándar}:1232: Error: sufijo u operandos inválidos para `mov'
make[1]: *** [arch/i386/kernel/process.o] Error 1
make: *** [arch/i386/kernel] Error 2
[7.] SuSE 10.0
[7.1.] piv2800ht:/usr/src/linux-2.6.9 # make vmlinux
  CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' está actualizado.
  CHK     include/linux/compile.h
  CC      arch/i386/kernel/process.o

arch/i386/kernel/process.c: In function 'show_regs':
arch/i386/kernel/process.c:252: warning: pointer targets in passing
argument 2 of 'show_trace' differ in signedness
{entrada estándar}: Mensajes del ensamblador:

{entrada estándar}:741: Error: sufijo u operandos inválidos para `mov'
{entrada estándar}:742: Error: sufijo u operandos inválidos para `mov'
{entrada estándar}:950: Error: sufijo u operandos inválidos para `mov'

{entrada estándar}:951: Error: sufijo u operandos inválidos para `mov'
{entrada estándar}:1027: Error: sufijo u operandos inválidos para `mov'
{entrada estándar}:1028: Error: sufijo u operandos inválidos para `mov'

{entrada estándar}:1125: Error: sufijo u operandos inválidos para `mov'
{entrada estándar}:1126: Error: sufijo u operandos inválidos para `mov'
{entrada estándar}:1220: Error: sufijo u operandos inválidos para `mov'

{entrada estándar}:1232: Error: sufijo u operandos inválidos para `mov'
make[1]: *** [arch/i386/kernel/process.o] Error 1
make: *** [arch/i386/kernel] Error 2
[7.2.] processor       : 0
vendor_id       : GenuineIntel

cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 9
cpu MHz         : 2813.989
cache size      : 512 KB
physical id     : 0
siblings        : 2

core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes

flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
xtpr
bogomips        : 5632.81

processor       : 1
vendor_id       : GenuineIntel

cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 9
cpu MHz         : 2813.989
cache size      : 512 KB
physical id     : 0
siblings        : 2

core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes

flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
xtpr
bogomips        : 5627.44

[7.3.] udf 91908 0 - Live 0xf9287000
fglrx 440480 7 - Live 0xf9306000
hfsplus 81028 0 - Live 0xf99ac000
vfat 18048 0 - Live 0xf9934000
fat 56348 1 vfat, Live 0xf9912000
subfs 12672 2 - Live 0xf990d000
speedstep_lib 8452 0 - Live 0xf9895000

freq_table 8832 0 - Live 0xf9850000
button 11024 0 - Live 0xf9834000
snd_pcm_oss 67616 0 - Live 0xf9922000
snd_mixer_oss 24704 1 snd_pcm_oss, Live 0xf98b7000
battery 14212 0 - Live 0xf98b2000
snd_seq 62864 0 - Live 0xf98fc000

snd_seq_device 13068 1 snd_seq, Live 0xf9890000
ipv6 280192 14 - Live 0xf994e000
ac 9220 0 - Live 0xf983d000
edd 14560 0 - Live 0xf988b000
ide_cd 46084 0 - Live 0xf98a5000
cdrom 42912 1 ide_cd, Live 0xf9899000

sk98lin 209624 1 - Live 0xf98c7000
snd_intel8x0 39040 1 - Live 0xf9841000
snd_ac97_codec 98428 1 snd_intel8x0, Live 0xf9871000
snd_ac97_bus 6400 1 snd_ac97_codec, Live 0xf8869000
i2c_i801 12812 0 - Live 0xf97e9000

i2c_core 25344 1 i2c_i801, Live 0xf97f7000
snd_pcm 109700 3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec, Live 0xf9855000
snd_timer 31108 2 snd_seq,snd_pcm, Live 0xf97ee000
snd 71300 10 snd_pcm_oss,snd_mixer_oss,snd_seq,snd_seq_device,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,
Live 0xf9821000

generic 8452 0 [permanent], Live 0xf972f000
soundcore 13920 1 snd, Live 0xf97de000
snd_page_alloc 15112 2 snd_intel8x0,snd_pcm, Live 0xf9735000
intel_agp 26652 1 - Live 0xf97d6000
agpgart 38476 2 fglrx,intel_agp, Live 0xf97cb000

ehci_hcd 38920 0 - Live 0xf97c0000
uhci_hcd 39440 0 - Live 0xf97b5000
usbcore 126848 3 ehci_hcd,uhci_hcd, Live 0xf977a000
shpchp 100228 0 - Live 0xf979b000
pci_hotplug 32188 1 shpchp, Live 0xf959f000
parport_pc 45252 1 - Live 0xf976d000

lp 15780 0 - Live 0xf959a000
parport 40392 2 parport_pc,lp, Live 0xf971f000
nls_utf8 6016 2 - Live 0xf886c000
ntfs 202896 2 - Live 0xf973a000
dm_mod 63004 0 - Live 0xf9583000
reiserfs 269424 1 - Live 0xf95a8000

fan 8964 0 - Live 0xf881b000
thermal 18696 0 - Live 0xf885f000
processor 31720 1 thermal, Live 0xf9555000
sg 42528 0 - Live 0xf9549000
ata_piix 13956 4 - Live 0xf8836000
libata 55428 1 ata_piix, Live 0xf8870000

piix 14596 0 [permanent], Live 0xf8831000
sd_mod 23808 6 - Live 0xf882a000
scsi_mod 142952 3 sg,libata,sd_mod, Live 0xf9502000
ide_disk 22656 0 - Live 0xf8823000
ide_core 136528 4 ide_cd,generic,piix,ide_disk, Live 0xf9526000


[7.4.] 0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu

01f0-01f7 : ide0
02f8-02ff : serial
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0778-077a : parport0
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
  1000-1003 : PM1a_EVT_BLK

  1004-1005 : PM1a_CNT_BLK
  1008-100b : PM_TMR
  1028-102f : GPE0_BLK
1080-10bf : 0000:00:1f.0
1400-141f : 0000:00:1f.3
  1400-140f : i801-smbus
9000-9fff : PCI Bus #01
  9000-90ff : 0000:01:00.0

a000-afff : PCI Bus #02
  a000-a0ff : 0000:02:09.0
    a000-a0ff : sk98lin
b000-b01f : 0000:00:1d.1
  b000-b01f : uhci_hcd
b400-b41f : 0000:00:1d.2
  b400-b41f : uhci_hcd
b800-b81f : 0000:00:1d.3

  b800-b81f : uhci_hcd
bc00-bc1f : 0000:00:1d.0
  bc00-bc1f : uhci_hcd
c000-c007 : 0000:00:1f.2
  c000-c007 : libata
c400-c403 : 0000:00:1f.2
  c400-c403 : libata
c800-c807 : 0000:00:1f.2
  c800-c807 : libata

cc00-cc03 : 0000:00:1f.2
  cc00-cc03 : libata
d000-d00f : 0000:00:1f.2
  d000-d00f : libata
d800-d8ff : 0000:00:1f.5
  d800-d8ff : Intel ICH5
dc00-dc3f : 0000:00:1f.5
  dc00-dc3f : Intel ICH5
f000-f00f : 0000:00:
1f.1
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009fbff : System RAM
  00000000-00000000 : Crash kernel
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000ccfff : Video ROM

000f0000-000fffff : System ROM
00100000-5ffeffff : System RAM
  00100000-00346909 : Kernel code
  0034690a-004021e7 : Kernel data
5fff0000-5fff2fff : ACPI Non-volatile Storage
5fff3000-5fffffff : ACPI Tables

60000000-600fffff : PCI Bus #02
  60000000-6001ffff : 0000:02:09.0
60100000-601003ff : 0000:00:1f.1
d0000000-efffffff : PCI Bus #01
  d0000000-dfffffff : 0000:01:00.0
    d0000000-d0ffffff : vesafb
  e0000000-efffffff : 0000:01:
00.1
f0000000-f7ffffff : 0000:00:00.0
f8000000-f9ffffff : PCI Bus #01
  f8000000-f801ffff : 0000:01:00.0
  f9000000-f900ffff : 0000:01:00.0
  f9010000-f901ffff : 0000:01:00.1
fa000000-fbffffff : PCI Bus #02

  fb000000-fb003fff : 0000:02:09.0
    fb000000-fb003fff : sk98lin
fc000000-fc0003ff : 0000:00:1d.7
  fc000000-fc0003ff : ehci_hcd
fc001000-fc0011ff : 0000:00:1f.5
  fc001000-fc0011ff : Intel ICH5
fc002000-fc0020ff : 0000:00:
1f.5
  fc002000-fc0020ff : Intel ICH5
fec00000-ffffffff : reserved

[7.5]
00:00.0 Host bridge: Intel Corporation 82865G/PE/P DRAM
Controller/Host-Hub Interface (rev 02)
        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard (865PE)

        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-

        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [e4] Vendor Specific Information
        Capabilities: [a0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8

                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ Rate=x8

00:01.0 PCI bridge: Intel Corporation 82865G/PE/P PCI to AGP
Controller (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-

        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32

        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: f8000000-f9ffffff
        Prefetchable memory behind bridge: d0000000-efffffff
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ <SERR- <PERR-

        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology GA-8IPE1000/8KNXP motherboard

        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-

        Latency: 0
        Interrupt: pin A routed to IRQ 177
        Region 4: I/O ports at bc00 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])

        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard (865PE)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-

        Latency: 0
        Interrupt: pin B routed to IRQ 185
        Region 4: I/O ports at b000 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #3 (rev 02) (prog-if 00 [UHCI])

        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard (865PE)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-

        Latency: 0
        Interrupt: pin C routed to IRQ 169
        Region 4: I/O ports at b400 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #4 (rev 02) (prog-if 00 [UHCI])

        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard (865PE)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-

        Latency: 0
        Interrupt: pin A routed to IRQ 177
        Region 4: I/O ports at b800 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2
EHCI Controller (rev 02) (prog-if 20 [EHCI])

        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard (865PE)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-

        Latency: 0
        Interrupt: pin D routed to IRQ 193
        Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)

                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-

        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000a000-0000afff

        Memory behind bridge: fa000000-fbffffff
        Prefetchable memory behind bridge: 60000000-600fffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ <SERR- <PERR-

        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC
Interface Bridge (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-

        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE
Controller (rev 02) (prog-if 8a [Master SecP PriP])

        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard (865PE)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-

        Latency: 0
        Interrupt: pin A routed to IRQ 169
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>

        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at f000 [size=16]
        Region 5: Memory at 60100000 (32-bit, non-prefetchable) [size=1K]

00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA
Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])

        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard (865PE)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-

        Latency: 0
        Interrupt: pin A routed to IRQ 169
        Region 0: I/O ports at c000 [size=8]
        Region 1: I/O ports at c400 [size=4]
        Region 2: I/O ports at c800 [size=8]
        Region 3: I/O ports at cc00 [size=4]

        Region 4: I/O ports at d000 [size=16]

00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus
Controller (rev 02)
        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard (865PE)

        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-

        Interrupt: pin B routed to IRQ 9
        Region 4: I/O ports at 1400 [size=32]

00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)
        Subsystem: Giga-byte Technology GA-8IPE1000/8KNXP motherboard

        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-

        Latency: 0
        Interrupt: pin B routed to IRQ 201
        Region 0: I/O ports at d800 [size=256]
        Region 1: I/O ports at dc00 [size=64]
        Region 2: Memory at fc001000 (32-bit, non-prefetchable) [size=512]

        Region 3: Memory at fc002000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)

                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc RV350 AS
[Radeon 9550] (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 2084

        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-

        Latency: 255 (2000ns min), Cache Line Size 08
        Interrupt: pin A routed to IRQ 177
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
        Region 1: I/O ports at 9000 [size=256]

        Region 2: Memory at f9000000 (32-bit, non-prefetchable) [size=64K]
        [virtual] Expansion ROM at f8000000 [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8

                Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit-
FW+ Rate=x8
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)

                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.1 Display controller: ATI Technologies Inc RV350 ?? [Radeon
9550] (Secondary)
        Subsystem: ATI Technologies Inc: Unknown device 2085

        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-

        Latency: 32 (2000ns min), Cache Line Size 08
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
        Region 1: Memory at f9010000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 2

                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:09.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001
Gigabit Ethernet Controller (rev 13)

        Subsystem: Giga-byte Technology Marvell 88E8001 Gigabit
Ethernet Controller (Gigabyte)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-

        Latency: 32 (5750ns min, 7750ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 209
        Region 0: Memory at fb000000 (32-bit, non-prefetchable) [size=16K]
        Region 1: I/O ports at a000 [size=256]

        [virtual] Expansion ROM at 60000000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)

                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
Attached devices:

[7.6.]
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3120026AS      Rev:
3.18
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6B200M0   Rev: BANC
  Type:   Direct-Access                    ANSI SCSI revision: 05


[X.] Other notes, patches, fixes, workarounds:
patch-2.6.9-ac16
linux-2.6.9-squashfs-2.1_lzma-mc1.patch

I've obtained the same error compiling without this patches...

Trying to compile linux-2.6.10
, I've obtained the same error.
Trying to compile linux-2.6.13-15, I've obtained no errors.

Regards.
