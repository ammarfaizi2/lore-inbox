Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265715AbUBLJbH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 04:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266077AbUBLJbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 04:31:07 -0500
Received: from viefep19-int.chello.at ([213.46.255.28]:48428 "EHLO
	viefep19-int.chello.at") by vger.kernel.org with ESMTP
	id S265715AbUBLJa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 04:30:58 -0500
Date: Thu, 12 Feb 2004 10:30:56 +0100
From: Philipp Kolmann <philipp@kolmann.at>
To: linux-kernel@vger.kernel.org
Subject: [2.6.3-rc2] System hangs after 'cat /proc/asound/card0/codec97#0/ac97#0-0'
Message-ID: <20040212093055.GA11676@kolmann.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[pls CC; not on list]

Hi!

Since I have also sometimes troubles with my Alsa i810 Audio, I issued
the command 'cat /proc/asound/card0/codec97#0/ac97#0-0' as suggested in
another Alsa i810 thread. But after that nothing happens anymore. I
can't Crtl-C the cat and the System hangs then complety after some
seconds.

It is still pingable, and numlock responds, but nothing gets printed on
the console.

Maybe I can be of assistance.

SW:

pkolmann@josefine:~$ sh ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux josefine 2.6.3-rc2 #1 SMP Thu Feb 12 09:20:21 CET 2004 i686
GNU/Linux
  
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre9
e2fsprogs              1.35-WIP
pcmcia-cs              3.1.33
quota-tools            3.10.
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         md5 ipv6 snd_seq_oss snd_seq_midi_event snd_seq
snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer
snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore
ehci_hcd usbcore quota_v2 nvidia sr_mod cdrom sg scsi_mod psmouse pcspkr
pcips2 evdev sk98lin unix

HW:

ASUS P4C800 Deluxe
lspci -v attached.

Thanks for the great work done so far
Philipp Kolmann
Austria

-- 
Life is not fair,
but the root password helps!

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci_out

00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80f6
	Flags: bus master, fast devsel, latency 0
	Memory at f4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	Memory behind bridge: fc900000-fe9fffff
	Prefetchable memory behind bridge: dff00000-efefffff

00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Flags: bus master, medium devsel, latency 0, IRQ 16
	I/O ports at ef00 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at ef20 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at ef40 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Flags: bus master, medium devsel, latency 0, IRQ 23
	Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fea00000-feafffff

00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 02)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at fc00 [size=16]
	Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Flags: medium devsel, IRQ 17
	I/O ports at 0400 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio Controller (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80f3
	Flags: bus master, medium devsel, latency 0, IRQ 17
	I/O ports at e800 [size=256]
	I/O ports at ee80 [size=64]
	Memory at febff800 (32-bit, non-prefetchable) [size=512]
	Memory at febff400 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: nVidia Corporation NV11DDR [GeForce2 MX 100 DDR/200 DDR] (rev b2) (prog-if 00 [VGA])
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 16
	Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at fe9f0000 [disabled] [size=64K]
	Capabilities: <available only to root>

02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808a
	Flags: bus master, medium devsel, latency 64, IRQ 20
	Memory at feaff800 (32-bit, non-prefetchable) [size=2K]
	I/O ports at dc00 [size=128]
	Capabilities: <available only to root>

02:05.0 Ethernet controller: 3Com Corporation 3c940 1000Base? (rev 12)
	Subsystem: Asustek Computer, Inc.: Unknown device 80eb
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 22
	Memory at feaf8000 (32-bit, non-prefetchable) [size=16K]
	I/O ports at d800 [size=256]
	Capabilities: <available only to root>

02:0a.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 01) (prog-if 85)
	Subsystem: Promise Technology, Inc. Ultra100TX2
	Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 22
	I/O ports at dfe0 [size=8]
	I/O ports at df9c [size=4]
	I/O ports at df90 [size=8]
	I/O ports at df98 [size=4]
	I/O ports at df80 [size=16]
	Memory at feaf4000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at feae0000 [disabled] [size=16K]
	Capabilities: <available only to root>


--+QahgC5+KEYLbs62--
