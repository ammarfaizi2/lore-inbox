Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVGESEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVGESEJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 14:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVGESEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 14:04:09 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:51061 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261933AbVGESBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 14:01:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:content-type:date:message-id:mime-version:x-mailer;
        b=RCRGimgL0q9ud3k5dIlOr/sCIABME4eBfH8gI+WCdTNpT7PlE6VYpBk9d8IuD356IzPHNkYu+FWyFM8iLqXRNZI6lzm3wvd6uxYiFBYG0/N0iCw3w2SAgWDbocwJTlHu95XA6+DsMRBr4FzvzVbdsXg0oYPur8EszcSpZEys2dk=
Subject: PROBLEM: ALPS tap-to-click broken in v2.6.12
From: Gmail - Wel Eats Levity <wel.eats.levity@gmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bpVWoanEHhuXzyZjfBvz"
Date: Tue, 05 Jul 2005 16:14:46 +0200
Message-Id: <1120572886.6906.32.camel@mithrim.beleriand>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bpVWoanEHhuXzyZjfBvz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

[1.] Summary: ALPS tap-to-click driver ability is missing in Linux
2.6.12 under x.org.

[2.] Full description: Tap-to-click behaviour under x-windows is
expected with ALPS touchpad in a properly configured system. With 2.6.11
kernel version i've no problem. When i switch to 2.6.12, i found a bug
in the touchpad behaviour: double-tapping works as single tapping, and
there's not chance to use double-tapping as it was used to be.

[3.] Keywords: ALPS touchpad, X.org, event interface.

[4.] Kernel version: Linux version 2.6.12-nitro1 (root@mithrim) (gcc
versi=C3=B3n 3.4.3-20050110 (Gentoo 3.4.3.20050110-r2, ssp-3.4.3.20050110-0=
,
pie-8.7.7)) #5 Thu Jun 2 11:22:21 CEST 2005

[7.1.] Software:

Linux mithrim 2.6.12-nitro1 #5 Thu Jun 2 11:22:21 CEST 2005 i686 Mobile
Intel(R)  Pentium(R) 4 - M CPU 2.20GHz GenuineIntel GNU/Linux

Gnu C                  3.4.4
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12i
mount                  2.12i
module-init-tools      3.0
e2fsprogs              1.37
reiserfsprogs          line
reiser4progs           1.0.4
pcmcia-cs              3.2.8
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   058
Modules Loaded         isofs zlib_inflate pcmcia snd_seq snd_seq_device
snd_pcm_ oss snd_mixer_oss parport_pc parport 8250_pnp 8250 serial_core
eth1394 rtc psmou se ohci1394 ieee1394 yenta_socket rsrc_nonstatic
pcmcia_core b44 mii nvidia snd_ intel8x0m snd_intel8x0 snd_ac97_codec
snd_pcm snd_timer snd soundcore snd_page_a lloc ehci_hcd uhci_hcd evdev
usbcore cifs smbfs nls_iso8859_15 nls_utf8 nls_base  af_packet ide_cd
cdrom i8k video thermal processor fan container button battery  ac msr
non_fatal cpufreq_powersave cpufreq_performance cpufreq_ondemand speedst
ep_ich speedstep_lib freq_table

[7.2.] Processor information:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Mobile Intel(R) Pentium(R) 4 - M CPU 2.20GHz
stepping        : 9
cpu MHz         : 1196.728
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 2368.23

[7.3.] Module information:
isofs 35896 1 - Live 0xe0b2d000
zlib_inflate 18304 1 isofs, Live 0xe0af5000
pcmcia 25608 2 - Live 0xe0a63000
snd_seq 53648 0 - Live 0xe0a9d000
snd_seq_device 8716 1 snd_seq, Live 0xe0a5f000
snd_pcm_oss 54048 0 - Live 0xe0a8e000
snd_mixer_oss 20352 1 snd_pcm_oss, Live 0xe0a2a000
parport_pc 28484 0 - Live 0xe0a75000
parport 36808 1 parport_pc, Live 0xe0a6b000
8250_pnp 8704 0 - Live 0xe0a48000
8250 24700 1 8250_pnp, Live 0xe0a57000
serial_core 23168 1 8250, Live 0xe0a50000
eth1394 21000 0 - Live 0xe0a30000
rtc 12872 0 - Live 0xe0a01000
psmouse 28680 0 - Live 0xe09f8000
ohci1394 34564 0 - Live 0xe09bd000
ieee1394 108216 2 eth1394,ohci1394, Live 0xe09d2000
yenta_socket 22920 1 - Live 0xe0963000
rsrc_nonstatic 9472 1 yenta_socket, Live 0xe08f9000
pcmcia_core 48676 3 pcmcia,yenta_socket,rsrc_nonstatic, Live 0xe09a5000
b44 21892 0 - Live 0xe094e000
mii 5248 1 b44, Live 0xe08ab000
nvidia 3466044 14 - Live 0xe0d50000
snd_intel8x0m 18628 0 - Live 0xe08d4000
snd_intel8x0 33600 1 - Live 0xe0959000
snd_ac97_codec 76024 2 snd_intel8x0m,snd_intel8x0, Live 0xe0982000
snd_pcm 93960 4 snd_pcm_oss,snd_intel8x0m,snd_intel8x0,snd_ac97_codec,
Live 0xe096a000
snd_timer 25988 2 snd_seq,snd_pcm, Live 0xe08dd000
snd 54116 11
snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_intel8x0m,snd_intel8x0=
,snd_ac97_codec,snd_pcm,snd_timer, Live 0xe08e6000
soundcore 10080 1 snd, Live 0xe08a4000
snd_page_alloc 9988 3 snd_intel8x0m,snd_intel8x0,snd_pcm, Live
0xe0879000
ehci_hcd 33160 0 - Live 0xe08ca000
uhci_hcd 32016 0 - Live 0xe08c1000
evdev 9472 1 - Live 0xe089b000
usbcore 119032 3 ehci_hcd,uhci_hcd, Live 0xe092f000
cifs 200696 0 - Live 0xe08fd000
smbfs 67448 0 - Live 0xe08af000
nls_iso8859_15 4864 0 - Live 0xe0876000
nls_utf8 2304 1 - Live 0xe085e000
nls_base 7680 5 isofs,cifs,smbfs,nls_iso8859_15,nls_utf8, Live
0xe0870000
af_packet 22664 0 - Live 0xe0894000
ide_cd 40964 1 - Live 0xe0888000
cdrom 40096 1 ide_cd, Live 0xe087d000
i8k 6544 0 - Live 0xe0860000
video 16004 0 - Live 0xe086b000
thermal 13192 0 - Live 0xe084d000
processor 22708 1 thermal, Live 0xe0864000
fan 4740 0 - Live 0xe0859000
container 4608 0 - Live 0xe0856000
button 6800 0 - Live 0xe0847000
battery 9604 0 - Live 0xe0852000
ac 4996 0 - Live 0xe084a000
msr 3844 0 - Live 0xe0804000
non_fatal 2436 0 [permanent], Live 0xe0845000
cpufreq_powersave 1920 1 - Live 0xe0843000
cpufreq_performance 2304 0 - Live 0xe0806000
cpufreq_ondemand 6556 0 - Live 0xe0840000
speedstep_ich 5388 0 - Live 0xe083d000
speedstep_lib 4096 1 speedstep_ich, Live 0xe083b000
freq_table 4612 1 speedstep_ich, Live 0xe0838000

[7.4.] Loaded driver and hardware information:

/proc/ioports:
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
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
04d0-04d1 : pnp 00:01
0800-087f : 0000:00:1f.0
  0800-0803 : PM1a_EVT_BLK
  0804-0805 : PM1a_CNT_BLK
  0806-0807 : pnp 00:02
  0808-080b : PM_TMR
  0820-0820 : PM2_CNT_BLK
  0828-082f : GPE0_BLK
  0860-087f : pnp 00:02
0880-08bf : 0000:00:1f.0
  0880-08bf : pnp 00:02
08c0-08df : pnp 00:02
08e0-08e5 : ACPI CPU throttle
0900-097f : pnp 00:07
0cf8-0cff : PCI conf1
4000-40ff : PCI CardBus #03
4400-44ff : PCI CardBus #03
b080-b0ff : 0000:00:1f.6
  b080-b0ff : Intel 82801DB-ICH4 Modem
b400-b4ff : 0000:00:1f.6
  b400-b4ff : Intel 82801DB-ICH4 Modem
b800-b8ff : 0000:00:1f.5
  b800-b8ff : Intel 82801DB-ICH4
bc40-bc7f : 0000:00:1f.5
  bc40-bc7f : Intel 82801DB-ICH4
bf20-bf3f : 0000:00:1d.2
  bf20-bf3f : uhci_hcd
bf40-bf5f : 0000:00:1d.1
  bf40-bf5f : uhci_hcd
bf80-bf9f : 0000:00:1d.0
  bf80-bf9f : uhci_hcd
bfa0-bfaf : 0000:00:1f.1
  bfa0-bfa7 : ide0
  bfa8-bfaf : ide1
c000-cfff : PCI Bus #01
f400-f4fe : motherboard
  f400-f4fe : pnp 00:02

/proc/iomem:
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cf7ff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffadfff : System RAM
  00100000-002d68df : Kernel code
  002d68e0-0039337f : Kernel data
1ffae000-1fffffff : reserved
20000000-200003ff : 0000:00:1f.1
20001000-20001fff : 0000:02:01.0
  20001000-20001fff : yenta_socket
20400000-207fffff : PCI CardBus #03
20800000-20bfffff : PCI CardBus #03
ec000000-efffffff : 0000:00:00.0
f0000000-f3ffffff : PCI Bus #01
  f0000000-f3ffffff : 0000:01:00.0
f4fff400-f4fff4ff : 0000:00:1f.5
  f4fff400-f4fff4ff : Intel 82801DB-ICH4
f4fff800-f4fff9ff : 0000:00:1f.5
  f4fff800-f4fff9ff : Intel 82801DB-ICH4
f4fffc00-f4ffffff : 0000:00:1d.7
  f4fffc00-f4ffffff : ehci_hcd
faff8000-faffbfff : 0000:02:01.1
faffd800-faffdfff : 0000:02:01.1
  faffd800-faffdfff : ohci1394
faffe000-faffffff : 0000:02:00.0
  faffe000-faffffff : b44
fc000000-fdffffff : PCI Bus #01
  fc000000-fcffffff : 0000:01:00.0
    fc000000-fcffffff : nvidia
feda0000-fedfffff : reserved
ffb00000-ffffffff : reserved

[7.5.] PCI information:
0000:00:00.0 Host bridge: Intel Corporation 82845 845 (Brookdale)
Chipset Host Bridge (rev 04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at ec000000 (32-bit, prefetchable)
        Capabilities: [e4] #09 [d104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP+ GART64- 64bit- =
FW+
Rate=3Dx4

0000:00:01.0 PCI bridge: Intel Corporation 82845 845 (Brookdale) Chipset
AGP Bridge (rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fc000000-fdffffff
        Prefetchable memory behind bridge: f0000000-f3ffffff
        Expansion ROM at 0000c000 [disabled] [size=3D4K]
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation: Unknown device 4541
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at bf80 [size=3D32]

0000:00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation: Unknown device 4541
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at bf40 [size=3D32]

0000:00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation: Unknown device 4541
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 11
        Region 4: I/O ports at bf20 [size=3D32]

0000:00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M)
USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
        Subsystem: Dell: Unknown device 013e
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 11
        Region 0: Memory at f4fffc00 (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0
+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [58] #0a [2080]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev
83) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D=
32
        I/O behind bridge: 0000d000-0000efff
        Memory behind bridge: f6000000-fbffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC
Interface Bridge (rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE
Controller (rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: Intel Corporation: Unknown device 4541
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at bfa0 [size=3D16]
        Region 5: Memory at 20000000 (32-bit, non-prefetchable)
[size=3D1K]

0000:00:1f.5 Multimedia audio controller: Intel Corporation
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
        Subsystem: Dell: Unknown device 013e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 5
        Region 0: I/O ports at b800
        Region 1: I/O ports at bc40 [size=3D64]
        Region 2: Memory at f4fff800 (32-bit, non-prefetchable)
[size=3D512]
        Region 3: Memory at f4fff400 (32-bit, non-prefetchable)
[size=3D256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0
+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 03) (prog-if 00
[Generic])
        Subsystem: PCTel Inc: Unknown device 4c21
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 5
        Region 0: I/O ports at b400
        Region 1: I/O ports at b080 [size=3D128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0
+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:01:00.0 VGA compatible controller: nVidia Corporation NV28
[GeForce4 Ti 4200 Go AGP 8x] (rev a1) (prog-if 00 [VGA])
        Subsystem: Dell: Unknown device 0179
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fc000000 (32-bit, non-prefetchable)
[size=3D80000000]
        Region 1: Memory at f0000000 (32-bit, prefetchable) [size=3D64M]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D32 ArqSz=3D0 Cal=3D0 SBA- AGP+ GART64- 64bit-=
 FW
+ Rate=3Dx4

0000:02:00.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T
(rev 01)
        Subsystem: Dell: Unknown device 8127
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at faffe000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1
+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

0000:02:01.0 CardBus bridge: Texas Instruments PCI4510 PC card Cardbus
Controller (rev 02)
        Subsystem: Dell: Unknown device 013e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 20
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 20001000 (32-bit, non-prefetchable)
        Bus: primary=3D02, secondary=3D03, subordinate=3D06, sec-latency=3D=
176
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001

0000:02:01.1 FireWire (IEEE 1394): Texas Instruments PCI4510 IEEE-1394
Controller (prog-if 10 [OHCI])
        Subsystem: Dell: Unknown device 013e
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at faffd800 (32-bit, non-prefetchable)
        Region 1: Memory at faff8000 (32-bit, non-prefetchable)
[size=3D16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1
+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME+

[X.] Other information:
X.org version: 6.8.2
Synaptics driver version: 0.14.1

--=-bpVWoanEHhuXzyZjfBvz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCypXWVoxSEBOdyBERAoC1AJ4wEwnRKdz0CIuUH5tgLwtFx7HIAgCbBNDo
1f+CBVp+/VXdArGFWROvr1I=
=vxnF
-----END PGP SIGNATURE-----

--=-bpVWoanEHhuXzyZjfBvz--

