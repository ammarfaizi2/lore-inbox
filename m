Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290565AbSBKWUO>; Mon, 11 Feb 2002 17:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290551AbSBKWUH>; Mon, 11 Feb 2002 17:20:07 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:43947 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S290550AbSBKWTt>; Mon, 11 Feb 2002 17:19:49 -0500
Message-ID: <3C6842E3.181C9D7C@kioskdu.com>
Date: Mon, 11 Feb 2002 23:17:07 +0100
From: axel <axel@kioskdu.com>
Reply-To: axel@kioskdu.com
Organization: private
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.4-4GB i686)
X-Accept-Language: en, de, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Unbknown / uncomprehensible bug reported
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Message from xconsole:
Feb 11 11:08:26 darkstar pppoe[547]: Linux select bug hit!  This message
is harmless, but please ask the Linux kernel developers to fix it.


src/linux> sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes. 
Linux darkstar 2.4.4-4GB #1 Wed May 16 00:37:55 GMT 2001 i686 unknown 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.91.0.4
util-linux             2.11b
mount                  2.11b
modutils               2.4.5
e2fsprogs              1.19
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.25
PPP                    2.4.0
Linux C Library        x    1 root     root      1341670 Dec 18 16:50
/lib/libc.so.6
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded         snd-pcm-oss snd-pcm-plugin snd-mixer-oss tuner
tvaudio msp3400 bttv i2c-algo-bit i2c-core videodev ipv6 af_packet
n_hdlc ppp_synctty ppp_async ppp_generic snd-card-via686a snd-pcm
snd-timer snd-ac97-codec snd-mixer snd-mpu401-uart snd-rawmidi
snd-seq-device snd soundcore parport_pc lp parport printer mousedev hid
input usb-uhci usbcore ipchains 3c90x rtl8139 tmscsim


cat /proc/version:
Linux version 2.4.4-4GB (root@Pentium.suse.de) (gcc version 2.95.3
20010315 (SuSE)) #1 Wed May 16 00:37:55 GMT 2001


src/linux> cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Athlon(tm) Processor
stepping        : 1
cpu MHz         : 935.979
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1867.77


src/linux> cat /proc/modules
snd-pcm-oss            18816   1 (autoclean)
snd-pcm-plugin         15024   0 (autoclean) [snd-pcm-oss]
snd-mixer-oss           5120   1 (autoclean) [snd-pcm-oss]
tuner                   4144   1 (autoclean)
tvaudio                 8064   0 (autoclean) (unused)
msp3400                13488   1 (autoclean)
bttv                   54800   0 (autoclean)
i2c-algo-bit            7200   1 (autoclean) [bttv]
i2c-core               12400   0 (autoclean) [tuner tvaudio msp3400 bttv
i2c-algo-bit]
videodev                4576   2 (autoclean) [bttv]
ipv6                  126272  -1 (autoclean)
af_packet              11648   2 (autoclean)
n_hdlc                  6256   1
ppp_synctty             5040   1
ppp_async               6480   0 (unused)
ppp_generic            14416   3 [ppp_synctty ppp_async]
snd-card-via686a        7328   2
snd-pcm                30560   0 [snd-pcm-oss snd-pcm-plugin
snd-card-via686a]
snd-timer               8560   0 [snd-pcm]
snd-ac97-codec         24576   0 [snd-card-via686a]
snd-mixer              24224   0 [snd-mixer-oss snd-ac97-codec]
snd-mpu401-uart         2512   0 [snd-card-via686a]
snd-rawmidi             9664   0 [snd-mpu401-uart]
snd-seq-device          4032   0 [snd-rawmidi]
snd                    34032   1 [snd-pcm-oss snd-pcm-plugin
snd-mixer-oss snd-card-via686a snd-pcm snd-timer snd-ac97-codec
snd-mixer snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               3632   4 [snd]
parport_pc             18480   1 (autoclean)
lp                      5392   0 (autoclean)
parport                24352   1 (autoclean) [parport_pc lp]
printer                 4960   0
mousedev                4032   0 (unused)
hid                    11760   0 (unused)
input                   3168   0 [mousedev hid]
usb-uhci               21840   0 (unused)
usbcore                47120   1 [printer hid usb-uhci]
ipchains               33408   0 (unused)
3c90x                  24256   1
rtl8139                11520   1
tmscsim                29888   0 (unused)


src/linux> cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0320-0321 : VIA 82C686A - MPU401
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0400-040f : PCI device 1106:3057
0778-077a : parport0
0800-08ff : PCI device 1106:3057
0c00-0c7f : PCI device 1106:3057
0cf8-0cff : PCI conf1
7000-8fff : PCI Bus #01
  8800-88ff : PCI device 1002:5046
b400-b47f : PCI device 10b7:9055
  b400-b47f : eth1
b800-b8ff : PCI device 10ec:8139
  b800-b8ff : 8139too
bc00-bc1f : PCI device 1106:3038
  bc00-bc1f : usb-uhci
c000-c01f : PCI device 1106:3038
  c000-c01f : usb-uhci
c400-c403 : PCI device 1106:3058
  c400-c403 : VIA 82C686A - MPU401 config
c800-c803 : PCI device 1106:3058
cc00-ccff : PCI device 1106:3058
  cc00-ccff : VIA 82C686A - AC'97
d000-d07f : PCI device 1022:2020
  d000-d07f : tmscsim
ffa0-ffaf : PCI device 1106:0571
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1


src/linux> cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-002327d1 : Kernel code
  002327d2-0031bdcb : Kernel data
0fff0000-0fff7fff : ACPI Tables
0fff8000-0fffffff : ACPI Non-volatile Storage
d7c00000-dfcfffff : PCI Bus #01
  d8000000-dbffffff : PCI device 1002:5046
dfdfc000-dfdfcfff : PCI device 109e:036e
  dfdfc000-dfdfcfff : bttv
dfdfd000-dfdfdfff : PCI device 109e:0878
dfe00000-dfefffff : PCI Bus #01
  dfefc000-dfefffff : PCI device 1002:5046
dffefe80-dffefeff : PCI device 10b7:9055
dffeff00-dffeffff : PCI device 10ec:8139
  dffeff00-dffeffff : 8139too
e0000000-e3ffffff : PCI device 1106:0691
ffff0000-ffffffff : reserved


darkstar /home/axel# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e0000000 (32-bit, prefetchable)
[size=64M]        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00007000-00008fff
        Memory behind bridge: dfe00000-dfefffff
        Prefetchable memory behind bridge: d7c00000-dfcfffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset-
FastB2B-         Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA
Bridge        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at ffa0 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at bc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at c000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 20)
        Subsystem: Giga-byte Technology: Unknown device a000
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 10
        Region 0: I/O ports at cc00 [size=256]
        Region 1: I/O ports at c800 [size=4]
        Region 2: I/O ports at c400 [size=4]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 SCSI storage controller: Advanced Micro Devices [AMD] 53c974
[PCscsi] (rev 10)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping+ SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d000 [size=128]
        Expansion ROM at dfff0000 [disabled] [size=64K]

00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at b800 [size=256]
        Region 1: Memory at dffeff00 (32-bit, non-prefetchable)
[size=256]
        Expansion ROM at dffd0000 [disabled] [size=64K]

00:0d.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at b400 [size=128]
        Region 1: Memory at dffefe80 (32-bit, non-prefetchable)
[size=128]
        Expansion ROM at dffa0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Multimedia video controller: Brooktree Corporation Bt878 (rev
02)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at dfdfc000 (32-bit, prefetchable) [size=4K] 
00:0f.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at dfdfd000 (32-bit, prefetchable) [size=4K] 
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF
(prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0014
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at d8000000 (32-bit, prefetchable)
[size=64M]        Region 1: I/O ports at 8800 [size=256]
        Region 2: Memory at dfefc000 (32-bit, non-prefetchable)
[size=16K]
        Expansion ROM at dfec0000 [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

darkstar /home/axel# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:50:FC:3C:0C:34
          inet addr:192.168.100.1  Bcast:192.168.100.255 
Mask:255.255.255.0
          inet6 addr: fe80::250:fcff:fe3c:c34/10 Scope:Link
          inet6 addr: fe80::50:fc3c:c34/10 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:417 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:0 (0.0 b)  TX bytes:100417 (98.0 Kb)
          Interrupt:9 Base address:0xdf00

eth1      Link encap:Ethernet  HWaddr 00:01:02:E0:AA:EF
          inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::1:2e0:aaef/10 Scope:Link
          inet6 addr: fe80::201:2ff:fee0:aaef/10 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:39528 errors:0 dropped:0 overruns:0 frame:0
          TX packets:41294 errors:0 dropped:0 overruns:0 carrier:0
          collisions:3 txqueuelen:100
          RX bytes:30614946 (29.1 Mb)  TX bytes:3013501 (2.8 Mb)
          Interrupt:10 Base address:0xb400

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:107 errors:0 dropped:0 overruns:0 frame:0
          TX packets:107 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:7630 (7.4 Kb)  TX bytes:7630 (7.4 Kb)
 
ppp0      Link encap:Point-to-Point Protocol
          inet addr:80.14.48.238  P-t-P:80.14.48.1  Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1492  Metric:1
          RX packets:11955 errors:14264 dropped:0 overruns:0 frame:0
          TX packets:12861 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:3
          RX bytes:5728423 (5.4 Mb)  TX bytes:754200 (736.5 Kb)


darkstar /home/axel# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: E.08
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: TEAC     Model: CD-R56S4         Rev: 1.0F
  Type:   CD-ROM


/var/log/messages:

Feb 11 11:07:06 darkstar pppd[546]: LCP terminated by peer
Feb 11 11:07:06 darkstar pppd[546]: cbcp_lowerdown
Feb 11 11:07:06 darkstar pppd[546]: Script /etc/ppp/ip-down started (pid
3603)
Feb 11 11:07:06 darkstar pppd[546]: sent [LCP TermAck id=0x65]
Feb 11 11:07:06 darkstar pppd[546]: Script /etc/ppp/ip-down finished
(pid 3603), status = 0x0
Feb 11 11:07:08 darkstar pppd[546]: Connection terminated.
Feb 11 11:07:08 darkstar pppd[546]: Connect time 1438.7 minutes.
Feb 11 11:07:08 darkstar pppd[546]: Sent 1086929 bytes, received 8413654
bytes.
Feb 11 11:07:08 darkstar pppd[546]: Couldn't release PPP unit:
Inappropriate ioctl for device
Feb 11 11:07:08 darkstar pppd[546]: Waiting for 1 child processes...
Feb 11 11:07:08 darkstar pppd[546]:   script /usr/sbin/pppoe -p
/var/run/pppoe.conf-adsl.pid.pppoe -I eth1 -T 80 -U -s -m 1412   , pid
547
Feb 11 11:08:26 darkstar pppoe[547]: Linux select bug hit!  This message
is harmless, but please ask the Linux kernel developers to fix it.
Feb 11 11:08:26 darkstar pppoe[547]: Sent PADT
Feb 11 11:08:26 darkstar pppd[546]: Script /usr/sbin/pppoe -p
/var/run/pppoe.conf-adsl.pid.pppoe -I eth1 -T 80 -U -s -m 1412   
finished (pid 547), status = 0x100
Feb 11 11:08:26 darkstar pppd[546]: Exit.
Feb 11 11:08:26 darkstar adsl-connect: ADSL connection lost; attempting
re-connection.
Feb 11 11:08:31 darkstar pppd[3652]: pppd 2.4.0 started by root, uid 0
Feb 11 11:08:31 darkstar pppd[3652]: using channel 2
Feb 11 11:08:31 darkstar pppd[3652]: Using interface ppp0
Feb 11 11:08:31 darkstar pppd[3652]: Connect: ppp0 <--> /dev/pts/0
Feb 11 11:08:31 darkstar pppoe[3653]: Changed pty line discipline to
N_HDLC for synchronous mode
Feb 11 11:08:31 darkstar pppoe[3653]: PADS: Service-Name: ''
Feb 11 11:08:31 darkstar pppoe[3653]: PPP session is 15442

Hope this helps, if not, contact me!

Axel
-- 
------------------------------
"Science is the game we play with god to find out his rules."
------------------------------
