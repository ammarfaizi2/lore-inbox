Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVEJCU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVEJCU1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 22:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVEJCU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 22:20:26 -0400
Received: from smtp.wizwire.com ([209.218.100.6]:16601 "EHLO smtp.wizwire.com")
	by vger.kernel.org with ESMTP id S261458AbVEJCTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 22:19:50 -0400
Message-ID: <42801AEE.5080308@lakeinfoworks.com>
Date: Mon, 09 May 2005 19:22:38 -0700
From: Alan Lake <alan.lake@lakeinfoworks.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Mouse pad doesn't work
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-WizWire-MailScanner-Information: Please contact the ISP for more information
X-WizWire-MailScanner: Found to be clean
X-MailScanner-From: alan.lake@lakeinfoworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following comes from 
www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html

[1.] One line summary of the problem:

Tapping on the mouse pad of my laptop does not work.
 
[2.] Full description of the problem/report:
Clicking on the keys of my mouse pad works OK.  
Tapping on the mouse pad does not work.

[3.] Keywords (i.e., modules, networking, kernel):
Mouse
[4.] Kernel version (from /proc/version):
Linux version 2.6.11-1.14_FC3 (bhcompile@bugs.build.redhat.com) (gcc version 3.4.3 20050227 (Red Hat 3.4.3-22)) #1 Thu Apr 7 19:23:49 EDT 2005

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
n/a

[6.] A small shell script or example program which triggers the
     problem (if possible)
not possible

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux ontario.lakeinfoworks.com 2.6.11-1.14_FC3 #1 Thu Apr 7 19:23:49 EDT 2005 i686 i686 i386 GNU/Linux

Gnu C                  3.4.3

Gnu make               3.80

binutils               2.15.92.0.2

util-linux             2.12a

mount                  2.12a

module-init-tools      3.1-pre5

e2fsprogs              1.36

jfsutils               1.1.7

reiserfsprogs          3.6.18

reiser4progs           line

xfsprogs               2.6.13

pcmcia-cs              3.2.7

quota-tools            3.12.

PPP                    2.4.2

isdn4k-utils           3.3

nfs-utils              1.0.6

Linux C Library        2.3.5

Dynamic linker (ldd)   2.3.5

Procps                 3.2.3

Net-tools              1.60

Kbd                    1.12

Sh-utils               5.2.1

udev                   039

Modules Loaded         ppp_deflate zlib_deflate ppp_async crc_ccitt
ppp_generic slhc parport_pc lp parport autofs4 sunrpc serial_cs pcmcia
iptable_nat iptable_mangle ipt_REJECT ipt_state ip_conntrack ipt_LOG
iptable_filter ip_tables md5 ipv6 cdc_acm visor usbserial yenta_socket
rsrc_nonstatic pcmcia_core uhci_hcd i2c_piix4 i2c_core snd_es1968
snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer
snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd
soundcore floppy dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 801.909
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1585.15

[7.3.] Module information (from /proc/modules):
ppp_deflate 5953 0 - Live 0xd8a7e000
zlib_deflate 21721 1 ppp_deflate, Live 0xd8abd000
ppp_async 13249 1 - Live 0xd8a84000
crc_ccitt 2113 1 ppp_async, Live 0xd8989000
ppp_generic 39509 6 ppp_deflate,ppp_async, Live 0xd8a60000
slhc 7105 1 ppp_generic, Live 0xd8a5d000
parport_pc 28421 1 - Live 0xd8a76000
lp 12489 0 - Live 0xd89a5000
parport 40201 2 parport_pc,lp, Live 0xd8a6b000
autofs4 26181 0 - Live 0xd89b3000
sunrpc 164485 1 - Live 0xd8a8c000
serial_cs 9033 1 - Live 0xd89a1000
pcmcia 26465 5 serial_cs, Live 0xd89ab000
iptable_nat 21661 0 - Live 0xd899a000
iptable_mangle 2753 0 - Live 0xd8900000
ipt_REJECT 7105 1 - Live 0xd8978000
ipt_state 1857 3 - Live 0xd894c000
ip_conntrack 40601 2 iptable_nat,ipt_state, Live 0xd898f000
ipt_LOG 7489 4 - Live 0xd895c000
iptable_filter 2881 1 - Live 0xd885f000
ip_tables 19777 6 iptable_nat,iptable_mangle,ipt_REJECT,ipt_state,ipt_LOG,iptable_filter, Live 0xd897c000
md5 4161 1 - Live 0xd8947000
ipv6 259201 14 - Live 0xd89bb000
cdc_acm 13409 0 - Live 0xd8969000
visor 19661 0 - Live 0xd8956000
usbserial 28713 1 visor, Live 0xd8960000
yenta_socket 21065 3 - Live 0xd894f000
rsrc_nonstatic 10433 1 yenta_socket, Live 0xd88fc000
pcmcia_core 47993 4 serial_cs,pcmcia,yenta_socket,rsrc_nonstatic, Live 0xd88e4000
uhci_hcd 33497 0 - Live 0xd893d000
i2c_piix4 8657 0 - Live 0xd88d4000
i2c_core 21953 1 i2c_piix4, Live 0xd88a5000
snd_es1968 40385 2 - Live 0xd88f1000
snd_ac97_codec 71097 1 snd_es1968, Live 0xd892a000
snd_pcm_oss 51953 0 - Live 0xd891c000
snd_mixer_oss 18241 2 snd_pcm_oss, Live 0xd88ce000
snd_pcm 99657 3 snd_es1968,snd_ac97_codec,snd_pcm_oss, Live 0xd8902000
snd_timer 33093 1 snd_pcm, Live 0xd88da000
snd_page_alloc 9669 2 snd_es1968,snd_pcm, Live 0xd886a000
gameport 5057 1 snd_es1968, Live 0xd885c000
snd_mpu401_uart 10049 1 snd_es1968, Live 0xd8858000
snd_rawmidi 28641 1 snd_mpu401_uart, Live 0xd8862000
snd_seq_device 8781 1 snd_rawmidi, Live 0xd8854000
snd 56741 11 snd_es1968,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xd8896000
soundcore 10785 2 snd, Live 0xd883f000
floppy 64753 0 - Live 0xd8885000
dm_snapshot 17669 0 - Live 0xd8839000
dm_zero 2497 0 - Live 0xd8815000
dm_mirror 25773 0 - Live 0xd8831000
ext3 131145 2 - Live 0xd88ac000
jbd 82777 1 ext3, Live 0xd886f000
dm_mod 59221 6 dm_snapshot,dm_zero,dm_mirror, Live 0xd8844000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
/proc/ioports
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
02f8-02ff : pcmcia_socket1
  02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-103f : 0000:00:07.3
1100-110f : 0000:00:07.1
  1100-1107 : ide0
  1108-110f : ide1
1400-141f : 0000:00:07.3
  1400-1407 : piix4-smbus
3100-31ff : 0000:00:10.0
  3100-31ff : ESS Maestro
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02
4800-48ff : PCI CardBus #06
4c00-4cff : PCI CardBus #06
8000-9fff : PCI Bus #01
  8000-80ff : 0000:01:00.0
f300-f31f : 0000:00:07.2
  f300-f31f : uhci_hcd

/proc/iomem
00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000cffff : Video ROM
000e2000-000e27ff : Adapter ROM
000e3000-000e3fff : Adapter ROM
000e7000-000e7fff : Adapter ROM
000f0000-000fffff : System ROM
00100000-17ffffff : System RAM
  00100000-00366683 : Kernel code
  00366684-004123ff : Kernel data
18000000-18000fff : 0000:00:0a.0
  18000000-18000fff : yenta_socket
18001000-18001fff : 0000:00:0a.1
  18001000-18001fff : yenta_socket
18400000-187fffff : PCI CardBus #02
18800000-18bfffff : PCI CardBus #02
18c00000-18ffffff : PCI CardBus #06
19000000-193fffff : PCI CardBus #06
60000000-60000fff : pcmcia_socket1
a0000000-a3ffffff : 0000:00:00.0
d0000000-d7ffffff : PCI Bus #01
d8000000-dfffffff : PCI Bus #01
  d8000000-d8ffffff : 0000:01:00.0
  d9000000-d9000fff : 0000:01:00.0

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at a0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00008000-00009fff
        Memory behind bridge: d8000000-dfffffff
        Prefetchable memory behind bridge: d0000000-d7ffffff
        Secondary status: 66Mhz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at 1100 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 240
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at f300 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0a.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
        Subsystem: CLEVO/KAPOK Computer: Unknown device 3102
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size 20
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 18000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 18400000-187ff000 (prefetchable)
        Memory window 1: 18800000-18bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

00:0a.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
        Subsystem: CLEVO/KAPOK Computer: Unknown device 3102
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size 20
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at 18001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
        Memory window 0: 18c00000-18fff000 (prefetchable)
        Memory window 1: 19000000-193ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

00:10.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)
        Subsystem: CLEVO/KAPOK Computer: Unknown device 3102
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 3100 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage LT Pro AGP-133 (rev dc) (prog-if 00 [VGA])
        Subsystem: CLEVO/KAPOK Computer: Unknown device 3102
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (2000ns min)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d8000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 8000 [size=256]
        Region 2: Memory at d9000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 000c0000 [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
not present

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:
kernel 2.6.10-1.766_FC3 works OK

Please feel free to contact me if I can provide you with any more information.

Alan





