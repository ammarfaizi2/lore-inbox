Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTLCKWg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 05:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbTLCKWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 05:22:35 -0500
Received: from abyss.devicen.de ([217.6.173.34]:39907 "EHLO abyss.devicen.de")
	by vger.kernel.org with ESMTP id S262086AbTLCKWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 05:22:04 -0500
Message-ID: <3FCDB729.2000909@devicen.de>
Date: Wed, 03 Dec 2003 11:12:57 +0100
From: Oliver Teuber <teuber@devicen.de>
Organization: DEVICE/N GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20030821
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com, davem@redhat.com, linux-net@vger.kernel.org
Subject: [OOPS]: daily oops, kernel 2.4.23, networking, appletalk 
References: <3FCC664A.8020107@devicen.de>
In-Reply-To: <3FCC664A.8020107@devicen.de>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010002070006060101030607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010002070006060101030607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[1.] One line summary of the problem:
daily Oops / crash of the server

[2.] Full description of the problem/report:
the server locks up whit an oops every day.

[3.] Keywords (i.e., modules, networking, kernel):
socket, kernel, appletalk

[4.] Kernel version (from /proc/version):
Linux version 2.4.23 (root@server) (gcc version 3.3.1 (SuSE Linux)) #1 
Mon Dec 1 11:47:18 GMT 2003

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
two oops traces attached ...

[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux server 2.4.23 #1 Mon Dec 1 11:47:18 GMT 2003 i686 i686 i386 GNU/Linux

Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.25
e2fsprogs              1.34
jfsutils               1.1.2
PPP                    2.4.1
isdn4k-utils           3.3
Linux C Library        x    1 root     root      1461208 Sep 24 00:05 
/lib/i686/libc.so.6
Dynamic linker (ldd)   2.3.2
Procps                 3.1.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         appletalk usbserial thermal processor fan button 
battery ac st sr_mod sg keybdev mousedev joydev evdev input uhci 
ehci-hcd usbcore raw1394 ieee1394 e100 ext3 jbd loop lvm-mod md reiserfs 
aic7xxx sd_mod scsi_mod

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.53GHz
stepping        : 7
cpu MHz         : 2544.188
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
bogomips        : 5072.48

[7.3.] Module information (from /proc/modules):
appletalk              22212  20
usbserial              19900   0 (autoclean) (unused)
thermal                 6084   0 (unused)
processor               8216   0 [thermal]
fan                     1472   0 (unused)
button                  2412   0 (unused)
battery                 5632   0 (unused)
ac                      1664   0 (unused)
st                     30936   0 (autoclean)
sr_mod                 15864   0 (autoclean) (unused)
sg                     33788   0 (autoclean)
keybdev                 1828   0 (unused)
mousedev                4404   0 (unused)
joydev                  6144   0 (unused)
evdev                   4128   0 (unused)
input                   3520   0 [keybdev mousedev joydev evdev]
uhci                   26300   0 (unused)
ehci-hcd               18284   0 (unused)
usbcore                64844   1 [usbserial uhci ehci-hcd]
raw1394                19288   0 (unused)
ieee1394              188132   0 [raw1394]
e100                   50216   1
ext3                   65540   2 (autoclean)
jbd                    42196   2 (autoclean) [ext3]
loop                    9208   0 (autoclean)
lvm-mod                60512   0 (autoclean)
md                     60128   0 (autoclean)
reiserfs              190416   1
aic7xxx               153328   2
sd_mod                 12012   4
scsi_mod               99872   5 [st sr_mod sg aic7xxx sd_mod]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
a400-a43f : Intel Corp. 82801DB AC'97 Audio Controller
a800-a8ff : Intel Corp. 82801DB AC'97 Audio Controller
b400-b4ff : Adaptec AHA-2940U/UW/D / AIC-7881U
b800-b83f : Intel Corp. 82801BD PRO/100 VE (CNR) Ethernet Controller
  b800-b83f : e100
d400-d41f : Intel Corp. 82801DB USB (Hub #2)
  d400-d41f : usb-uhci
d800-d81f : Intel Corp. 82801DB USB (Hub #1)
  d800-d81f : usb-uhci
f000-f00f : Intel Corp. 82801DB Ultra ATA Storage Controller
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000d2fff : Extension ROM
000f0000-000fffff : System ROM
00100000-0fef9fff : System RAM
  00100000-00285364 : Kernel code
  00285365-0030ff63 : Kernel data
0fefa000-0fefcfff : ACPI Tables
0fefd000-0fefdfff : ACPI Non-volatile Storage
0fefe000-0fefffff : reserved
10000000-100003ff : Intel Corp. 82801DB Ultra ATA Storage Controller
e4800000-e48000ff : Intel Corp. 82801DB AC'97 Audio Controller
e5000000-e50001ff : Intel Corp. 82801DB AC'97 Audio Controller
e5800000-e5800fff : Adaptec AHA-2940U/UW/D / AIC-7881U
  e5800000-e5800fff : aic7xxx
e6000000-e6000fff : Intel Corp. 82801BD PRO/100 VE (CNR) Ethernet Controller
  e6000000-e6000fff : e100
e6800000-e68003ff : Intel Corp. 82801DB USB2
  e6800000-e68003ff : ehci_hcd
e7000000-e707ffff : Intel Corp. 82845G/GL [Brookdale-G] Chipset 
Integrated Graphics Device
e8000000-efffffff : Intel Corp. 82845G/GL [Brookdale-G] Chipset 
Integrated Graphics Device
  e8000000-e80cffff : vesafb
f0000000-f7ffffff : Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved
server:/usr/src/linux/scripts #

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host 
Bridge (rev 01)
        Subsystem: Asustek Computer, Inc.: Unknown device 8093
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [e4] #09 [0105]

00:02.0 VGA compatible controller: Intel Corp. 82845G/GL [Brookdale-G] 
Chipset Integrated Graphics Device (rev 01) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc.: Unknown device 2562
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at e7000000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01) 
(prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8089
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at d800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01) 
(prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8089
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at d400 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 01) (prog-if 20 
[EHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8089
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 23
        Region 0: Memory at e6800000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 81) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: e5800000-e67fffff
        Prefetchable memory behind bridge: e7f00000-e7ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DB LPC Interface Controller (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DB Ultra ATA Storage Controller 
(rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 8089
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at f000 [size=16]
        Region 5: Memory at 10000000 (32-bit, non-prefetchable) [size=1K]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio 
Controller (rev 01)
        Subsystem: Asustek Computer, Inc.: Unknown device 8095
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 17
        Region 0: I/O ports at a800 [size=256]
        Region 1: I/O ports at a400 [size=64]
        Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at e4800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:08.0 Ethernet controller: Intel Corp. 82801BD PRO/100 VE (CNR) 
Ethernet Controller (rev 81)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at e6000000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at b800 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:0b.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 23
        Region 0: I/O ports at b400 [disabled] [size=256]
        Region 1: Memory at e5800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: IFT      Model: IFT-7250         Rev: 0221
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: QUANTUM  Model: DLT8000          Rev: 0255
  Type:   Sequential-Access                ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
Helios Ethershare offer file and print-services to max. 20
apple macs (MacOS 9).

[X.] Other notes, patches, fixes, workarounds:


--------------010002070006060101030607
Content-Type: text/plain;
 name="oops-2423-20031203.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops-2423-20031203.txt"

ksymoops 2.4.9 on i686 2.4.23.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23/ (default)
     -m /usr/src/linux/System.map (default)

Reading Oops report from the terminal
Oops: 0000
CPU:    0
EIP:    0010:[<c0119780>]     Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: c86ef23c   ebx: 00000000  ecx: 00000001  edx: 00000001
esi: ce074e80   edi: c86ef23c  ebp: cee19f40  esp: cee19f28
ds: 0018   es: 0018   ss: 0018
Process if (pid: 4571, stackpage=cee19000)
Stack: 00000001 00000286 00000001 cd876c80 ce074e80 00000000 00000046 c02282d4
       00001000 00000000 00000202 cd876c80 c022789b cd876c80 cb01ca80 c02288d1
       ce074e80 cfcbcd60 fffffffd c022c7cb ce074e80 cee19fc4 00000001 c033aa88
Call Trace:    [<c02282d4>] [<c022789b>] [<c02288d1>] [<c022c7cb>] [<c0120bb1>]
  [<c010aa19>] [<c010cf18>]
Code: 8b 13 0f 18 02 39 c3 74 76 8d b4 26 00 00 00 00 8b 4b fc 8b


>>EIP; c0119780 <__wake_up+20/b0>   <=====

>>eax; c86ef23c <_end+83800e8/1057bf0c>
>>esi; ce074e80 <_end+dd05d2c/1057bf0c>
>>edi; c86ef23c <_end+83800e8/1057bf0c>
>>ebp; cee19f40 <_end+eaaadec/1057bf0c>
>>esp; cee19f28 <_end+eaaadd4/1057bf0c>

Trace; c02282d4 <sock_def_write_space+64/90>
Trace; c022789b <sock_wfree+3b/40>
Trace; c02288d1 <__kfree_skb+41/100>
Trace; c022c7cb <net_tx_action+2b/b0>
Trace; c0120bb1 <do_softirq+51/a0>
Trace; c010aa19 <do_IRQ+99/b0>
Trace; c010cf18 <call_do_IRQ+5/d>

Code;  c0119780 <__wake_up+20/b0>
00000000 <_EIP>:
Code;  c0119780 <__wake_up+20/b0>   <=====
   0:   8b 13                     mov    (%ebx),%edx   <=====
Code;  c0119782 <__wake_up+22/b0>
   2:   0f 18 02                  prefetchnta (%edx)
Code;  c0119785 <__wake_up+25/b0>
   5:   39 c3                     cmp    %eax,%ebx
Code;  c0119787 <__wake_up+27/b0>
   7:   74 76                     je     7f <_EIP+0x7f>
Code;  c0119789 <__wake_up+29/b0>
   9:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c0119790 <__wake_up+30/b0>
  10:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx
Code;  c0119793 <__wake_up+33/b0>
  13:   8b 00                     mov    (%eax),%eax

 <0>Kernel panic: Aiee, killing interrupt handler!

--------------010002070006060101030607
Content-Type: text/plain;
 name="oops-2423-20031202.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops-2423-20031202.txt"

ksymoops 2.4.9 on i686 2.4.23.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23/ (default)
     -m /usr/src/linux/System.map (default)

Reading Oops report from the terminal
Oops: 0000
CPU:    0
EIP:    0010:[<c0119780>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: c83a643c   ebx: 00000000   ecx: 00000001   edx: 00000001
esi: ce6d2980   edi: c83a643c   ebp: cdb61a6c   esp: cdb61a54
ds: 0018   es: 0018   ss: 0018
Process lpd (pid: 4136, stackpage=cdb61000)
Stack: 00000001 00000286 00000001 c41c1680 ce6d2980 00000000 00000046 c02282d4
       cfca1400 00000000 00000202 c41c1680 c022789b c41c1680 c8c9b180 c02288d1
       ce6d2980 cfca1560 fffffffd c022c7cb ce6d2980 cdb61af0 00000001 c033aa88
Call Trace:    [<c02282d4>] [<c022789b>] [<c02288d1>] [<c022c7cb>] [<c0120bb1>]
  [<c010aa19>] [<c010cf18>] [<d094c782>] [<d094cbe4>] [<d094c3c0>] [<d094d048>]
  [<d094ead2>] [<d094f0f2>] [<d095e82f>] [<d093d719>] [<d095e83d>] [<d0955057>]
  [<d093ebd0>] [<d095e83d>] [<c0150356>] [<c013e224>] [<c013cd7d>] [<c013ce0b>]
  [<c0108f27>]
Code: 8b 13 0f 18 02 39 c3 74 76 8d b4 26 00 00 00 00 8b 4b fc 8b


>>EIP; c0119780 <__wake_up+20/b0>   <=====

>>eax; c83a643c <_end+80372e8/1057bf0c>
>>esi; ce6d2980 <_end+e36382c/1057bf0c>
>>edi; c83a643c <_end+80372e8/1057bf0c>
>>ebp; cdb61a6c <_end+d7f2918/1057bf0c>
>>esp; cdb61a54 <_end+d7f2900/1057bf0c>

Trace; c02282d4 <sock_def_write_space+64/90>
Trace; c022789b <sock_wfree+3b/40>
Trace; c02288d1 <__kfree_skb+41/100>
Trace; c022c7cb <net_tx_action+2b/b0>
Trace; c0120bb1 <do_softirq+51/a0>
Trace; c010aa19 <do_IRQ+99/b0>
Trace; c010cf18 <call_do_IRQ+5/d>
Trace; d094c782 <[reiserfs]comp_keys+362/3f0>
Trace; d094cbe4 <[reiserfs]is_tree_node+64/70>
Trace; d094c3c0 <[reiserfs]__constant_memcpy+c0/120>
Trace; d094d048 <[reiserfs]search_for_position_by_key+f8/4c0>
Trace; d094ead2 <[reiserfs]reiserfs_cut_from_item+222/4b0>
Trace; d094f0f2 <[reiserfs]reiserfs_do_truncate+322/580>
Trace; d095e82f <[reiserfs].rodata.end+5ab0/5ca1>
Trace; d093d719 <[reiserfs]reiserfs_truncate_file+e9/230>
Trace; d095e83d <[reiserfs].rodata.end+5abe/5ca1>
Trace; d0955057 <[reiserfs]journal_end+27/30>
Trace; d093ebd0 <[reiserfs]reiserfs_file_release+3a0/450>
Trace; d095e83d <[reiserfs].rodata.end+5abe/5ca1>
Trace; c0150356 <locks_remove_flock+76/80>
Trace; c013e224 <fput+114/120>
Trace; c013cd7d <filp_close+4d/90>
Trace; c013ce0b <sys_close+4b/60>
Trace; c0108f27 <system_call+33/38>

Code;  c0119780 <__wake_up+20/b0>
00000000 <_EIP>:
Code;  c0119780 <__wake_up+20/b0>   <=====
   0:   8b 13                     mov    (%ebx),%edx   <=====
Code;  c0119782 <__wake_up+22/b0>
   2:   0f 18 02                  prefetchnta (%edx)
Code;  c0119785 <__wake_up+25/b0>
   5:   39 c3                     cmp    %eax,%ebx
Code;  c0119787 <__wake_up+27/b0>
   7:   74 76                     je     7f <_EIP+0x7f>
Code;  c0119789 <__wake_up+29/b0>
   9:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c0119790 <__wake_up+30/b0>
  10:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx
Code;  c0119793 <__wake_up+33/b0>
  13:   8b 00                     mov    (%eax),%eax

 <0>Kernel panic: Aiee, killing interrupt handler!

--------------010002070006060101030607--

