Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbUK2X2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbUK2X2c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 18:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbUK2X1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 18:27:39 -0500
Received: from CPE-203-51-26-55.nsw.bigpond.net.au ([203.51.26.55]:24060 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S261898AbUK2XVv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 18:21:51 -0500
Message-ID: <41ABAF08.4000304@eyal.emu.id.au>
Date: Tue, 30 Nov 2004 10:21:44 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.10-rc2-bk13: 'modprobe -r dvb-bt8xx' oops still going strong
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, 'dmesg' follows. Fresh boot and unload.

ff00000 device at location zero
CFI: Found no ichxrom @fff00000 device at location zero
JEDEC: Found no ichxrom @fff00000 device at location zero
CFI: Found no ichxrom @fff00000 device at location zero
JEDEC: Found no ichxrom @fff00000 device at location zero
CFI: Found no ichxrom @fff00000 device at location zero
JEDEC: Found no ichxrom @fff00000 device at location zero
CFI: Found no ichxrom @fff00000 device at location zero
JEDEC: Found no ichxrom @fff00000 device at location zero
CFI: Found no ichxrom @fff00000 device at location zero
Found: SST 49LF004B
ichxrom @fff00000: Found 1 x8 devices at 0x0 in 8-bit bank
ichxrom @fff00000: Found an alias at 0x80000 for the chip at 0x0
using fwh lock/unlock method
number of JEDEC chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
CFI: Found no ichxrom @fff80000 device at location zero
JEDEC: Found no ichxrom @fff80000 device at location zero
CFI: Found no ichxrom @fff80000 device at location zero
JEDEC: Found no ichxrom @fff80000 device at location zero
CFI: Found no ichxrom @fff80000 device at location zero
JEDEC: Found no ichxrom @fff80000 device at location zero
CFI: Found no ichxrom @fff80000 device at location zero
JEDEC: Found no ichxrom @fff80000 device at location zero
CFI: Found no ichxrom @fff80000 device at location zero
JEDEC: Found no ichxrom @fff80000 device at location zero
CFI: Found no ichxrom @fff80000 device at location zero
Found: SST 49LF004B
ichxrom @fff80000: Found 1 x8 devices at 0x0 in 8-bit bank
using fwh lock/unlock method
number of JEDEC chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Intel 810 + AC97 Audio, version 1.01, 09:38:24 Nov 30 2004
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
i810: Intel ICH5 found at IO 0xdc00 and 0xd800, MEM 0xde101000 and 0xde102000, IRQ 17
i810: Intel ICH5 mmio at 0xf89aa000 and 0xf8a08000
i810_audio: Primary codec has ID 2
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 2
ac97_codec: AC97 Audio codec, id: ALG128 (Unknown)
i810_audio: AC'97 codec 2 Unable to map surround DAC's (or DAC's not present), total channels = 2
Intel(R) PRO/1000 Network Driver - version 5.5.4-k2
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:02:01.0 to 64
divert: allocating divert_blk for eth0
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI interrupt 0000:03:01.0[A] -> GSI 21 (level, low) -> IRQ 21
bttv0: Bt848 (rev 18) at 0000:03:01.0, irq: 21, latency: 32, mmio: 0xde000000
bttv0: using: STB, Gateway P/N 6000699 (bt848) [card=3,insmod option]
bttv0: gpio config override: mask=0x7, mux=0x1,0x0,0x2,0x3,0x4
bttv0: gpio: en=00000000, out=00000000 in=00f080fc [init]
tuner: chip found at addr 0xc0 i2c-bus bt848 #0 [sw]
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles)) by insmod option
tuner: The type=<n> insmod option will go away soon.
tuner: Please use the tuner=<n> option provided by
tuner: tv aard core driver (bttv, saa7134, ...) instead.
bttv0: using tuner=2
tuner: type already set to 5, ignoring request for 2
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL can sleep, using XTAL (35468950).
bttv: Bt8xx card found (1).
ACPI: PCI interrupt 0000:03:02.0[A] -> GSI 22 (level, low) -> IRQ 22
bttv1: Bt878 (rev 17) at 0000:03:02.0, irq: 22, latency: 32, mmio: 0xde001000
bttv1: detected: AVermedia DVB-T 771 [card=123], PCI subsystem ID is 1461:0771
bttv1: using: AVerMedia AVerTV DVB-T 771 [card=123,autodetected]
bttv1: gpio config override: mask=0x7, mux=0x1,0x0,0x2,0x3,0x4
bttv1: gpio: en=00000000, out=00000000 in=0090000f [init]
bttv1: using tuner=4
bttv1: registered device video1
bttv1: registered device vbi1
bttv1: PLL: 28636363 => 35468950 .. ok
bttv1: add subdevice "remote1"
bttv1: add subdevice "dvb1"
bttv: Bt8xx card found (2).
ACPI: PCI interrupt 0000:03:03.0[A] -> GSI 16 (level, low) -> IRQ 16
bttv2: Bt878 (rev 17) at 0000:03:03.0, irq: 16, latency: 32, mmio: 0xde003000
bttv2: detected: AverMedia AverTV DVB-T [card=124], PCI subsystem ID is 1461:0761
bttv2: using: AverMedia AverTV DVB-T 761 [card=124,autodetected]
bttv2: gpio config override: mask=0x7, mux=0x1,0x0,0x2,0x3,0x4
bttv2: gpio: en=00000000, out=00000000 in=009c001d [init]
bttv2: using tuner=-1
bttv2: registered device video2
bttv2: registered device vbi2
bttv2: PLL: 28636363 => 35468950 .. ok
bttv2: add subdevice "remote2"
bttv2: add subdevice "dvb2"
bt878: AUDIO driver version 0.0.0 loaded
bt878: Bt878 AUDIO function found (0).
ACPI: PCI interrupt 0000:03:02.1[A] -> GSI 22 (level, low) -> IRQ 22
bt878(0): Bt878 (rev 17) at 03:02.1, irq: 22, latency: 32, memory: 0xde002000
bt878: Bt878 AUDIO function found (1).
ACPI: PCI interrupt 0000:03:03.1[A] -> GSI 16 (level, low) -> IRQ 16
bt878(1): Bt878 (rev 17) at 03:03.1, irq: 16, latency: 32, memory: 0xde004000
btaudio: driver version 0.7 loaded [digital+analog]
SCSI subsystem initialized
dc395x: Tekram DC395(U/UW/F), DC315(U) - ASIC TRM-S1040 v2.05, 2004/03/08
ACPI: PCI interrupt 0000:03:04.0[A] -> GSI 18 (level, low) -> IRQ 18
dc395x: Used settings: AdapterID=07, Speed=0(20.0MHz), dev_mode=0x57
dc395x:                AdaptMode=0x0f, Tags=4(16), DelayReset=1s
dc395x: Connectors: ext50  Termination: Auto Low High
dc395x: Performing initial SCSI bus reset
scsi0 : Tekram DC395(U/UW/F), DC315(U) - ASIC TRM-S1040 v2.05, 2004/03/08
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:03:05.0[A] -> GSI 21 (level, low) -> IRQ 21
ohci1394: fw-host0: Remapped memory spaces reg 0xf9076000
ohci1394: fw-host0: Soft reset finished
ohci1394: fw-host0: Iso contexts reg: 000000a8 implemented: 0000000f
ohci1394: fw-host0: 4 iso receive contexts available
ohci1394: fw-host0: Iso contexts reg: 00000098 implemented: 000000ff
ohci1394: fw-host0: 8 iso transmit contexts available
ohci1394: fw-host0: Receive DMA ctx=0 initialized
ohci1394: fw-host0: Receive DMA ctx=0 initialized
ohci1394: fw-host0: Transmit DMA ctx=0 initialized
ohci1394: fw-host0: Transmit DMA ctx=1 initialized
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[21]  MMIO=[dd004000-dd0047ff]  Max Packet=[2048]
ieee1394: CSR: setting expire to 98, HZ=1000
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
ohci1394: fw-host0: IntEvent: 00020010
ohci1394: fw-host0: irq_handler: Bus reset requested
ohci1394: fw-host0: Cancel request received
ohci1394: fw-host0: Got RQPkt interrupt status=0x00008409
ohci1394: fw-host0: IntEvent: 00010000
ohci1394: fw-host0: SelfID interrupt received (phyid 0, root)
ohci1394: fw-host0: SelfID packet 0x807f8c56 received
ieee1394: Including SelfID 0x568c7f80
ohci1394: fw-host0: SelfID for this node is 0x807f8c56
ohci1394: fw-host0: SelfID complete
ohci1394: fw-host0: PhyReqFilter=ffffffffffffffff
ieee1394: selfid_complete called with successful SelfID stage ... irm_id: 0xFFC0 node_id: 0xFFC0
ieee1394: NodeMgr: Processing host reset for knodemgrd_0
ohci1394: fw-host0: Single packet rcv'd
ohci1394: fw-host0: Got phy packet ctx=0 ... discarded
ieee1394: send packet local: ffc00140 ffc0ffff f0000400
ieee1394: received packet: ffc00140 ffc0ffff f0000400
ieee1394: send packet local: ffc00160 ffc00000 00000000 31990404
ieee1394: received packet: ffc00160 ffc00000 00000000 31990404
ieee1394: send packet local: ffc00540 ffc0ffff f0000404
ieee1394: received packet: ffc00540 ffc0ffff f0000404
ieee1394: send packet local: ffc00560 ffc00000 00000000 34393331
ieee1394: received packet: ffc00560 ffc00000 00000000 34393331
ieee1394: send packet local: ffc00940 ffc0ffff f0000408
ieee1394: received packet: ffc00940 ffc0ffff f0000408
ieee1394: send packet local: ffc00960 ffc00000 00000000 32a264e0
ieee1394: received packet: ffc00960 ffc00000 00000000 32a264e0
ieee1394: send packet local: ffc00d40 ffc0ffff f000040c
ieee1394: received packet: ffc00d40 ffc0ffff f000040c
ieee1394: send packet local: ffc00d60 ffc00000 00000000 00610d00
ieee1394: received packet: ffc00d60 ffc00000 00000000 00610d00
ieee1394: send packet local: ffc01140 ffc0ffff f0000410
ieee1394: received packet: ffc01140 ffc0ffff f0000410
ieee1394: send packet local: ffc01160 ffc00000 00000000 ebd66900
ieee1394: received packet: ffc01160 ffc00000 00000000 ebd66900
ieee1394: send packet local: ffc01550 ffc0ffff f0000400 04000000
ieee1394: received packet: ffc01550 ffc0ffff f0000400 04000000
ieee1394: send packet local: ffc01570 ffc00000 00000000 04000000
ieee1394: received packet: ffc01570 ffc00000 00000000 04000000
ieee1394: NodeMgr: raw=0xe064a232 irmc=1 cmc=1 isc=1 bmc=0 pmc=0 cyc_clk_acc=100 max_rec=2048 max_rom=1024 gen=3 lspd=2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000d61000069d6eb]
ieee1394: send packet 100: ffff0100 ffc0ffff f0000234 1f0000c0
ohci1394: fw-host0: Inserting packet for node 0-63:1023, tlabel=0, tcode=0x0, speed=0
ohci1394: fw-host0: Starting transmit DMA ctx=0
ohci1394: fw-host0: IntEvent: 00000001
ohci1394: fw-host0: Got reqTxComplete interrupt status=0x00008011
ohci1394: fw-host0: Packet sent to node 63 tcode=0x0 tLabel=0x00 ack=0x11 spd=0 data=0x1F0000C0 ctx=0
eth1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
divert: not allocating divert_blk for non-ethernet device eth1
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
ohci1394: fw-host0: ohci_iso_recv_init: packet-per-buffer mode, DMA buffer is 16 pages (65536 bytes), using 16 blocks, buf_stride 4096, block_irq_interval 1
ide-cd: ignoring drive hdc
hdd: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: ATAPI     Model: DVD RW 8XMax      Rev: 130D
   Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 5
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Intel 810 + AC97 Audio, version 1.01, 09:38:24 Nov 30 2004
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
i810: Intel ICH5 found at IO 0xdc00 and 0xd800, MEM 0xde101000 and 0xde102000, IRQ 17
i810: Intel ICH5 mmio at 0xf8a08000 and 0xf8a4e000
i810_audio: Primary codec has ID 2
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 2
ac97_codec: AC97 Audio codec, id: ALG128 (Unknown)
i810_audio: AC'97 codec 2 Unable to map surround DAC's (or DAC's not present), total channels = 2
DVB: registering new adapter (bttv1).
DVB: registering new adapter (bttv2).
xxx attach
sp887x: waiting for firmware upload...
i2c_adapter i2c-3: sendbytes: error - bailout.
sp887x_initial_setup: firmware upload... done.
DVB: registering frontend 1 (Microtune MT7202DTF)...
mt352_read_register: readreg error (ret == -121)
dvbfe_mt352: Setup for AverMedia DVB-T 771
xxx attach
DVB: registering frontend 0 (AverMedia DVB-T 771)...
mt352_read_register: readreg error (ret == -121)
mt352_read_register: readreg error (ret == -38)
mt352_read_register: readreg error (ret == -38)
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
ts: Compaq touchscreen protocol output
bt878(0): unloading
bt878_mem: 0xf8f98000.
bt878(1): unloading
bt878_mem: 0xf8f9a000.
bttv0: unloading
bttv1: unloading
devfs_remove: dvb/adapter0/frontend0 not found, cannot remove
  [<c01a1405>] devfs_remove+0xae/0xb0
  [<c0159906>] invalidate_inode_buffers+0x1b/0x80
  [<c01ab627>] inode_free_security+0x59/0x8b
  [<f91b755e>] dvb_unregister_device+0x39/0x89 [dvb_core]
  [<f91bfdf4>] dvb_unregister_frontend+0x7b/0xcc [dvb_core]
  [<c01bec81>] kobject_release+0x0/0xa
  [<f93ff634>] mt352_detach_client+0x52/0x54 [mt352]
  [<f93ff040>] mt352_ioctl+0x0/0x2a0 [mt352]
  [<f8a20361>] i2c_del_adapter+0xeb/0x244 [i2c_core]
  [<c01beca9>] kobject_put+0x1e/0x22
  [<f904d23a>] bttv_remove+0xa4/0x160 [bttv]
  [<c01c6d09>] pci_device_remove+0x3b/0x3d
  [<c0217a3e>] device_release_driver+0x7f/0x81
  [<f904d684>] bttv_cleanup_module+0x0/0x1f [bttv]
  [<c0217a60>] driver_detach+0x20/0x2e
  [<c0217e8a>] bus_remove_driver+0x4d/0x8e
  [<c02183c0>] driver_unregister+0x13/0x27
  [<c01c6f36>] pci_unregister_driver+0x16/0x26
  [<f904d693>] bttv_cleanup_module+0xf/0x1f [bttv]
  [<c0133332>] sys_delete_module+0x14e/0x181
  [<c014bc3f>] sys_munmap+0x51/0x76
  [<c010308b>] syscall_call+0x7/0xb
Unable to handle kernel NULL pointer dereference at virtual address 00000228
  printing eip:
f9053830
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: tsdev psmouse mt352 sp887x v4l1_compat dvb_core i810_audio ac97_codec sr_mod sg ide_scsi ide_cd cdrom it87 eeprom i2c_isa i2c_i801 i2c_sensor eth1394 ohci_hcd ohci1394 ieee1394 dc395x scsi_mod snd_bt87x bttv tuner video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc videodev e1000 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd snd_page_alloc soundcore i2c_core cfi_cmdset_0002 cfi_util mtdpart jedec_probe cfi_probe gen_probe ichxrom mtdcore chipreg map_funcs ehci_hcd uhci_hcd usbcore shpchp pci_hotplug intel_mch_agp intel_agp agpgart parport_pc parport evdev nls_cp437 msdos fat dm_mod rtc unix
CPU:    0
EIP:    0060:[<f9053830>]    Not tainted VLI
EFLAGS: 00010206   (2.6.10-rc2-bk13)
EIP is at bttv_i2c_info+0x36/0x6a [bttv]
eax: 000001a0   ebx: f7acae3c   ecx: f7acad80   edx: 00000004
esi: f9066670   edi: 00000000   ebp: f770d200   esp: f6d6be50
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 5863, threadinfo=f6d6b000 task=f6d65520)
Stack: f7799400 c01beca9 f7778280 f770d200 f7ab7080 f90664a4 00000000 f905319d
        f90664a0 f770d200 00000000 f8a208c7 f770d200 f91bfe28 f7799400 c01bec81
        f770d200 f7ab7080 f906660c f90664a4 f93ff606 f770d200 f7783d80 f770d200
Call Trace:
  [<c01beca9>] kobject_put+0x1e/0x22
  [<f905319d>] detach_inform+0x24/0x2a [bttv]
  [<f8a208c7>] i2c_detach_client+0x2e/0x104 [i2c_core]
  [<f91bfe28>] dvb_unregister_frontend+0xaf/0xcc [dvb_core]
  [<c01bec81>] kobject_release+0x0/0xa
  [<f93ff606>] mt352_detach_client+0x24/0x54 [mt352]
  [<f8a20361>] i2c_del_adapter+0xeb/0x244 [i2c_core]
  [<c01beca9>] kobject_put+0x1e/0x22
  [<f904d23a>] bttv_remove+0xa4/0x160 [bttv]
  [<c01c6d09>] pci_device_remove+0x3b/0x3d
  [<c0217a3e>] device_release_driver+0x7f/0x81
  [<f904d684>] bttv_cleanup_module+0x0/0x1f [bttv]
  [<c0217a60>] driver_detach+0x20/0x2e
  [<c0217e8a>] bus_remove_driver+0x4d/0x8e
  [<c02183c0>] driver_unregister+0x13/0x27
  [<c01c6f36>] pci_unregister_driver+0x16/0x26
  [<f904d693>] bttv_cleanup_module+0xf/0x1f [bttv]
  [<c0133332>] sys_delete_module+0x14e/0x181
  [<c014bc3f>] sys_munmap+0x51/0x76
  [<c010308b>] syscall_call+0x7/0xb
Code: 8b 6c 24 24 8b 7c 24 28 8b 98 d0 01 00 00 8b 13 0f 18 02 90 8d b0 d0 01 00 00 39 f3 74 24 8d 8b 44 ff ff ff 8b 41 70 85 c0 74 09 <83> b8 88 00 00 00 00 75 16 8b 02 89 d3 89 c2 0f 18 00 90 39 f3

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	If attaching .zip rename to .dat
