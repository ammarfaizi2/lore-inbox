Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbUBYGUq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 01:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbUBYGUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 01:20:46 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:50133 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262632AbUBYGUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 01:20:38 -0500
Message-ID: <403C3EB8.2070206@comcast.net>
Date: Tue, 24 Feb 2004 22:20:40 -0800
From: Miles Lane <miles.lane@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.3-bk6 -- (snd_intel8x0) ALSA sound/core/pcm_lib.c:233: Unexpected
 hw_pointer value [2] (stream = 0, delta: -1112, max jitter = 4456): wrong
 interrupt acknowledge?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Module                  Size  Used by
floppy                 63860  0
vfat                   15488  0
snd_pcm_oss            60516  1
nvidia               2075176  0
snd_mixer_oss          19968  1 snd_pcm_oss
snd_intel8x0           36996  1
snd_ac97_codec         67716  1 snd_intel8x0
snd_pcm               117284  2 snd_pcm_oss,snd_intel8x0
snd_timer              35076  1 snd_pcm
snd_page_alloc         10436  2 snd_intel8x0,snd_pcm
snd_mpu401_uart        10240  1 snd_intel8x0
snd_rawmidi            28832  1 snd_mpu401_uart
snd_seq_device          7816  1 snd_rawmidi
snd                    67588  9 snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               9248  2 snd
parport_pc             37292  1
lp                     10760  0
parport                44840  2 parport_pc,lp
nls_cp437               5568  0
autofs4                20800  0
af_packet              17736  0
nls_iso8859_1           3968  0
ntfs                  115536  0
msdos                  11136  0
fat                    48736  2 vfat,msdos
rtc                    20316  0

Linux oldfaithful 2.6.3-bk6 #6 Tue Feb 24 14:53:26 PST 2004 i686 GNU/Linux
Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.11x
module-init-tools      3.0-pre10
e2fsprogs              1.35-WIP
jfsutils               1.1.4
xfsprogs               2.6.3
pcmcia-cs              3.2.5
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.15
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         floppy vfat snd_pcm_oss nvidia snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore parport_pc lp parport nls_cp437 autofs4 af_packet nls_iso8859_1 ntfs msdos fat rtc

Feb 24 22:15:49 oldfaithful kernel: ALSA sound/core/pcm_lib.c:233: Unexpected hw_pointer value [2] (stream = 0, delta: -1112, max jitter = 4456): wrong interrupt acknowledge?
Feb 24 22:15:49 oldfaithful kernel: ALSA sound/core/pcm_lib.c:233: Unexpected hw_pointer value [2] (stream = 0, delta: -1110, max jitter = 4456): wrong interrupt acknowledge?
Feb 24 22:15:50 oldfaithful kernel: ALSA sound/core/pcm_lib.c:233: Unexpected hw_pointer value [2] (stream = 0, delta: -1108, max jitter = 4456): wrong interrupt acknowledge?
Feb 24 22:15:51 oldfaithful kernel: ALSA sound/core/pcm_lib.c:233: Unexpected hw_pointer value [2] (stream = 0, delta: -1108, max jitter = 4456): wrong interrupt acknowledge?
Feb 24 22:15:52 oldfaithful kernel: ALSA sound/core/pcm_lib.c:233: Unexpected hw_pointer value [2] (stream = 0, delta: -1106, max jitter = 4456): wrong interrupt acknowledge?

00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
       Subsystem: Asustek Computer, Inc.: Unknown device 80ac
       Flags: bus master, 66Mhz, fast devsel, latency 0
       Memory at e0000000 (32-bit, prefetchable) [size=128M]
       Capabilities: [40] AGP version 3.0
       Capabilities: [60] #08 [2001]

00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
       Subsystem: Asustek Computer, Inc.: Unknown device 80ac
       Flags: 66Mhz, fast devsel

00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
       Subsystem: Asustek Computer, Inc.: Unknown device 80ac
       Flags: 66Mhz, fast devsel

00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
       Subsystem: Asustek Computer, Inc.: Unknown device 80ac
       Flags: 66Mhz, fast devsel

00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
       Subsystem: Asustek Computer, Inc.: Unknown device 80ac
       Flags: 66Mhz, fast devsel

00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
       Subsystem: Asustek Computer, Inc.: Unknown device 80ac
       Flags: 66Mhz, fast devsel

00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
       Subsystem: Asustek Computer, Inc. A7N8X Mainboard
       Flags: bus master, 66Mhz, fast devsel, latency 0
       Capabilities: [48] #08 [01e1]

00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
       Subsystem: Asustek Computer, Inc.: Unknown device 0c11
       Flags: 66Mhz, fast devsel, IRQ 5
       I/O ports at e000 [size=32]
       Capabilities: [44] Power Management version 2

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
       Subsystem: Asustek Computer, Inc. A7N8X Mainboard
       Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 5
       Memory at ee087000 (32-bit, non-prefetchable) [size=4K]
       Capabilities: [44] Power Management version 2

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
       Subsystem: Asustek Computer, Inc. A7N8X Mainboard
       Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 11
       Memory at ee082000 (32-bit, non-prefetchable) [size=4K]
       Capabilities: [44] Power Management version 2

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 20 [EHCI])
       Subsystem: Asustek Computer, Inc. A7N8X Mainboard
       Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 5
       Memory at ee083000 (32-bit, non-prefetchable) [size=256]
       Capabilities: [44] #0a [2080]
       Capabilities: [80] Power Management version 2

00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
       Subsystem: Asustek Computer, Inc.: Unknown device 80a7
       Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 11
       Memory at ee086000 (32-bit, non-prefetchable) [size=4K]
       I/O ports at e400 [size=8]
       Capabilities: [44] Power Management version 2

00:05.0 Multimedia audio controller: nVidia Corporation nForce MultiMedia audio [Via VT82C686B] (rev a2)
       Subsystem: Asustek Computer, Inc.: Unknown device 0c11
       Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 5
       Memory at ee000000 (32-bit, non-prefetchable) [size=512K]
       Capabilities: [44] Power Management version 2

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
       Subsystem: Asustek Computer, Inc.: Unknown device 8095
       Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 11
       I/O ports at d000 [size=256]
       I/O ports at d400 [size=128]
       Memory at ee080000 (32-bit, non-prefetchable) [size=4K]
       Capabilities: [44] Power Management version 2

00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3) (prog-if 00 [Normal decode])
       Flags: bus master, 66Mhz, fast devsel, latency 0
       Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
       I/O behind bridge: 0000a000-0000bfff
       Memory behind bridge: ec000000-edffffff

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a [Master SecP PriP])
       Subsystem: Asustek Computer, Inc.: Unknown device 0c11
       Flags: bus master, 66Mhz, fast devsel, latency 0
       I/O ports at f000 [size=16]
       Capabilities: [44] Power Management version 2

00:0c.0 PCI bridge: nVidia Corporation nForce2 PCI Bridge (rev a3) (prog-if 00 [Normal decode])
       Flags: bus master, 66Mhz, fast devsel, latency 0
       Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
       I/O behind bridge: 0000c000-0000cfff
       Memory behind bridge: e8000000-e9ffffff

00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE 1394) Controller (rev a3) (prog-if 10 [OHCI])
       Subsystem: Asustek Computer, Inc.: Unknown device 809a
       Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 11
       Memory at ee084000 (32-bit, non-prefetchable) [size=2K]
       Memory at ee085000 (32-bit, non-prefetchable) [size=64]
       Capabilities: [44] Power Management version 2

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00 [Normal decode])
       Flags: bus master, 66Mhz, medium devsel, latency 16
       Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
       Memory behind bridge: ea000000-ebffffff
       Prefetchable memory behind bridge: d0000000-dfffffff

01:0b.0 RAID bus controller: CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller (rev 02)
       Subsystem: CMD Technology Inc: Unknown device 6112
       Flags: bus master, 66Mhz, medium devsel, latency 16, IRQ 11
       I/O ports at a000 [size=8]
       I/O ports at a400 [size=4]
       I/O ports at a800 [size=8]
       I/O ports at ac00 [size=4]
       I/O ports at b000 [size=16]
       Memory at ed000000 (32-bit, non-prefetchable) [size=512]
       Expansion ROM at <unassigned> [disabled] [size=512K]
       Capabilities: [60] Power Management version 2

02:01.0 Ethernet controller: 3Com Corporation 3C920B-EMB Integrated Fast Ethernet Controller (rev 40)
       Subsystem: Asustek Computer, Inc.: Unknown device 80ab
       Flags: bus master, medium devsel, latency 16, IRQ 5
       I/O ports at c000 [size=128]
       Memory at e9000000 (32-bit, non-prefetchable) [size=128]
       Expansion ROM at <unassigned> [disabled] [size=128K]
       Capabilities: [dc] Power Management version 2

03:00.0 VGA compatible controller: nVidia Corporation NV31 [GeForce FX 5600] (rev a1) (prog-if 00 [VGA])
       Subsystem: Micro-Star International Co., Ltd.: Unknown device 9123
       Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 5
       Memory at ea000000 (32-bit, non-prefetchable) [size=16M]
       Memory at d0000000 (32-bit, prefetchable) [size=256M]
       Expansion ROM at <unassigned> [disabled] [size=128K]
       Capabilities: [60] Power Management version 2
       Capabilities: [44] AGP version 3.0

