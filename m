Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWJYTdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWJYTdW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 15:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWJYTdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 15:33:22 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:37524 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750931AbWJYTdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 15:33:20 -0400
Message-ID: <453FBC40.5020901@gmail.com>
Date: Wed, 25 Oct 2006 21:34:24 +0200
From: giggz <giggzounet@gmail.com>
User-Agent: IceDove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM : Bus hidden behind transparent bridge on my laptop (keynux
 impact or AOpen 1557)
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=A030AFA6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I have a laptop under debian sid with a 2.6.18-1.

Problem :
At boot I have a message from the kernel which tells :

ct 25 19:49:51 localhost kernel: PCI: Transparent bridge - 0000:00:1e.0
Oct 25 19:49:51 localhost kernel: PCI: Bus #03 (-#06) is hidden behind
transparent bridge #02 (-#02) (try 'pci=assign-busses')
Oct 25 19:49:51 localhost kernel: Please report the result to
linux-kernel to fix this permanently
Oct 25 19:49:51 localhost kernel: PCI: Bus #07 (-#0a) is hidden behind
transparent bridge #02 (-#02) (try 'pci=assign-busses')
Oct 25 19:49:51 localhost kernel: Please report the result to
linux-kernel to fix this permanently

keywords : Bus is hidden behind transparent bridge

Thx for all

Guillaume



Others informations :

here is the beginning of the boot log :

Oct 25 19:49:51 localhost kernel: klogd 1.4.1#20, log source =
/proc/kmsg started.
Oct 25 19:49:51 localhost kernel: Linux version 2.6.18.1-17
(giggz@debian) (gcc version 4.1.2 20061007 (prerelease) (Debian
4.1.1-16)) #1 PREEMPT Sat Oct 21 07:51:02 CEST 2006
Oct 25 19:49:51 localhost kernel: BIOS-provided physical RAM map:
Oct 25 19:49:51 localhost kernel:  BIOS-e820: 0000000000000000 -
000000000009f800 (usable)
Oct 25 19:49:51 localhost kernel:  BIOS-e820: 000000000009f800 -
00000000000a0000 (reserved)
Oct 25 19:49:51 localhost kernel:  BIOS-e820: 00000000000d8000 -
00000000000e0000 (reserved)
Oct 25 19:49:51 localhost kernel:  BIOS-e820: 00000000000e4000 -
0000000000100000 (reserved)
Oct 25 19:49:51 localhost kernel:  BIOS-e820: 0000000000100000 -
000000007ff70000 (usable)
Oct 25 19:49:51 localhost kernel:  BIOS-e820: 000000007ff70000 -
000000007ff7b000 (ACPI data)
Oct 25 19:49:51 localhost kernel:  BIOS-e820: 000000007ff7b000 -
000000007ff80000 (ACPI NVS)
Oct 25 19:49:51 localhost kernel:  BIOS-e820: 000000007ff80000 -
0000000080000000 (reserved)
Oct 25 19:49:51 localhost kernel:  BIOS-e820: 00000000ff800000 -
00000000ffc00000 (reserved)
Oct 25 19:49:51 localhost kernel:  BIOS-e820: 00000000fffff000 -
0000000100000000 (reserved)
Oct 25 19:49:51 localhost kernel: 1151MB HIGHMEM available.
Oct 25 19:49:51 localhost kernel: 896MB LOWMEM available.
Oct 25 19:49:51 localhost kernel: DMI present.
Oct 25 19:49:51 localhost kernel: ACPI: PM-Timer IO Port: 0x1008
Oct 25 19:49:51 localhost kernel: Allocating PCI resources starting at
88000000 (gap: 80000000:7f800000)
Oct 25 19:49:51 localhost kernel: Detected 1794.240 MHz processor.
Oct 25 19:49:51 localhost kernel: Built 1 zonelists.  Total pages: 524144
Oct 25 19:49:51 localhost kernel: Kernel command line: root=/dev/hda1 ro
Oct 25 19:49:51 localhost kernel: Local APIC disabled by BIOS -- you can
enable it with "lapic"
Oct 25 19:49:51 localhost kernel: Enabling fast FPU save and restore...
done.
Oct 25 19:49:51 localhost kernel: Enabling unmasked SIMD FPU exception
support... done.
Oct 25 19:49:51 localhost kernel: Initializing CPU#0
Oct 25 19:49:51 localhost kernel: PID hash table entries: 4096 (order:
12, 16384 bytes)
Oct 25 19:49:51 localhost kernel: Console: colour VGA+ 80x25
Oct 25 19:49:51 localhost kernel: Dentry cache hash table entries:
131072 (order: 7, 524288 bytes)
Oct 25 19:49:51 localhost kernel: Inode-cache hash table entries: 65536
(order: 6, 262144 bytes)
Oct 25 19:49:51 localhost kernel: Memory: 2075696k/2096576k available
(1631k kernel code, 19724k reserved, 483k data, 148k init, 1179072k highmem)
Oct 25 19:49:51 localhost kernel: Checking if this processor honours the
WP bit even in supervisor mode... Ok.
Oct 25 19:49:51 localhost kernel: Calibrating delay using timer specific
routine.. 3589.44 BogoMIPS (lpj=1794722)
Oct 25 19:49:51 localhost kernel: Security Framework v1.0.0 initialized
Oct 25 19:49:51 localhost kernel: Capability LSM initialized
Oct 25 19:49:51 localhost kernel: Mount-cache hash table entries: 512
Oct 25 19:49:51 localhost kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Oct 25 19:49:51 localhost kernel: CPU: L2 cache: 2048K
Oct 25 19:49:51 localhost kernel: Intel machine check architecture
supported.
Oct 25 19:49:51 localhost kernel: Intel machine check reporting enabled
on CPU#0.
Oct 25 19:49:51 localhost kernel: CPU: Intel(R) Pentium(R) M processor
1.80GHz stepping 06
Oct 25 19:49:51 localhost kernel: Checking 'hlt' instruction... OK.
Oct 25 19:49:51 localhost kernel: ACPI: Core revision 20060707
Oct 25 19:49:51 localhost kernel: ACPI: setting ELCR to 0200 (from 0c00)
Oct 25 19:49:51 localhost kernel: NET: Registered protocol family 16
Oct 25 19:49:51 localhost kernel: ACPI: bus type pci registered
Oct 25 19:49:51 localhost kernel: PCI: PCI BIOS revision 2.10 entry at
0xfd7d5, last bus=2
Oct 25 19:49:51 localhost kernel: PCI: Using configuration type 1
Oct 25 19:49:51 localhost kernel: Setting up standard PCI resources
Oct 25 19:49:51 localhost kernel: ACPI: Interpreter enabled
Oct 25 19:49:51 localhost kernel: ACPI: Using PIC for interrupt routing
Oct 25 19:49:51 localhost kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Oct 25 19:49:51 localhost kernel: PCI quirk: region 1000-107f claimed by
ICH4 ACPI/GPIO/TCO
Oct 25 19:49:51 localhost kernel: PCI quirk: region 1180-11bf claimed by
ICH4 GPIO
Oct 25 19:49:51 localhost kernel: PCI: Ignoring BAR0-3 of IDE controller
0000:00:1f.1
Oct 25 19:49:51 localhost kernel: PCI: Transparent bridge - 0000:00:1e.0
Oct 25 19:49:51 localhost kernel: PCI: Bus #03 (-#06) is hidden behind
transparent bridge #02 (-#02) (try 'pci=assign-busses')
Oct 25 19:49:51 localhost kernel: Please report the result to
linux-kernel to fix this permanently
Oct 25 19:49:51 localhost kernel: PCI: Bus #07 (-#0a) is hidden behind
transparent bridge #02 (-#02) (try 'pci=assign-busses')
Oct 25 19:49:51 localhost kernel: Please report the result to
linux-kernel to fix this permanently
Oct 25 19:49:51 localhost kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs
10 *11)
Oct 25 19:49:51 localhost kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
Oct 25 19:49:51 localhost kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs
10 *11)
Oct 25 19:49:51 localhost kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs
10) *11
Oct 25 19:49:51 localhost kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs
10 11) *0, disabled.
Oct 25 19:49:51 localhost kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs
10 11) *0, disabled.
Oct 25 19:49:51 localhost kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs
10 11) *0, disabled.
Oct 25 19:49:51 localhost kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs
*10 11)
Oct 25 19:49:51 localhost kernel: ACPI: Embedded Controller [EC0] (gpe
28) interrupt mode.
Oct 25 19:49:51 localhost kernel: Linux Plug and Play Support v0.97 (c)
Adam Belay
Oct 25 19:49:51 localhost kernel: pnp: PnP ACPI init
Oct 25 19:49:51 localhost kernel: pnp: PnP ACPI: found 10 devices
Oct 25 19:49:51 localhost kernel: PnPBIOS: Disabled by ACPI PNP
Oct 25 19:49:51 localhost kernel: PCI: Using ACPI for IRQ routing
Oct 25 19:49:51 localhost kernel: PCI: If a device doesn't work, try
"pci=routeirq".  If it helps, post a report
Oct 25 19:49:51 localhost kernel: PCI: Bridge: 0000:00:01.0
Oct 25 19:49:51 localhost kernel:   IO window: 3000-3fff
Oct 25 19:49:51 localhost kernel:   MEM window: d0100000-d01fffff
Oct 25 19:49:51 localhost kernel:   PREFETCH window: d8000000-dfffffff
Oct 25 19:49:51 localhost kernel: PCI: Bus 3, cardbus bridge: 0000:02:09.0
Oct 25 19:49:51 localhost kernel:   IO window: 00004000-000040ff
Oct 25 19:49:51 localhost kernel:   IO window: 00004400-000044ff
Oct 25 19:49:51 localhost kernel:   PREFETCH window: 88000000-89ffffff
Oct 25 19:49:51 localhost kernel:   MEM window: 8e000000-8fffffff
Oct 25 19:49:51 localhost kernel: PCI: Bus 7, cardbus bridge: 0000:02:09.1
Oct 25 19:49:51 localhost kernel:   IO window: 00004800-000048ff
Oct 25 19:49:51 localhost kernel:   IO window: 00004c00-00004cff
Oct 25 19:49:51 localhost kernel:   PREFETCH window: 8a000000-8bffffff
Oct 25 19:49:51 localhost kernel:   MEM window: 90000000-91ffffff
Oct 25 19:49:51 localhost kernel: PCI: Bridge: 0000:00:1e.0
Oct 25 19:49:51 localhost kernel:   IO window: 4000-4fff
Oct 25 19:49:51 localhost kernel:   MEM window: d0200000-d02fffff
Oct 25 19:49:51 localhost kernel:   PREFETCH window: 88000000-8cffffff
Oct 25 19:49:51 localhost kernel: PCI: Enabling device 0000:00:1e.0
(0005 -> 0007)
Oct 25 19:49:51 localhost kernel: PCI: Enabling device 0000:02:09.0
(0000 -> 0003)
Oct 25 19:49:51 localhost kernel: ACPI: PCI Interrupt Link [LNKF]
enabled at IRQ 11
Oct 25 19:49:51 localhost kernel: ACPI: PCI Interrupt 0000:02:09.0[A] ->
Link [LNKF] -> GSI 11 (level, low) -> IRQ 11
Oct 25 19:49:51 localhost kernel: ACPI: PCI Interrupt Link [LNKB]
enabled at IRQ 10
Oct 25 19:49:51 localhost kernel: ACPI: PCI Interrupt 0000:02:09.1[B] ->
Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Oct 25 19:49:51 localhost kernel: NET: Registered protocol family 2
Oct 25 19:49:51 localhost kernel: IP route cache hash table entries:
32768 (order: 5, 131072 bytes)
Oct 25 19:49:51 localhost kernel: TCP established hash table entries:
262144 (order: 8, 1048576 bytes)
Oct 25 19:49:51 localhost kernel: TCP bind hash table entries: 65536
(order: 6, 262144 bytes)
Oct 25 19:49:51 localhost kernel: TCP: Hash tables configured
(established 262144 bind 65536)
Oct 25 19:49:51 localhost kernel: TCP reno registered
Oct 25 19:49:51 localhost kernel: Simple Boot Flag at 0x36 set to 0x1
Oct 25 19:49:51 localhost kernel: Machine check exception polling timer
started.
Oct 25 19:49:51 localhost kernel: highmem bounce pool size: 64 pages
Oct 25 19:49:51 localhost kernel: Initializing Cryptographic API
Oct 25 19:49:51 localhost kernel: io scheduler noop registered
Oct 25 19:49:51 localhost kernel: io scheduler anticipatory registered
Oct 25 19:49:51 localhost kernel: io scheduler deadline registered
Oct 25 19:49:51 localhost kernel: io scheduler cfq registered (default)


more /proc/version :
Linux version 2.6.18.1-17 (giggz@debian) (gcc version 4.1.2 20061007
(prerelease) (Debian 4.1.1-16)) #1 PREEMPT Sat Oct 21 07:51:02 CEST 2006

more /proc/cpuinfo :
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.80GHz
stepping        : 6
cpu MHz         : 1800.000
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov
pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe est tm2
bogomips        : 3589.44


more /proc/modules
xt_limit 1472 8 - Live 0xf9b18000
xt_tcpudp 1792 80 - Live 0xf9b16000
iptable_mangle 1536 0 - Live 0xf9ad2000
ipt_LOG 4416 8 - Live 0xf9acf000
ipt_MASQUERADE 1856 0 - Live 0xf9ab4000
ip_nat 9964 1 ipt_MASQUERADE, Live 0xf9b01000
ipt_TOS 1216 0 - Live 0xf9ab6000
ipt_REJECT 3392 1 - Live 0xf9ac9000
ip_conntrack_irc 4016 0 - Live 0xf9ab0000
ip_conntrack_ftp 4592 0 - Live 0xf9ac6000
xt_state 1088 6 - Live 0xf9ab2000
ip_conntrack 26964 5
ipt_MASQUERADE,ip_nat,ip_conntrack_irc,ip_conntrack_ftp,xt_state, Live
0xf9abe000
nfnetlink 3416 2 ip_nat,ip_conntrack, Live 0xf999c000
iptable_filter 1536 1 - Live 0xf9aae000
ip_tables 9480 2 iptable_mangle,iptable_filter, Live 0xf99de000
x_tables 7044 8
xt_limit,xt_tcpudp,ipt_LOG,ipt_MASQUERADE,ipt_TOS,ipt_REJECT,xt_state,ip_tables,
Live 0xf998a000
nfs 154376 0 - Live 0xf99b7000
lockd 40456 1 nfs, Live 0xf9991000
sunrpc 98556 3 nfs,lockd, Live 0xf9a94000
ipv6 177184 12 - Live 0xf9ad4000
ppdev 6916 0 - Live 0xf998e000
lp 7172 0 - Live 0xf9985000
snd_rtctimer 1676 0 - Live 0xf9988000
cpufreq_conservative 3872 0 - Live 0xf996c000
cpufreq_powersave 832 0 - Live 0xf996e000
cpufreq_ondemand 3568 0 - Live 0xf8838000
cpufreq_performance 832 1 - Live 0xf8868000
radeon 91680 2 - Live 0xf999f000
usbhid 29600 0 - Live 0xf995b000
snd_intel8x0 21596 4 - Live 0xf98f9000
snd_pcm_oss 28704 0 - Live 0xf9952000
ipw2200 80708 0 - Live 0xf9970000
snd_mixer_oss 11584 2 snd_pcm_oss, Live 0xf98ea000
pcmcia 17696 0 - Live 0xf98d3000
snd_intel8x0m 10636 5 - Live 0xf98d9000
snd_ac97_codec 63200 2 snd_intel8x0,snd_intel8x0m, Live 0xf9941000
snd_ac97_bus 1152 1 snd_ac97_codec, Live 0xf884c000
ieee80211 21512 1 ipw2200, Live 0xf98dd000
ieee80211_crypt 2624 1 ieee80211, Live 0xf98ce000
uhci_hcd 16588 0 - Live 0xf98c6000
firmware_class 6016 2 ipw2200,pcmcia, Live 0xf9896000
i8xx_tco 4116 0 - Live 0xf989a000
b44 18764 0 - Live 0xf98a8000
mii 2880 1 b44, Live 0xf886a000
ohci1394 25008 0 - Live 0xf98a0000
ieee1394 53172 1 ohci1394, Live 0xf98b0000
snd_pcm 40584 7 snd_intel8x0,snd_pcm_oss,snd_intel8x0m,snd_ac97_codec,
Live 0xf8871000
snd_timer 13956 3 snd_rtctimer,snd_pcm, Live 0xf886c000
psmouse 25864 0 - Live 0xf8854000
ehci_hcd 23560 0 - Live 0xf885d000
usbcore 79620 4 usbhid,uhci_hcd,ehci_hcd, Live 0xf9881000
parport_pc 19108 1 - Live 0xf8846000
parport 13184 3 ppdev,lp,parport_pc, Live 0xf884f000
evdev 6464 4 - Live 0xf8843000
snd_page_alloc 5896 3 snd_intel8x0,snd_intel8x0m,snd_pcm, Live 0xf8840000
yenta_socket 10956 2 - Live 0xf883c000
rsrc_nonstatic 8000 1 yenta_socket, Live 0xf8821000
pcmcia_core 22160 3 pcmcia,yenta_socket,rsrc_nonstatic, Live 0xf881a000
ide_cd 30368 1 - Live 0xf882d000
cdrom 26400 1 ide_cd, Live 0xf8825000

more /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03bc-03be : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
  1000-107f : motherboard
    1000-1003 : ACPI PM1a_EVT_BLK
    1004-1005 : ACPI PM1a_CNT_BLK
    1008-100b : ACPI PM_TMR
    1010-1015 : ACPI CPU throttle
    1020-1020 : ACPI PM2_CNT_BLK
    1028-102f : ACPI GPE0_BLK
    1060-106f : i8xx TCO
1180-11bf : 0000:00:1f.0
  1180-11bf : motherboard
1800-181f : 0000:00:1d.0
  1800-181f : uhci_hcd
1820-183f : 0000:00:1d.1
  1820-183f : uhci_hcd
1840-185f : 0000:00:1d.2
  1840-185f : uhci_hcd
1860-186f : 0000:00:1f.1
  1860-1867 : ide0
  1868-186f : ide1
1880-189f : 0000:00:1f.3
  1880-189f : i801_smbus
18c0-18ff : 0000:00:1f.5
  18c0-18ff : Intel 82801DB-ICH4
1c00-1cff : 0000:00:1f.5
  1c00-1cff : Intel 82801DB-ICH4
2000-207f : 0000:00:1f.6
  2000-207f : Intel 82801DB-ICH4 Modem
2400-24ff : 0000:00:1f.6
  2400-24ff : Intel 82801DB-ICH4 Modem
3000-3fff : PCI Bus #01
  3000-30ff : 0000:01:00.0
4000-4fff : PCI Bus #02
  4000-40ff : PCI CardBus #03
  4400-44ff : PCI CardBus #03
  4800-48ff : PCI CardBus #07
  4c00-4cff : PCI CardBus #07

more /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cefff : Video ROM
000cf000-000cffff : Adapter ROM
000d0000-000d17ff : Adapter ROM
000d8000-000dffff : reserved
000f0000-000fffff : System ROM
00100000-7ff6ffff : System RAM
  00100000-00297c08 : Kernel code
  00297c09-003109fb : Kernel data
7ff70000-7ff7afff : ACPI Tables
7ff7b000-7ff7ffff : ACPI Non-volatile Storage
7ff80000-7fffffff : reserved
88000000-8cffffff : PCI Bus #02
  88000000-89ffffff : PCI CardBus #03
  8a000000-8bffffff : PCI CardBus #07
  8c000000-8c00ffff : 0000:02:05.0
8d000000-8d0003ff : 0000:00:1f.1
8e000000-8fffffff : PCI CardBus #03
90000000-91ffffff : PCI CardBus #07
d0000000-d00003ff : 0000:00:1d.7
  d0000000-d00003ff : ehci_hcd
d0000800-d00008ff : 0000:00:1f.5
  d0000800-d00008ff : Intel 82801DB-ICH4
d0000c00-d0000dff : 0000:00:1f.5
  d0000c00-d0000dff : Intel 82801DB-ICH4
d0100000-d01fffff : PCI Bus #01
  d0100000-d010ffff : 0000:01:00.0
    d0100000-d010ffff : radeonfb mmio
  d0120000-d013ffff : 0000:01:00.0
d0200000-d02fffff : PCI Bus #02
  d0200000-d0201fff : 0000:02:05.0
    d0200000-d0201fff : b44
  d0202000-d0202fff : 0000:02:06.0
    d0202000-d0202fff : ipw2200
  d0203000-d02037ff : 0000:02:09.2
    d0203000-d02037ff : ohci1394
  d0204000-d0204fff : 0000:02:09.0
    d0204000-d0204fff : yenta_socket
  d0205000-d0205fff : 0000:02:09.1
    d0205000-d0205fff : yenta_socket
d8000000-dfffffff : PCI Bus #01
  d8000000-dfffffff : 0000:01:00.0
    d8000000-dfffffff : radeonfb framebuffer
e0000000-efffffff : 0000:00:00.0
ff800000-ffbfffff : reserved
fffff000-ffffffff : reserved

lspci -vvv
00:00.0 Host bridge: Intel Corporation 82855PM Processor to I/O
Controller (rev 21)
        Subsystem: Wistron Corp. Unknown device 4010
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [e4] Vendor Specific Information
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW-
Rate=x4

00:01.0 PCI bridge: Intel Corporation 82855PM Processor to AGP
Controller (rev 21) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 96
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: d0100000-d01fffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Wistron Corp. Unknown device 4006
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Wistron Corp. Unknown device 4006
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Wistron Corp. Unknown device 4006
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 11
        Region 4: I/O ports at 1840 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2
EHCI Controller (rev 03) (prog-if 20 [EHCI])
        Subsystem: Wistron Corp. Unknown device 1071
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 10
        Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 83)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort+
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=0a, sec-latency=32
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: d0200000-d02fffff
        Prefetchable memory behind bridge: 88000000-8cffffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface
Bridge (rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE
Controller (rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: Wistron Corp. Unknown device 4006
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 1860 [size=16]
        Region 5: Memory at 8d000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
SMBus Controller (rev 03)
        Subsystem: Wistron Corp. Unknown device 4006
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at 1880 [size=32]

00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
        Subsystem: Wistron Corp. Unknown device 2005
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at 1c00 [size=256]
        Region 1: I/O ports at 18c0 [size=64]
        Region 2: Memory at d0000c00 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at d0000800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
        Subsystem: Wistron Corp. Unknown device 1069
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at 2400 [size=256]
        Region 1: I/O ports at 2000 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility
Radeon 9600 M10] (prog-if 00 [VGA])
        Subsystem: Wistron Corp. Unknown device 2061
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 3000 [size=256]
        Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
        [virtual] Expansion ROM at d0120000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=80 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit-
FW- Rate=x4
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
        Subsystem: Wistron Corp. Unknown device 1082
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d0200000 (32-bit, non-prefetchable) [size=8K]
        [virtual] Expansion ROM at 8c000000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:06.0 Network controller: Intel Corporation PRO/Wireless 2200BG
Network Connection (rev 05)
        Subsystem: Intel Corporation Unknown device 2702
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (750ns min, 6000ns max), Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d0202000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-

02:09.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
        Subsystem: Wistron Corp. Unknown device 3301
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d0204000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 88000000-89fff000 (prefetchable)
        Memory window 1: 8e000000-8ffff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001

02:09.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
        Subsystem: Wistron Corp. Unknown device 3301
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at d0205000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: 8a000000-8bfff000 (prefetchable)
        Memory window 1: 90000000-91fff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001

02:09.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller
(rev 04) (prog-if 10 [OHCI])
        Subsystem: Wistron Corp. Unknown device 107a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin C routed to IRQ 10
        Region 0: Memory at d0203000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME+


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFP7xARvQAQ6Awr6YRAkmMAKC4aqOIECU0eSTWKkrh+D2As8J8FACfec2o
Qii3KdY6eZHPGSbZR3pU3is=
=4PDG
-----END PGP SIGNATURE-----
