Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262958AbVHEPwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbVHEPwA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262973AbVHEPvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 11:51:49 -0400
Received: from pop.gmx.de ([213.165.64.20]:2704 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262958AbVHEPve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 11:51:34 -0400
X-Authenticated: #3439220
From: Martin Maurer <martinmaurer@gmx.at>
To: linux-kernel@vger.kernel.org
Subject: Elitegroup K7S5A + usb_storage problem
Date: Fri, 5 Aug 2005 17:51:31 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7300884.RMVPNjippj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508051751.34496.martinmaurer@gmx.at>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7300884.RMVPNjippj
Content-Type: multipart/mixed;
  boundary="Boundary-01=_Es48CCN3/tc6b6F"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_Es48CCN3/tc6b6F
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

=46or quite some time now I have got a problem mounting my usb-stick (MP3 F=
UN256=20
from DNT) with linux. This stick worked back in the 2.4.x days, though it=20
needed one of the later versions (I switched to 2.6.x as soon about when it=
=20
was released, so I didnt test the newest versions.)

Recently I bought an usb harddisk encasing and tried this one, but it doesn=
t=20
work either. Taking a look at dmesg I think the devices are not correctly=20
found by the kernel. (I attached the two dmesg outputs).

As I dont know which part of the kernel causes this problem I did not so fa=
r=20
report a bug using bugzilla. (And as it may be my fault too).

I currently use 2.6.13-rc5 + software-suspoend 2 patch 2.1.9.12
(I tried 2.6.12-rc5, and some earlier versions too)

Processor: AMD Athlon XP 1700+
Distribution: Debian unstable (though not updated for about a month).

Anyone knows help for this issues ?
(patches to try and verify happily accepted)

greetings
Martin Maurer

--Boundary-01=_Es48CCN3/tc6b6F
Content-Type: text/plain;
  charset="us-ascii";
  name="lsmod.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lsmod.txt"

Module                  Size  Used by
usb_storage           115792  0=20
scsi_mod              145832  1 usb_storage
bnep                   16640  2=20
rfcomm                 41564  0=20
l2cap                  27972  9 bnep,rfcomm
lp                     11652  0=20
ipv6                  267264  19=20
ip_queue               11744  0=20
ipt_ULOG                8388  5=20
ipt_state               1920  8=20
ipt_MASQUERADE          3648  1=20
iptable_nat            24212  2 ipt_MASQUERADE
ip_conntrack           45240  3 ipt_state,ipt_MASQUERADE,iptable_nat
iptable_filter          3008  1=20
ip_tables              23104  5 ipt_ULOG,ipt_state,ipt_MASQUERADE,iptable_n=
at,iptable_filter
af_packet              22920  2=20
ide_cd                 43396  0=20
cdrom                  41184  1 ide_cd
parport_pc             36548  1=20
parport                38344  2 lp,parport_pc
floppy                 59476  0=20
pcspkr                  3864  0=20
rtc                    14072  0=20
snd_bt87x              15304  0=20
tuner                  38056  0=20
tvaudio                22812  0=20
bttv                  162448  0=20
video_buf              22212  1 bttv
i2c_algo_bit            9864  1 bttv
v4l2_common             5824  1 bttv
btcx_risc               4936  1 bttv
tveeprom               11920  1 bttv
videodev                9984  1 bttv
8139cp                 21440  0=20
usbhid                 35040  0=20
hci_usb                16008  0=20
bluetooth              52804  6 bnep,rfcomm,l2cap,hci_usb
snd_intel8x0           34112  0=20
ohci_hcd               36740  0=20
i2c_sis96x              5508  0=20
i2c_sis630              7820  0=20
i2c_core               22224  7 tuner,tvaudio,bttv,i2c_algo_bit,tveeprom,i2=
c_sis96x,i2c_sis630
sis_agp                 8708  1=20
agpgart                36296  1 sis_agp
nls_iso8859_1           4032  2=20
nls_cp437               5696  2=20
vfat                   14080  2=20
fat                    53212  1 vfat
8139too                28480  0=20
mii                     5568  2 8139cp,8139too
ne2k_pci               10912  0=20
8390                   10240  1 ne2k_pci
crc32                   4224  4 bnep,8139cp,8139too,8390
snd_via82xx            28320  0=20
snd_mpu401_uart         8192  1 snd_via82xx
snd_usb_audio          78016  0=20
snd_usb_lib            15872  1 snd_usb_audio
snd_emu10k1_synth       8192  0=20
snd_emux_synth         38976  1 snd_emu10k1_synth
snd_seq_virmidi         8064  1 snd_emux_synth
snd_seq_midi_emul       7488  1 snd_emux_synth
snd_emu10k1           124644  1 snd_emu10k1_synth
snd_ac97_codec         85308  3 snd_intel8x0,snd_via82xx,snd_emu10k1
snd_pcm_oss            53216  0=20
snd_mixer_oss          19776  1 snd_pcm_oss
snd_pcm                94280  7 snd_bt87x,snd_intel8x0,snd_via82xx,snd_usb_=
audio,snd_emu10k1,snd_ac97_codec,snd_pcm_oss
snd_page_alloc         10760  5 snd_bt87x,snd_intel8x0,snd_via82xx,snd_emu1=
0k1,snd_pcm
snd_seq_dummy           3716  0=20
tsdev                   7488  0=20
snd_seq_oss            35776  0=20
evdev                   9280  0=20
snd_seq_midi            9056  0=20
snd_rawmidi            26656  5 snd_mpu401_uart,snd_usb_lib,snd_seq_virmidi=
,snd_emu10k1,snd_seq_midi
snd_seq_midi_event      7552  3 snd_seq_virmidi,snd_seq_oss,snd_seq_midi
snd_seq                55504  9 snd_emux_synth,snd_seq_virmidi,snd_seq_midi=
_emul,snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_timer              26308  3 snd_emu10k1,snd_pcm,snd_seq
snd_seq_device          8780  8 snd_emu10k1_synth,snd_emux_synth,snd_emu10k=
1,snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
snd_hwdep               9760  3 snd_usb_audio,snd_emux_synth,snd_emu10k1
snd                    56484  18 snd_bt87x,snd_intel8x0,snd_via82xx,snd_mpu=
401_uart,snd_usb_audio,snd_emux_synth,snd_seq_virmidi,snd_emu10k1,snd_ac97_=
codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_seq_oss,snd_rawmidi,snd_seq,snd=
_timer,snd_seq_device,snd_hwdep
soundcore              10400  1 snd
snd_util_mem            4544  2 snd_emux_synth,snd_emu10k1
psmouse                35396  0=20
mousedev               11936  2=20
at76c503_rfmd           5452  0=20
at76c505_rfmd2958       4940  0=20
firmware_class         11008  3 bttv,at76c503_rfmd,at76c505_rfmd2958
at76c503               97440  2 at76c503_rfmd,at76c505_rfmd2958
at76_usbdfu             6212  1 at76c503
usbcore               137532  11 usb_storage,usbhid,hci_usb,ohci_hcd,snd_us=
b_audio,snd_usb_lib,at76c503_rfmd,at76c505_rfmd2958,at76c503,at76_usbdfu
unix                   29296  826=20

--Boundary-01=_Es48CCN3/tc6b6F
Content-Type: text/plain;
  charset="us-ascii";
  name="harddrive.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="harddrive.dmesg"

/usr/src/modules/at76c503a/at76c503.c: registered wlan0
hub 1-1:1.0: state 5 ports 4 chg 0000 evt 0010
hub 1-1:1.0: port 4, status 0101, change 0001, 12 Mb/s
hub 1-1:1.0: debounce: port 4: total 100ms stable 100ms status 0x101
usb 1-1.4: new full speed USB device using ohci_hcd and address 8
usb 1-1.4: default language 0x0409
usb 1-1.4: new device strings: Mfr=0, Product=1, SerialNumber=0
usb 1-1.4: Product: USB TO IDE
usb 1-1.4: hotplug
usb 1-1.4: adding 1-1.4:1.0 (config #1, interface 0)
usb 1-1.4:1.0: hotplug
hub 1-1:1.0: state 5 ports 4 chg 0000 evt 0010
SCSI subsystem initialized
Initializing USB Mass Storage driver...
usb-storage 1-1.4:1.0: usb_probe_interface
usb-storage 1-1.4:1.0: usb_probe_interface - got id
usb-storage: USB Mass Storage device detected
usb-storage: -- associate_dev
usb-storage: Vendor: 0x05e3, Product: 0x0702, Revision: 0x0033
usb-storage: Interface Subclass: 0x06, Protocol: 0x50
usb-storage: Transport: Bulk
usb-storage: Protocol: Transparent SCSI
usb-storage: usb_stor_control_msg: rq=fe rqtype=a1 value=0000 index=00 len=1
usb-storage: GetMaxLUN command result is 1, data is 0
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: *** thread sleeping.
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 8
usb-storage: waiting for device to settle before scanning
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage:  12 00 00 00 24 00
usb-storage: Bulk Command S 0x43425355 T 0x1 L 36 F 128 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
usb-storage: Status code 0; transferred 36/36
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x1 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
  Vendor: IC35L040  Model: AVER07-0          Rev: 0811
  Type:   Direct-Access                      ANSI SCSI revision: 00
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad LUN (0:1)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (1:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (2:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (3:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (4:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (5:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (6:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (7:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: device scan complete

--Boundary-01=_Es48CCN3/tc6b6F
Content-Type: text/plain;
  charset="us-ascii";
  name="mp3stick.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mp3stick.dmesg"

hub 1-1:1.0: state 5 ports 4 chg 0000 evt 0010
hub 1-1:1.0: port 4, status 0101, change 0001, 12 Mb/s
hub 1-1:1.0: debounce: port 4: total 100ms stable 100ms status 0x101
usb 1-1.4: new full speed USB device using ohci_hcd and address 9
usb 1-1.4: ep0 maxpacket = 32
usb 1-1.4: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1.4: hotplug
usb 1-1.4: adding 1-1.4:1.0 (config #1, interface 0)
usb 1-1.4:1.0: hotplug
usb-storage 1-1.4:1.0: usb_probe_interface
usb-storage 1-1.4:1.0: usb_probe_interface - got id
usb-storage: USB Mass Storage device detected
usb-storage: -- associate_dev
usb-storage: Vendor: 0x0f19, Product: 0x0103, Revision: 0x0100
usb-storage: Interface Subclass: 0x06, Protocol: 0x50
usb-storage: Transport: Bulk
usb-storage: Protocol: Transparent SCSI
usb-storage: usb_stor_control_msg: rq=fe rqtype=a1 value=0000 index=00 len=1
usb-storage: GetMaxLUN command result is -32, data is 85
usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=82 len=0
usb-storage: usb_stor_clear_halt: result = 0
usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=01 len=0
usb-storage: usb_stor_clear_halt: result = 0
scsi1 : SCSI emulation for USB Mass Storage devices
usb-storage: *** thread sleeping.
hub 1-1:1.0: state 5 ports 4 chg 0000 evt 0010
usb-storage: device found at 9
usb-storage: waiting for device to settle before scanning
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage:  12 00 00 00 24 00
usb-storage: Bulk Command S 0x43425355 T 0x1 L 36 F 128 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
usb-storage: Status code 0; transferred 13/36
usb-storage: -- short transfer
usb-storage: Bulk data transfer result 0x1
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
ohci_hcd 0000:00:02.2: urb c43886e0 path 1.4 ep2in 82160000 cc 8 --> status -75
usb-storage: Status code -75; transferred 13/13
usb-storage: -- babble
usb-storage: Bulk status result = 3
usb-storage: -- transport indicates error, resetting
usb 1-1.4: reset full speed USB device using ohci_hcd and address 9
usb 1-1.4: ep0 maxpacket = 32
usb-storage: usb_reset_device returns 0
usb-storage: scsi cmd done, result=0x70000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage:  12 00 00 00 24 00
usb-storage: Bulk Command S 0x43425355 T 0x2 L 36 F 128 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
usb-storage: Status code 0; transferred 36/36
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x2 R 0 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk Command S 0x43425355 T 0x80000002 L 18 F 128 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
usb-storage: Status code 0; transferred 18/18
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x80000002 R 0 Stat 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x5, ASC: 0x24, ASCQ: 0x0
usb-storage: Illegal Request: Invalid field in cdb
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (1:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (2:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (3:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (4:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (5:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (6:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (7:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: device scan complete

--Boundary-01=_Es48CCN3/tc6b6F
Content-Type: text/plain;
  charset="us-ascii";
  name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci.txt"

0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev 01)
	Flags: bus master, medium devsel, latency 32
	Memory at d0000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: cfe00000-cfefffff
	Prefetchable memory behind bridge: afc00000-cfcfffff

0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC Bridge)
	Flags: bus master, medium devsel, latency 0

0000:00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
	Flags: medium devsel
	I/O ports at 0c00 [size=32]

0000:00:02.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 07) (prog-if 10 [OHCI])
	Subsystem: Elitegroup Computer Systems: Unknown device 0a14
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at cfffe000 (32-bit, non-prefetchable) [size=4K]

0000:00:02.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 07) (prog-if 10 [OHCI])
	Subsystem: Elitegroup Computer Systems: Unknown device 0a14
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at cffff000 (32-bit, non-prefetchable) [size=4K]

0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
	Flags: bus master, fast devsel, latency 128
	I/O ports at ff00 [size=16]

0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound Controller (rev a0)
	Subsystem: Elitegroup Computer Systems: Unknown device 0a14
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at d800 [size=256]
	I/O ports at d400 [size=64]
	Capabilities: <available only to root>

0000:00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
	Subsystem: Creative Labs CT4832 SBLive! Value
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at d000 [size=32]
	Capabilities: <available only to root>

0000:00:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Flags: bus master, medium devsel, latency 64
	I/O ports at dc00 [size=8]
	Capabilities: <available only to root>

0000:00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at cc00 [size=256]
	Memory at cfffdf00 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at 20000000 [disabled] [size=64K]
	Capabilities: <available only to root>

0000:00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Subsystem: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Flags: medium devsel, IRQ 11
	I/O ports at c800 [size=32]

0000:00:11.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at cfdfe000 (32-bit, prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:11.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at cfdff000 (32-bit, prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R300 NE [Radeon 9500 Pro] (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Radeon R300 NE [Radeon 9500 Pro]
	Flags: bus master, stepping, 66MHz, medium devsel, latency 64, IRQ 5
	Memory at c0000000 (32-bit, prefetchable) [size=128M]
	I/O ports at 9800 [size=256]
	Memory at cfef0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at afc00000 [disabled] [size=128K]
	Capabilities: <available only to root>

0000:01:00.1 Display controller: ATI Technologies Inc Radeon R300 [Radeon 9500 Pro] (Secondary)
	Subsystem: ATI Technologies Inc Radeon R300 NE [Radeon 9500 Pro]
	Flags: bus master, stepping, 66MHz, medium devsel, latency 64
	Memory at b8000000 (32-bit, prefetchable) [size=128M]
	Memory at cfee0000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>


--Boundary-01=_Es48CCN3/tc6b6F--

--nextPart7300884.RMVPNjippj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC84sGXHsqb5Up6wURAq4WAKCbEyzxIFMJ0sFZV4KIUH/rVtPF8QCgnX7+
psp3zaUSOqpW4iAccReQPJM=
=gXbN
-----END PGP SIGNATURE-----

--nextPart7300884.RMVPNjippj--
