Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbUJaSHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUJaSHk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 13:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbUJaSHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 13:07:40 -0500
Received: from hs-grafik.net ([80.237.205.72]:62632 "EHLO
	ds80-237-205-72.dedicated.hosteurope.de") by vger.kernel.org
	with ESMTP id S261418AbUJaSDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 13:03:14 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.10-rc1-mm2] keyboard / synaptics not working
Date: Sun, 31 Oct 2004 19:03:06 +0100
User-Agent: KMail/1.7
X-Need-Girlfriend: always
X-Ignorant-User: yes
MIME-Version: 1.0
Message-Id: <200410311903.06927@zodiac.zodiac.dnsalias.org>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ajShBhZTUnJfM1S"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_ajShBhZTUnJfM1S
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

using 2.6.10-rc1-mm2 my keyboard and synaptics do not work. 2.6.9-rc4-mm1 is 
fine. Both bootlogs are attached.
lspci (using 2.6.8-rc3-mm1)  gives
0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 
03)
0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 
03)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #1 (rev 01)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #2 (rev 01)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #3 (rev 01)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 
EHCI Controller (rev 01)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 81)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 
01)
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage 
Controller (rev 01)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus 
Controller (rev 01)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 
Modem Controller (rev 01)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf 
[Radeon Mobility 9000 M9] (rev 02)
0000:02:00.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus 
Controller (rev 01)
0000:02:00.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus 
Controller (rev 01)
0000:02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet 
Controller (Mobile) (rev 03)
0000:02:02.0 Ethernet controller: Atheros Communications, Inc. AR5211 802.11ab 
NIC (rev 01)

The 2.6.10-rc1-mm2 config is attached,too.

regards
Alex

-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--Boundary-00=_ajShBhZTUnJfM1S
Content-Type: text/plain;
  charset="iso-8859-15";
  name="syslog-2.6.10-rc1-mm2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="syslog-2.6.10-rc1-mm2"

Oct 31 17:16:31 t40 syslogd 1.4.1#15: restart.
Oct 31 17:16:31 t40 kernel: klogd 1.4.1#15, log source = /proc/kmsg started.
Oct 31 17:16:31 t40 kernel: Inspecting /boot/System.map-2.6.10-rc1-mm2-orig
Oct 31 17:16:32 t40 kernel: Loaded 32710 symbols from /boot/System.map-2.6.10-rc1-mm2-orig.
Oct 31 17:16:32 t40 kernel: Symbols match kernel version 2.6.10.
Oct 31 17:16:32 t40 kernel: No module symbols loaded - kernel modules not enabled. 
Oct 31 17:16:32 t40 kernel: Linux version 2.6.10-rc1-mm2-orig (root@t40) (gcc version 3.3.5 (Debian 1:3.3.5-2)) #2 Sun Oct 31 17:07:07 CET 2004
Oct 31 17:16:32 t40 kernel: BIOS-provided physical RAM map:
Oct 31 17:16:32 t40 kernel:  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
Oct 31 17:16:32 t40 kernel:  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
Oct 31 17:16:32 t40 kernel:  BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
Oct 31 17:16:32 t40 kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Oct 31 17:16:32 t40 kernel:  BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
Oct 31 17:16:32 t40 kernel:  BIOS-e820: 000000001ff60000 - 000000001ff77000 (ACPI data)
Oct 31 17:16:32 t40 kernel:  BIOS-e820: 000000001ff77000 - 000000001ff79000 (ACPI NVS)
Oct 31 17:16:32 t40 kernel:  BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
Oct 31 17:16:32 t40 kernel:  BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
Oct 31 17:16:32 t40 kernel: 511MB LOWMEM available.
Oct 31 17:16:32 t40 kernel: On node 0 totalpages: 130912
Oct 31 17:16:32 t40 kernel:   DMA zone: 4096 pages, LIFO batch:1
Oct 31 17:16:32 t40 kernel:   Normal zone: 126816 pages, LIFO batch:16
Oct 31 17:16:32 t40 kernel:   HighMem zone: 0 pages, LIFO batch:1
Oct 31 17:16:32 t40 kernel: DMI present.
Oct 31 17:16:32 t40 kernel: ACPI: RSDP (v002 IBM                                   ) @ 0x000f6e00
Oct 31 17:16:32 t40 kernel: ACPI: XSDT (v001 IBM    TP-1R    0x00003051  LTP 0x00000000) @ 0x1ff6af83
Oct 31 17:16:32 t40 kernel: ACPI: FADT (v003 IBM    TP-1R    0x00003051 IBM  0x00000001) @ 0x1ff6b000
Oct 31 17:16:32 t40 kernel: ACPI: SSDT (v001 IBM    TP-1R    0x00003051 MSFT 0x0100000e) @ 0x1ff6b1b4
Oct 31 17:16:32 t40 kernel: ACPI: ECDT (v001 IBM    TP-1R    0x00003051 IBM  0x00000001) @ 0x1ff76e06
Oct 31 17:16:32 t40 kernel: ACPI: TCPA (v001 IBM    TP-1R    0x00003051 PTL  0x00000001) @ 0x1ff76e58
Oct 31 17:16:32 t40 kernel: ACPI: BOOT (v001 IBM    TP-1R    0x00003051  LTP 0x00000001) @ 0x1ff76fd8
Oct 31 17:16:32 t40 kernel: ACPI: DSDT (v001 IBM    TP-1R    0x00003051 MSFT 0x0100000e) @ 0x00000000
Oct 31 17:16:32 t40 kernel: Built 1 zonelists
Oct 31 17:16:33 t40 kernel: Initializing CPU#0
Oct 31 17:16:33 t40 kernel: Kernel command line: BOOT_IMAGE=Linux-acpi ro root=306 quiet pci=routeirq
Oct 31 17:16:33 t40 kernel: CPU 0 irqstacks, hard=c04c7000 soft=c04c6000
Oct 31 17:16:33 t40 kernel: PID hash table entries: 2048 (order: 11, 32768 bytes)
Oct 31 17:16:34 t40 kernel: Detected 1595.001 MHz processor.
Oct 31 17:16:34 t40 kernel: Using tsc for high-res timesource
Oct 31 17:16:34 t40 kernel: Console: colour VGA+ 80x25
Oct 31 17:16:34 t40 kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Oct 31 17:16:35 t40 kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Oct 31 17:16:36 t40 kernel: Memory: 513172k/523648k available (2619k kernel code, 9980k reserved, 1061k data, 156k init, 0k highmem)
Oct 31 17:16:36 t40 kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Oct 31 17:16:36 t40 kernel: Calibrating delay loop... 3153.92 BogoMIPS (lpj=1576960)
Oct 31 17:16:36 t40 kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Oct 31 17:16:36 t40 kernel: CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000
Oct 31 17:16:36 t40 kernel: CPU: After vendor identify, caps:  a7e9f9bf 00000000 00000000 00000000
Oct 31 17:16:36 t40 kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Oct 31 17:16:36 t40 kernel: CPU: L2 cache: 1024K
Oct 31 17:16:36 t40 kernel: CPU: After all inits, caps:        a7e9f9bf 00000000 00000000 00000040
Oct 31 17:16:36 t40 kernel: Intel machine check architecture supported.
Oct 31 17:16:36 t40 kernel: Intel machine check reporting enabled on CPU#0.
Oct 31 17:16:36 t40 kernel: CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
Oct 31 17:16:36 t40 kernel: Enabling fast FPU save and restore... done.
Oct 31 17:16:36 t40 kernel: Enabling unmasked SIMD FPU exception support... done.
Oct 31 17:16:38 t40 kernel: Checking 'hlt' instruction... OK.
Oct 31 17:16:38 t40 kernel: ACPI: IRQ9 SCI: Edge set to Level Trigger.
Oct 31 17:16:38 t40 kernel: NET: Registered protocol family 16
Oct 31 17:16:39 t40 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=8
Oct 31 17:16:39 t40 kernel: PCI: Using configuration type 1
Oct 31 17:16:39 t40 kernel: mtrr: v2.0 (20020519)
Oct 31 17:16:39 t40 kernel: ACPI: Subsystem revision 20041015
Oct 31 17:16:40 t40 net.agent[2767]: Bad NET invocation: $INTERFACE is not set
Oct 31 17:16:40 t40 cardmgr[2792]: watching 2 sockets
Oct 31 17:16:40 t40 kernel: ACPI: Found ECDT
Oct 31 17:16:40 t40 cardmgr[2793]: starting, version is 3.2.5
Oct 31 17:16:40 t40 kernel: ACPI: Interpreter enabled
Oct 31 17:16:41 t40 irattach: executing: 'echo t40 > /proc/sys/net/irda/devname'
Oct 31 17:16:41 t40 rpc.statd[2807]: Version 1.0.6 Starting
Oct 31 17:16:42 t40 kernel: ACPI: Using PIC for interrupt routing
Oct 31 17:16:42 t40 irattach: Starting device irda0
Oct 31 17:16:42 t40 rpc.statd[2807]: statd running as root. chown /var/lib/nfs/sm to choose different user 
Oct 31 17:16:42 t40 kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
Oct 31 17:16:43 t40 kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11)
Oct 31 17:16:43 t40 kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
Oct 31 17:16:43 t40 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
Oct 31 17:16:43 t40 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
Oct 31 17:16:43 t40 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
Oct 31 17:16:44 t40 hcid[2837]: Bluetooth HCI daemon
Oct 31 17:16:44 t40 sdpd[2839]: Bluetooth SDP daemon 
Oct 31 17:16:44 t40 /usr/sbin/cron[2843]: (CRON) INFO (pidfile fd = 3)
Oct 31 17:16:44 t40 kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
Oct 31 17:16:44 t40 hcid[2837]: syntax error line 32 
Oct 31 17:16:44 t40 /usr/sbin/cron[2844]: (CRON) STARTUP (fork ok)
Oct 31 17:16:44 t40 kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
Oct 31 17:16:44 t40 kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Oct 31 17:16:44 t40 /usr/sbin/cron[2844]: (CRON) INFO (Running @reboot jobs)
Oct 31 17:16:44 t40 kernel: PCI: Probing PCI hardware (bus 00)
Oct 31 17:16:44 t40 kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Oct 31 17:16:44 t40 kernel: PCI: Transparent bridge - 0000:00:1e.0
Oct 31 17:16:44 t40 kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Oct 31 17:16:44 t40 kernel: ACPI: Embedded Controller [EC] (gpe 28)
Oct 31 17:16:44 t40 kernel: ACPI: Power Resource [PUBS] (on)
Oct 31 17:16:44 t40 kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Oct 31 17:16:44 t40 kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Oct 31 17:16:44 t40 kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Oct 31 17:16:44 t40 kernel: pnp: PnP ACPI init
Oct 31 17:16:44 t40 kernel: pnp: PnP ACPI: found 12 devices
Oct 31 17:16:44 t40 kernel: PnPBIOS: Disabled by pnpacpi
Oct 31 17:16:44 t40 kernel: SCSI subsystem initialized
Oct 31 17:16:44 t40 kernel: Linux Kernel Card Services
Oct 31 17:16:44 t40 kernel:   options:  [pci] [cardbus] [pm]
Oct 31 17:16:44 t40 kernel: PCI: Using ACPI for IRQ routing
Oct 31 17:16:44 t40 kernel: ** Routing PCI interrupts for all devices because "pci=routeirq"
Oct 31 17:16:44 t40 kernel: ** was specified.  If this was required to make a driver work,
Oct 31 17:16:44 t40 kernel: ** please email the output of "lspci" to bjorn.helgaas@hp.com
Oct 31 17:16:44 t40 kernel: ** so I can fix the driver.
Oct 31 17:16:44 t40 kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Oct 31 17:16:44 t40 kernel: PCI: setting IRQ 11 as level-triggered
Oct 31 17:16:44 t40 kernel: ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
Oct 31 17:16:44 t40 kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
Oct 31 17:16:44 t40 kernel: ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
Oct 31 17:16:44 t40 kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
Oct 31 17:16:44 t40 kernel: ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
Oct 31 17:16:44 t40 kernel: ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
Oct 31 17:16:44 t40 kernel: ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
Oct 31 17:16:44 t40 kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
Oct 31 17:16:44 t40 kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
Oct 31 17:16:44 t40 kernel: PCI: setting IRQ 5 as level-triggered
Oct 31 17:16:45 t40 kernel: ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 5 (level, low) -> IRQ 5
Oct 31 17:16:45 t40 kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
Oct 31 17:16:45 t40 kernel: ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 5 (level, low) -> IRQ 5
Oct 31 17:16:45 t40 kernel: ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Oct 31 17:16:45 t40 kernel: ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Oct 31 17:16:45 t40 kernel: ACPI: PCI interrupt 0000:02:00.1[B] -> GSI 5 (level, low) -> IRQ 5
Oct 31 17:16:45 t40 kernel: ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
Oct 31 17:16:45 t40 kernel: ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
Oct 31 17:16:45 t40 kernel: NET: Registered protocol family 23
Oct 31 17:16:45 t40 kernel: Bluetooth: Core ver 2.6
Oct 31 17:16:45 t40 kernel: NET: Registered protocol family 31
Oct 31 17:16:45 t40 kernel: Bluetooth: HCI device and connection manager initialized
Oct 31 17:16:45 t40 kernel: Bluetooth: HCI socket layer initialized
Oct 31 17:16:45 t40 kernel: Simple Boot Flag at 0x35 set to 0x1
Oct 31 17:16:45 t40 kernel: Machine check exception polling timer started.
Oct 31 17:16:45 t40 kernel: IBM machine detected. Enabling interrupts during APM calls.
Oct 31 17:16:45 t40 kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Oct 31 17:16:45 t40 kernel: apm: overridden by ACPI.
Oct 31 17:16:45 t40 kernel: Initializing Cryptographic API
Oct 31 17:16:45 t40 kernel: ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Oct 31 17:16:45 t40 kernel: radeonfb: Retreived PLL infos from BIOS
Oct 31 17:16:45 t40 kernel: radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=252.00 Mhz, System=200.00 MHz
Oct 31 17:16:45 t40 kernel: radeonfb: PLL min 20000 max 35000
Oct 31 17:16:45 t40 kernel: Non-DDC laptop panel detected
Oct 31 17:16:45 t40 kernel: radeonfb: Monitor 1 type LCD found
Oct 31 17:16:45 t40 kernel: radeonfb: Monitor 2 type no found
Oct 31 17:16:45 t40 kernel: radeonfb: panel ID string: SXGA+ Single (85MHz)    
Oct 31 17:16:45 t40 kernel: radeonfb: detected LVDS panel size from BIOS: 1400x1050
Oct 31 17:16:45 t40 kernel: radeondb: BIOS provided dividers will be used
Oct 31 17:16:45 t40 kernel: radeonfb: Power Management enabled for Mobility chipsets
Oct 31 17:16:45 t40 kernel: Console: switching to colour frame buffer device 175x65
Oct 31 17:16:45 t40 kernel: radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
Oct 31 17:16:45 t40 kernel: isapnp: Scanning for PnP cards...
Oct 31 17:16:45 t40 kernel: isapnp: No Plug & Play device found
Oct 31 17:16:45 t40 kernel: lp: driver loaded but no devices found
Oct 31 17:16:45 t40 kernel: Real Time Clock Driver v1.12
Oct 31 17:16:45 t40 kernel: Non-volatile memory driver v1.2
Oct 31 17:16:45 t40 kernel: Linux agpgart interface v0.100 (c) Dave Jones
Oct 31 17:16:45 t40 kernel: agpgart: Detected an Intel 855PM Chipset.
Oct 31 17:16:45 t40 kernel: agpgart: Maximum main memory to use for agp memory: 439M
Oct 31 17:16:45 t40 kernel: agpgart: AGP aperture is 256M @ 0xd0000000
Oct 31 17:16:45 t40 kernel: [drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9]
Oct 31 17:16:45 t40 kernel: ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Oct 31 17:16:45 t40 kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing enabled
Oct 31 17:16:45 t40 kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
Oct 31 17:16:45 t40 kernel: ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 5 (level, low) -> IRQ 5
Oct 31 17:16:45 t40 kernel: pnp: Device 00:08 activated.
Oct 31 17:16:45 t40 kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
Oct 31 17:16:45 t40 kernel: parport: PnPBIOS parport detected.
Oct 31 17:16:45 t40 kernel: parport0: PC-style at 0x3bc, irq 7 [PCSPP,TRISTATE]
Oct 31 17:16:45 t40 kernel: lp0: using parport0 (interrupt-driven).
Oct 31 17:16:45 t40 kernel: io scheduler noop registered
Oct 31 17:16:45 t40 kernel: io scheduler anticipatory registered
Oct 31 17:16:45 t40 kernel: io scheduler deadline registered
Oct 31 17:16:45 t40 kernel: io scheduler cfq registered
Oct 31 17:16:45 t40 kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Oct 31 17:16:45 t40 kernel: loop: loaded (max 8 devices)
Oct 31 17:16:45 t40 kernel: pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Oct 31 17:16:45 t40 kernel: Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Oct 31 17:16:45 t40 kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Oct 31 17:16:45 t40 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Oct 31 17:16:45 t40 kernel: ICH4: IDE controller at PCI slot 0000:00:1f.1
Oct 31 17:16:45 t40 kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Oct 31 17:16:45 t40 kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
Oct 31 17:16:45 t40 kernel: ICH4: chipset revision 1
Oct 31 17:16:45 t40 kernel: ICH4: not 100%% native mode: will probe irqs later
Oct 31 17:16:45 t40 kernel:     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
Oct 31 17:16:45 t40 kernel:     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Oct 31 17:16:45 t40 kernel: Probing IDE interface ide0...
Oct 31 17:16:45 t40 kernel: hda: IC25N040ATCS05-0, ATA DISK drive
Oct 31 17:16:45 t40 kernel: elevator: using anticipatory as default io scheduler
Oct 31 17:16:45 t40 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Oct 31 17:16:45 t40 kernel: Probing IDE interface ide1...
Oct 31 17:16:45 t40 kernel: hdc: UJDA745 DVD/CDRW, ATAPI CD/DVD-ROM drive
Oct 31 17:16:45 t40 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Oct 31 17:16:45 t40 kernel: Probing IDE interface ide2...
Oct 31 17:16:45 t40 kernel: ide2: Wait for ready failed before probe !
Oct 31 17:16:45 t40 kernel: Probing IDE interface ide3...
Oct 31 17:16:45 t40 kernel: ide3: Wait for ready failed before probe !
Oct 31 17:16:45 t40 kernel: Probing IDE interface ide4...
Oct 31 17:16:45 t40 kernel: ide4: Wait for ready failed before probe !
Oct 31 17:16:45 t40 kernel: Probing IDE interface ide5...
Oct 31 17:16:45 t40 kernel: ide5: Wait for ready failed before probe !
Oct 31 17:16:45 t40 kernel: hda: max request size: 128KiB
Oct 31 17:16:45 t40 kernel: hda: 78140160 sectors (40007 MB) w/7898KiB Cache, CHS=65535/16/63, UDMA(100)
Oct 31 17:16:45 t40 kernel: hda: cache flushes not supported
Oct 31 17:16:45 t40 kernel:  hda: hda1 hda2 hda3 < hda5 hda6 hda7 > hda4
Oct 31 17:16:45 t40 kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Oct 31 17:16:45 t40 kernel: Uniform CD-ROM driver Revision: 3.20
Oct 31 17:16:45 t40 kernel: ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Oct 31 17:16:45 t40 kernel: Yenta: CardBus bridge found at 0000:02:00.0 [1014:0512]
Oct 31 17:16:45 t40 kernel: Yenta: Using INTVAL to route CSC interrupts to PCI
Oct 31 17:16:45 t40 kernel: Yenta: Routing CardBus interrupts to PCI
Oct 31 17:16:45 t40 kernel: Yenta TI: socket 0000:02:00.0, mfunc 0x01d21022, devctl 0x64
Oct 31 17:16:45 t40 kernel: Yenta: ISA IRQ mask 0x0458, PCI irq 11
Oct 31 17:16:45 t40 kernel: Socket status: 30000006
Oct 31 17:16:45 t40 kernel: ACPI: PCI interrupt 0000:02:00.1[B] -> GSI 5 (level, low) -> IRQ 5
Oct 31 17:16:45 t40 kernel: Yenta: CardBus bridge found at 0000:02:00.1 [1014:0512]
Oct 31 17:16:45 t40 kernel: Yenta: Using INTVAL to route CSC interrupts to PCI
Oct 31 17:16:45 t40 kernel: Yenta: Routing CardBus interrupts to PCI
Oct 31 17:16:45 t40 kernel: Yenta TI: socket 0000:02:00.1, mfunc 0x01d21022, devctl 0x64
Oct 31 17:16:45 t40 kernel: Yenta: ISA IRQ mask 0x0458, PCI irq 5
Oct 31 17:16:45 t40 kernel: Socket status: 30000006
Oct 31 17:16:45 t40 kernel: mice: PS/2 mouse device common for all mice
Oct 31 17:16:45 t40 kernel: input: PC Speaker
Oct 31 17:16:45 t40 kernel: Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
Oct 31 17:16:45 t40 kernel: ALSA device list:
Oct 31 17:16:45 t40 kernel:   No soundcards found.
Oct 31 17:16:45 t40 kernel: NET: Registered protocol family 2
Oct 31 17:16:45 t40 kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Oct 31 17:16:45 t40 kernel: TCP: Hash tables configured (established 32768 bind 65536)
Oct 31 17:16:45 t40 kernel: Initializing IPsec netlink socket
Oct 31 17:16:45 t40 kernel: NET: Registered protocol family 1
Oct 31 17:16:45 t40 kernel: NET: Registered protocol family 17
Oct 31 17:16:45 t40 kernel: IrCOMM protocol (Dag Brattli)
Oct 31 17:16:45 t40 kernel: Bluetooth: L2CAP ver 2.4
Oct 31 17:16:45 t40 kernel: Bluetooth: L2CAP socket layer initialized
Oct 31 17:16:46 t40 kernel: Bluetooth: SCO (Voice Link) ver 0.3
Oct 31 17:16:46 t40 kernel: Bluetooth: SCO socket layer initialized
Oct 31 17:16:46 t40 kernel: Bluetooth: RFCOMM ver 1.3
Oct 31 17:16:46 t40 kernel: Bluetooth: RFCOMM socket layer initialized
Oct 31 17:16:46 t40 kernel: Bluetooth: RFCOMM TTY layer initialized
Oct 31 17:16:46 t40 kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Oct 31 17:16:46 t40 kernel: Bluetooth: BNEP filters: protocol multicast
Oct 31 17:16:46 t40 kernel: Bluetooth: HIDP (Human Interface Emulation) ver 1.0
Oct 31 17:16:46 t40 kernel: PM: Reading pmdisk image.
Oct 31 17:16:46 t40 kernel: swsusp: Resume From Partition: /dev/hda5
Oct 31 17:16:46 t40 kernel: <3>swsusp: Invalid partition type.
Oct 31 17:16:46 t40 kernel: pmdisk: Error -22 resuming
Oct 31 17:16:46 t40 kernel: PM: Resume from disk failed.
Oct 31 17:16:46 t40 kernel: ACPI: (supports S0 S3 S4 S5)
Oct 31 17:16:46 t40 kernel: ACPI wakeup devices: 
Oct 31 17:16:46 t40 kernel:  LID SLPB PCI0 UART PCI1 USB0 USB1 USB2 AC9M 
Oct 31 17:16:46 t40 kernel: kjournald starting.  Commit interval 5 seconds
Oct 31 17:16:46 t40 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 31 17:16:46 t40 kernel: VFS: Mounted root (ext3 filesystem) readonly.
Oct 31 17:16:46 t40 kernel: Freeing unused kernel memory: 156k freed
Oct 31 17:16:46 t40 kernel: Adding 498920k swap on /dev/hda5.  Priority:-1 extents:1
Oct 31 17:16:46 t40 kernel: EXT3 FS on hda6, internal journal
Oct 31 17:16:46 t40 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 31 17:16:46 t40 kernel: kjournald starting.  Commit interval 5 seconds
Oct 31 17:16:46 t40 kernel: kjournald starting.  Commit interval 600 seconds
Oct 31 17:16:46 t40 kernel: EXT3 FS on hda4, internal journal
Oct 31 17:16:47 t40 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 31 17:16:47 t40 kernel: kjournald starting.  Commit interval 600 seconds
Oct 31 17:16:47 t40 kernel: EXT3 FS on hda7, internal journal
Oct 31 17:16:47 t40 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 31 17:16:47 t40 kernel: usbcore: registered new driver usbfs
Oct 31 17:16:47 t40 kernel: usbcore: registered new driver hub
Oct 31 17:16:47 t40 kernel: USB Universal Host Controller Interface driver v2.2
Oct 31 17:16:47 t40 kernel: ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
Oct 31 17:16:47 t40 kernel: uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
Oct 31 17:16:47 t40 kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Oct 31 17:16:47 t40 kernel: uhci_hcd 0000:00:1d.0: irq 11, io base 0x1800
Oct 31 17:16:47 t40 kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
Oct 31 17:16:47 t40 kernel: hub 1-0:1.0: USB hub found
Oct 31 17:16:47 t40 kernel: hub 1-0:1.0: 2 ports detected
Oct 31 17:16:47 t40 kernel: ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
Oct 31 17:16:47 t40 kernel: uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
Oct 31 17:16:47 t40 kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Oct 31 17:16:47 t40 kernel: uhci_hcd 0000:00:1d.1: irq 11, io base 0x1820
Oct 31 17:16:47 t40 kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
Oct 31 17:16:47 t40 kernel: hub 2-0:1.0: USB hub found
Oct 31 17:16:47 t40 kernel: hub 2-0:1.0: 2 ports detected
Oct 31 17:16:47 t40 kernel: ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
Oct 31 17:16:47 t40 kernel: uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
Oct 31 17:16:47 t40 kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Oct 31 17:16:47 t40 kernel: uhci_hcd 0000:00:1d.2: irq 11, io base 0x1840
Oct 31 17:16:47 t40 kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
Oct 31 17:16:47 t40 kernel: hub 3-0:1.0: USB hub found
Oct 31 17:16:47 t40 kernel: hub 3-0:1.0: 2 ports detected
Oct 31 17:16:47 t40 kernel: usb 2-2: new low speed USB device using uhci_hcd and address 2
Oct 31 17:16:47 t40 kernel: ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
Oct 31 17:16:47 t40 kernel: ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
Oct 31 17:16:47 t40 kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
Oct 31 17:16:47 t40 kernel: ehci_hcd 0000:00:1d.7: irq 11, pci mem 0xc0000000
Oct 31 17:16:47 t40 kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
Oct 31 17:16:47 t40 kernel: PCI: cache line size of 32 is not supported by device 0000:00:1d.7
Oct 31 17:16:47 t40 kernel: ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
Oct 31 17:16:47 t40 kernel: hub 4-0:1.0: USB hub found
Oct 31 17:16:47 t40 kernel: hub 4-0:1.0: 6 ports detected
Oct 31 17:16:47 t40 kernel: usb 2-2: USB disconnect, address 2
Oct 31 17:16:47 t40 kernel: usbcore: registered new driver hiddev
Oct 31 17:16:47 t40 kernel: usbcore: registered new driver usbhid
Oct 31 17:16:47 t40 kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Oct 31 17:16:47 t40 kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
Oct 31 17:16:47 t40 kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
Oct 31 17:16:47 t40 kernel: usb 2-2: new low speed USB device using uhci_hcd and address 3
Oct 31 17:16:47 t40 kernel: input: USB HID v1.10 Mouse [B16_b_02 USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-2
Oct 31 17:16:47 t40 kernel: intel8x0_measure_ac97_clock: measured 49858 usecs
Oct 31 17:16:47 t40 kernel: intel8x0: clocking to 48000
Oct 31 17:16:47 t40 kernel: ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 5 (level, low) -> IRQ 5
Oct 31 17:16:47 t40 kernel: PCI: Setting latency timer of device 0000:00:1f.6 to 64
Oct 31 17:16:47 t40 kernel: Intel(R) PRO/1000 Network Driver - version 5.5.4-k2-NAPI
Oct 31 17:16:47 t40 kernel: Copyright (c) 1999-2004 Intel Corporation.
Oct 31 17:16:47 t40 kernel: ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
Oct 31 17:16:47 t40 kernel: e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Oct 31 17:16:47 t40 kernel: ACPI: Battery Slot [BAT0] (battery present)
Oct 31 17:16:47 t40 kernel: ACPI: AC Adapter [AC] (on-line)
Oct 31 17:16:47 t40 kernel: ACPI: Power Button (FF) [PWRF]
Oct 31 17:16:47 t40 kernel: ACPI: Lid Switch [LID]
Oct 31 17:16:47 t40 kernel: ACPI: Sleep Button (CM) [SLPB]
Oct 31 17:16:47 t40 kernel: ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
Oct 31 17:16:47 t40 kernel: ACPI: Thermal Zone [THM0] (49 C)
Oct 31 17:16:47 t40 kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
Oct 31 17:16:47 t40 kernel: cs: IO port probe 0x0800-0x08ff: clean.
Oct 31 17:16:47 t40 kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Oct 31 17:16:48 t40 kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Oct 31 17:16:48 t40 kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Oct 31 17:16:48 t40 kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
Oct 31 17:16:48 t40 kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
Oct 31 17:16:48 t40 kernel: [drm] Loading R200 Microcode

--Boundary-00=_ajShBhZTUnJfM1S
Content-Type: text/plain;
  charset="iso-8859-15";
  name="syslog-2.6.9-rc4-mm1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="syslog-2.6.9-rc4-mm1"

Oct 29 11:46:32 t40 syslogd 1.4.1#15: restart.
Oct 29 11:46:32 t40 kernel: klogd 1.4.1#15, log source = /proc/kmsg started.
Oct 29 11:46:32 t40 kernel: Cannot find map file.
Oct 29 11:46:32 t40 kernel: No module symbols loaded - kernel modules not enabled. 
Oct 29 11:46:32 t40 kernel: Linux version 2.6.9-rc4-mm1-orig (root@t40) (gcc version 3.3.5 (Debian 1:3.3.5-1)) #2 Fri Oct 22 02:19:30 CEST 2004
Oct 29 11:46:32 t40 kernel: BIOS-provided physical RAM map:
Oct 29 11:46:32 t40 kernel:  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
Oct 29 11:46:32 t40 kernel:  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
Oct 29 11:46:32 t40 kernel:  BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
Oct 29 11:46:32 t40 kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Oct 29 11:46:32 t40 kernel:  BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
Oct 29 11:46:32 t40 kernel:  BIOS-e820: 000000001ff60000 - 000000001ff77000 (ACPI data)
Oct 29 11:46:32 t40 kernel:  BIOS-e820: 000000001ff77000 - 000000001ff79000 (ACPI NVS)
Oct 29 11:46:32 t40 kernel:  BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
Oct 29 11:46:33 t40 kernel:  BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
Oct 29 11:46:33 t40 kernel: 511MB LOWMEM available.
Oct 29 11:46:33 t40 kernel: On node 0 totalpages: 130912
Oct 29 11:46:33 t40 kernel:   DMA zone: 4096 pages, LIFO batch:1
Oct 29 11:46:33 t40 kernel:   Normal zone: 126816 pages, LIFO batch:16
Oct 29 11:46:33 t40 kernel:   HighMem zone: 0 pages, LIFO batch:1
Oct 29 11:46:33 t40 kernel: DMI present.
Oct 29 11:46:33 t40 kernel: ACPI: RSDP (v002 IBM                                   ) @ 0x000f6e00
Oct 29 11:46:33 t40 kernel: ACPI: XSDT (v001 IBM    TP-1R    0x00003051  LTP 0x00000000) @ 0x1ff6af83
Oct 29 11:46:33 t40 kernel: ACPI: FADT (v003 IBM    TP-1R    0x00003051 IBM  0x00000001) @ 0x1ff6b000
Oct 29 11:46:33 t40 kernel: ACPI: SSDT (v001 IBM    TP-1R    0x00003051 MSFT 0x0100000e) @ 0x1ff6b1b4
Oct 29 11:46:33 t40 kernel: ACPI: ECDT (v001 IBM    TP-1R    0x00003051 IBM  0x00000001) @ 0x1ff76e06
Oct 29 11:46:33 t40 kernel: ACPI: TCPA (v001 IBM    TP-1R    0x00003051 PTL  0x00000001) @ 0x1ff76e58
Oct 29 11:46:33 t40 kernel: ACPI: BOOT (v001 IBM    TP-1R    0x00003051  LTP 0x00000001) @ 0x1ff76fd8
Oct 29 11:46:33 t40 kernel: ACPI: DSDT (v001 IBM    TP-1R    0x00003051 MSFT 0x0100000e) @ 0x00000000
Oct 29 11:46:33 t40 kernel: Built 1 zonelists
Oct 29 11:46:34 t40 kernel: Initializing CPU#0
Oct 29 11:46:34 t40 kernel: Kernel command line: auto BOOT_IMAGE=Linux-acpi ro root=306 quiet
Oct 29 11:46:34 t40 kernel: CPU 0 irqstacks, hard=c04c8000 soft=c04c7000
Oct 29 11:46:35 t40 kernel: PID hash table entries: 2048 (order: 11, 32768 bytes)
Oct 29 11:46:35 t40 kernel: Detected 1595.001 MHz processor.
Oct 29 11:46:35 t40 kernel: Using tsc for high-res timesource
Oct 29 11:46:35 t40 kernel: Console: colour VGA+ 80x25
Oct 29 11:46:35 t40 kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Oct 29 11:46:35 t40 kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Oct 29 11:46:35 t40 kernel: Memory: 513160k/523648k available (2631k kernel code, 9992k reserved, 1057k data, 152k init, 0k highmem)
Oct 29 11:46:35 t40 kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Oct 29 11:46:36 t40 kernel: Calibrating delay loop... 3153.92 BogoMIPS (lpj=1576960)
Oct 29 11:46:36 t40 kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Oct 29 11:46:37 t40 kernel: CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000
Oct 29 11:46:37 t40 kernel: CPU: After vendor identify, caps:  a7e9f9bf 00000000 00000000 00000000
Oct 29 11:46:37 t40 kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Oct 29 11:46:37 t40 kernel: CPU: L2 cache: 1024K
Oct 29 11:46:37 t40 kernel: CPU: After all inits, caps:        a7e9f9bf 00000000 00000000 00000040
Oct 29 11:46:37 t40 kernel: Intel machine check architecture supported.
Oct 29 11:46:37 t40 kernel: Intel machine check reporting enabled on CPU#0.
Oct 29 11:46:37 t40 kernel: CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
Oct 29 11:46:37 t40 kernel: Enabling fast FPU save and restore... done.
Oct 29 11:46:37 t40 kernel: Enabling unmasked SIMD FPU exception support... done.
Oct 29 11:46:37 t40 kernel: Checking 'hlt' instruction... OK.
Oct 29 11:46:37 t40 kernel: ACPI: IRQ9 SCI: Edge set to Level Trigger.
Oct 29 11:46:37 t40 kernel: NET: Registered protocol family 16
Oct 29 11:46:37 t40 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=8
Oct 29 11:46:38 t40 kernel: PCI: Using configuration type 1
Oct 29 11:46:38 t40 kernel: mtrr: v2.0 (20020519)
Oct 29 11:46:39 t40 kernel: ACPI: Subsystem revision 20040816
Oct 29 11:46:39 t40 kernel: ACPI: Found ECDT
Oct 29 11:46:40 t40 kernel: ACPI: Interpreter enabled
Oct 29 11:46:40 t40 kernel: ACPI: Using PIC for interrupt routing
Oct 29 11:46:40 t40 kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
Oct 29 11:46:40 t40 kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11)
Oct 29 11:46:40 t40 kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
Oct 29 11:46:41 t40 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
Oct 29 11:46:41 t40 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
Oct 29 11:46:41 t40 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
Oct 29 11:46:41 t40 cardmgr[2918]: watching 2 sockets
Oct 29 11:46:41 t40 kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
Oct 29 11:46:41 t40 cardmgr[2919]: starting, version is 3.2.5
Oct 29 11:46:42 t40 irattach: executing: 'echo t40 > /proc/sys/net/irda/devname'
Oct 29 11:46:43 t40 rpc.statd[2947]: Version 1.0.6 Starting
Oct 29 11:46:43 t40 kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
Oct 29 11:46:43 t40 irattach: Starting device irda0
Oct 29 11:46:43 t40 rpc.statd[2947]: statd running as root. chown /var/lib/nfs/sm to choose different user 
Oct 29 11:46:44 t40 kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Oct 29 11:46:44 t40 kernel: PCI: Probing PCI hardware (bus 00)
Oct 29 11:46:44 t40 kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Oct 29 11:46:44 t40 hcid[2963]: Bluetooth HCI daemon
Oct 29 11:46:44 t40 sdpd[2965]: Bluetooth SDP daemon 
Oct 29 11:46:45 t40 /usr/sbin/cron[2969]: (CRON) INFO (pidfile fd = 3)
Oct 29 11:46:45 t40 kernel: PCI: Transparent bridge - 0000:00:1e.0
Oct 29 11:46:45 t40 hcid[2963]: syntax error line 32 
Oct 29 11:46:45 t40 /usr/sbin/cron[2970]: (CRON) STARTUP (fork ok)
Oct 29 11:46:45 t40 kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Oct 29 11:46:45 t40 /usr/sbin/cron[2970]: (CRON) INFO (Running @reboot jobs)
Oct 29 11:46:45 t40 kernel: ACPI: Embedded Controller [EC] (gpe 28)
Oct 29 11:46:45 t40 kernel: ACPI: Power Resource [PUBS] (on)
Oct 29 11:46:45 t40 kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Oct 29 11:46:45 t40 kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Oct 29 11:46:45 t40 kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Oct 29 11:46:45 t40 kernel: PnPBIOS: Scanning system for PnP BIOS support...
Oct 29 11:46:45 t40 kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00f6e30
Oct 29 11:46:45 t40 kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xb699, dseg 0x400
Oct 29 11:46:45 t40 kernel: PnPBIOS: 19 nodes reported by PnP BIOS; 19 recorded by driver
Oct 29 11:46:45 t40 kernel: SCSI subsystem initialized
Oct 29 11:46:45 t40 kernel: Linux Kernel Card Services
Oct 29 11:46:45 t40 kernel:   options:  [pci] [cardbus] [pm]
Oct 29 11:46:45 t40 kernel: PCI: Using ACPI for IRQ routing
Oct 29 11:46:45 t40 kernel: ** PCI interrupts are no longer routed automatically.  If this
Oct 29 11:46:45 t40 kernel: ** causes a device to stop working, it is probably because the
Oct 29 11:46:45 t40 kernel: ** driver failed to call pci_enable_device().  As a temporary
Oct 29 11:46:45 t40 kernel: ** workaround, the "pci=routeirq" argument restores the old
Oct 29 11:46:45 t40 kernel: ** behavior.  If this argument makes the device work again,
Oct 29 11:46:45 t40 kernel: ** please email the output of "lspci" to bjorn.helgaas@hp.com
Oct 29 11:46:45 t40 kernel: ** so I can fix the driver.
Oct 29 11:46:45 t40 kernel: NET: Registered protocol family 23
Oct 29 11:46:45 t40 kernel: Bluetooth: Core ver 2.6
Oct 29 11:46:45 t40 kernel: NET: Registered protocol family 31
Oct 29 11:46:45 t40 kernel: Bluetooth: HCI device and connection manager initialized
Oct 29 11:46:45 t40 kernel: Bluetooth: HCI socket layer initialized
Oct 29 11:46:45 t40 kernel: pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
Oct 29 11:46:45 t40 kernel: pnp: 00:0b: ioport range 0x1000-0x105f could not be reserved
Oct 29 11:46:45 t40 kernel: pnp: 00:0b: ioport range 0x1060-0x107f has been reserved
Oct 29 11:46:45 t40 kernel: pnp: 00:0b: ioport range 0x1180-0x11bf has been reserved
Oct 29 11:46:45 t40 kernel: Simple Boot Flag at 0x35 set to 0x1
Oct 29 11:46:45 t40 kernel: Machine check exception polling timer started.
Oct 29 11:46:45 t40 kernel: IBM machine detected. Enabling interrupts during APM calls.
Oct 29 11:46:45 t40 kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Oct 29 11:46:45 t40 kernel: apm: overridden by ACPI.
Oct 29 11:46:45 t40 kernel: Initializing Cryptographic API
Oct 29 11:46:45 t40 kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Oct 29 11:46:45 t40 kernel: PCI: setting IRQ 11 as level-triggered
Oct 29 11:46:45 t40 kernel: ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Oct 29 11:46:45 t40 kernel: radeonfb: Retreived PLL infos from BIOS
Oct 29 11:46:45 t40 kernel: radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=252.00 Mhz, System=200.00 MHz
Oct 29 11:46:45 t40 kernel: radeonfb: PLL min 20000 max 35000
Oct 29 11:46:45 t40 kernel: Non-DDC laptop panel detected
Oct 29 11:46:45 t40 kernel: radeonfb: Monitor 1 type LCD found
Oct 29 11:46:45 t40 kernel: radeonfb: Monitor 2 type no found
Oct 29 11:46:45 t40 kernel: radeonfb: panel ID string: SXGA+ Single (85MHz)    
Oct 29 11:46:45 t40 kernel: radeonfb: detected LVDS panel size from BIOS: 1400x1050
Oct 29 11:46:45 t40 kernel: radeondb: BIOS provided dividers will be used
Oct 29 11:46:45 t40 kernel: radeonfb: Power Management enabled for Mobility chipsets
Oct 29 11:46:45 t40 kernel: Console: switching to colour frame buffer device 175x65
Oct 29 11:46:45 t40 kernel: radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
Oct 29 11:46:45 t40 kernel: isapnp: Scanning for PnP cards...
Oct 29 11:46:45 t40 kernel: isapnp: No Plug & Play device found
Oct 29 11:46:46 t40 kernel: lp: driver loaded but no devices found
Oct 29 11:46:46 t40 kernel: Real Time Clock Driver v1.12
Oct 29 11:46:46 t40 kernel: Non-volatile memory driver v1.2
Oct 29 11:46:46 t40 kernel: Linux agpgart interface v0.100 (c) Dave Jones
Oct 29 11:46:46 t40 kernel: agpgart: Detected an Intel 855PM Chipset.
Oct 29 11:46:46 t40 kernel: agpgart: Maximum main memory to use for agp memory: 439M
Oct 29 11:46:46 t40 kernel: agpgart: AGP aperture is 256M @ 0xd0000000
Oct 29 11:46:46 t40 kernel: ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Oct 29 11:46:46 t40 kernel: [drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9]
Oct 29 11:46:46 t40 kernel: ACPI: PS/2 Keyboard Controller [KBD] at I/O 0x60, 0x64, irq 1
Oct 29 11:46:46 t40 kernel: ACPI: PS/2 Mouse Controller [MOU] at irq 12
Oct 29 11:46:46 t40 kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Oct 29 11:46:46 t40 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Oct 29 11:46:46 t40 kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
Oct 29 11:46:46 t40 kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
Oct 29 11:46:46 t40 kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
Oct 29 11:46:46 t40 kernel: PCI: setting IRQ 5 as level-triggered
Oct 29 11:46:46 t40 kernel: ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 5 (level, low) -> IRQ 5
Oct 29 11:46:46 t40 kernel: pnp: Device 00:12 activated.
Oct 29 11:46:46 t40 kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
Oct 29 11:46:46 t40 kernel: parport: PnPBIOS parport detected.
Oct 29 11:46:46 t40 kernel: parport0: PC-style at 0x3bc, irq 7 [PCSPP,TRISTATE]
Oct 29 11:46:46 t40 kernel: lp0: using parport0 (interrupt-driven).
Oct 29 11:46:46 t40 kernel: io scheduler noop registered
Oct 29 11:46:46 t40 kernel: io scheduler anticipatory registered
Oct 29 11:46:46 t40 kernel: io scheduler deadline registered
Oct 29 11:46:46 t40 kernel: io scheduler cfq registered
Oct 29 11:46:46 t40 kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Oct 29 11:46:46 t40 kernel: loop: loaded (max 8 devices)
Oct 29 11:46:46 t40 kernel: pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Oct 29 11:46:46 t40 kernel: Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Oct 29 11:46:46 t40 kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Oct 29 11:46:46 t40 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Oct 29 11:46:46 t40 kernel: ICH4: IDE controller at PCI slot 0000:00:1f.1
Oct 29 11:46:46 t40 kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Oct 29 11:46:46 t40 kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
Oct 29 11:46:46 t40 kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
Oct 29 11:46:46 t40 kernel: ICH4: chipset revision 1
Oct 29 11:46:46 t40 kernel: ICH4: not 100%% native mode: will probe irqs later
Oct 29 11:46:46 t40 kernel:     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
Oct 29 11:46:46 t40 kernel:     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Oct 29 11:46:46 t40 kernel: Probing IDE interface ide0...
Oct 29 11:46:46 t40 kernel: hda: IC25N040ATCS05-0, ATA DISK drive
Oct 29 11:46:46 t40 kernel: elevator: using anticipatory as default io scheduler
Oct 29 11:46:46 t40 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Oct 29 11:46:46 t40 kernel: Probing IDE interface ide1...
Oct 29 11:46:46 t40 kernel: hdc: UJDA745 DVD/CDRW, ATAPI CD/DVD-ROM drive
Oct 29 11:46:46 t40 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Oct 29 11:46:46 t40 kernel: Probing IDE interface ide2...
Oct 29 11:46:46 t40 kernel: ide2: Wait for ready failed before probe !
Oct 29 11:46:46 t40 kernel: Probing IDE interface ide3...
Oct 29 11:46:46 t40 kernel: ide3: Wait for ready failed before probe !
Oct 29 11:46:46 t40 kernel: Probing IDE interface ide4...
Oct 29 11:46:46 t40 kernel: ide4: Wait for ready failed before probe !
Oct 29 11:46:46 t40 kernel: Probing IDE interface ide5...
Oct 29 11:46:46 t40 kernel: ide5: Wait for ready failed before probe !
Oct 29 11:46:46 t40 kernel: hda: max request size: 128KiB
Oct 29 11:46:46 t40 kernel: hda: 78140160 sectors (40007 MB) w/7898KiB Cache, CHS=65535/16/63, UDMA(100)
Oct 29 11:46:46 t40 kernel: hda: cache flushes not supported
Oct 29 11:46:46 t40 kernel:  hda: hda1 hda2 hda3 < hda5 hda6 hda7 > hda4
Oct 29 11:46:46 t40 kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Oct 29 11:46:46 t40 kernel: Uniform CD-ROM driver Revision: 3.20
Oct 29 11:46:46 t40 kernel: ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Oct 29 11:46:46 t40 kernel: Yenta: CardBus bridge found at 0000:02:00.0 [1014:0512]
Oct 29 11:46:46 t40 kernel: Yenta: Using INTVAL to route CSC interrupts to PCI
Oct 29 11:46:46 t40 kernel: Yenta: Routing CardBus interrupts to PCI
Oct 29 11:46:46 t40 kernel: Yenta TI: socket 0000:02:00.0, mfunc 0x01d21022, devctl 0x64
Oct 29 11:46:46 t40 kernel: Yenta: ISA IRQ mask 0x0458, PCI irq 11
Oct 29 11:46:46 t40 kernel: Socket status: 30000006
Oct 29 11:46:46 t40 kernel: ACPI: PCI interrupt 0000:02:00.1[B] -> GSI 5 (level, low) -> IRQ 5
Oct 29 11:46:46 t40 kernel: Yenta: CardBus bridge found at 0000:02:00.1 [1014:0512]
Oct 29 11:46:46 t40 kernel: Yenta: Using INTVAL to route CSC interrupts to PCI
Oct 29 11:46:46 t40 kernel: Yenta: Routing CardBus interrupts to PCI
Oct 29 11:46:46 t40 kernel: Yenta TI: socket 0000:02:00.1, mfunc 0x01d21022, devctl 0x64
Oct 29 11:46:46 t40 kernel: Yenta: ISA IRQ mask 0x0458, PCI irq 5
Oct 29 11:46:46 t40 kernel: Socket status: 30000006
Oct 29 11:46:46 t40 kernel: mice: PS/2 mouse device common for all mice
Oct 29 11:46:46 t40 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Oct 29 11:46:46 t40 kernel: Synaptics Touchpad, model: 1
Oct 29 11:46:46 t40 kernel:  Firmware: 5.9
Oct 29 11:46:46 t40 kernel:  Sensor: 44
Oct 29 11:46:46 t40 kernel:  new absolute packet format
Oct 29 11:46:46 t40 kernel:  Touchpad has extended capability bits
Oct 29 11:46:46 t40 kernel:  -> multifinger detection
Oct 29 11:46:46 t40 kernel:  -> palm detection
Oct 29 11:46:46 t40 kernel:  -> pass-through port
Oct 29 11:46:46 t40 kernel: input: SynPS/2 Synaptics TouchPad on isa0060/serio1
Oct 29 11:46:46 t40 kernel: serio: Synaptics pass-through port at isa0060/serio1/input0
Oct 29 11:46:46 t40 kernel: input: PS/2 Generic Mouse on synaptics-pt/serio0
Oct 29 11:46:46 t40 kernel: input: PC Speaker
Oct 29 11:46:46 t40 kernel: Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
Oct 29 11:46:46 t40 kernel: ALSA device list:
Oct 29 11:46:46 t40 kernel:   No soundcards found.
Oct 29 11:46:46 t40 kernel: NET: Registered protocol family 2
Oct 29 11:46:46 t40 kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Oct 29 11:46:46 t40 kernel: TCP: Hash tables configured (established 32768 bind 65536)
Oct 29 11:46:46 t40 kernel: Initializing IPsec netlink socket
Oct 29 11:46:46 t40 kernel: NET: Registered protocol family 1
Oct 29 11:46:46 t40 kernel: NET: Registered protocol family 17
Oct 29 11:46:46 t40 kernel: IrCOMM protocol (Dag Brattli)
Oct 29 11:46:46 t40 kernel: Bluetooth: L2CAP ver 2.4
Oct 29 11:46:46 t40 kernel: Bluetooth: L2CAP socket layer initialized
Oct 29 11:46:46 t40 kernel: Bluetooth: SCO (Voice Link) ver 0.3
Oct 29 11:46:46 t40 kernel: Bluetooth: SCO socket layer initialized
Oct 29 11:46:46 t40 kernel: Bluetooth: RFCOMM ver 1.3
Oct 29 11:46:46 t40 kernel: Bluetooth: RFCOMM socket layer initialized
Oct 29 11:46:46 t40 kernel: Bluetooth: RFCOMM TTY layer initialized
Oct 29 11:46:46 t40 kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Oct 29 11:46:46 t40 kernel: Bluetooth: BNEP filters: protocol multicast
Oct 29 11:46:46 t40 kernel: Bluetooth: HIDP (Human Interface Emulation) ver 1.0
Oct 29 11:46:46 t40 kernel: speedstep-centrino: found "Intel(R) Pentium(R) M processor 1600MHz": max frequency: 1600000kHz
Oct 29 11:46:46 t40 kernel: PM: Reading pmdisk image.
Oct 29 11:46:46 t40 kernel: swsusp: Resume From Partition: /dev/hda5
Oct 29 11:46:47 t40 kernel: <3>swsusp: Invalid partition type.
Oct 29 11:46:47 t40 kernel: pmdisk: Error -22 resuming
Oct 29 11:46:47 t40 kernel: PM: Resume from disk failed.
Oct 29 11:46:48 t40 kernel: ACPI: (supports S0 S3 S4 S5)
Oct 29 11:46:48 t40 kernel: ACPI wakeup devices: 
Oct 29 11:46:48 t40 kernel:  LID SLPB PCI0 UART PCI1 USB0 USB1 USB2 AC9M 
Oct 29 11:46:48 t40 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 29 11:46:48 t40 kernel: VFS: Mounted root (ext3 filesystem) readonly.
Oct 29 11:46:48 t40 kernel: Freeing unused kernel memory: 152k freed
Oct 29 11:46:48 t40 kernel: kjournald starting.  Commit interval 5 seconds
Oct 29 11:46:48 t40 kernel: hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Oct 29 11:46:48 t40 kernel: hdc: drive_cmd: error=0x04Aborted Command 
Oct 29 11:46:48 t40 kernel: Adding 498920k swap on /dev/hda5.  Priority:-1 extents:1
Oct 29 11:46:48 t40 kernel: EXT3 FS on hda6, internal journal
Oct 29 11:46:48 t40 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 29 11:46:48 t40 kernel: kjournald starting.  Commit interval 5 seconds
Oct 29 11:46:48 t40 kernel: kjournald starting.  Commit interval 600 seconds
Oct 29 11:46:48 t40 kernel: EXT3 FS on hda4, internal journal
Oct 29 11:46:48 t40 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 29 11:46:48 t40 kernel: kjournald starting.  Commit interval 600 seconds
Oct 29 11:46:48 t40 kernel: EXT3 FS on hda7, internal journal
Oct 29 11:46:48 t40 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 29 11:46:48 t40 kernel: usbcore: registered new driver usbfs
Oct 29 11:46:48 t40 kernel: usbcore: registered new driver hub
Oct 29 11:46:48 t40 kernel: USB Universal Host Controller Interface driver v2.2
Oct 29 11:46:48 t40 kernel: ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
Oct 29 11:46:48 t40 kernel: uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
Oct 29 11:46:48 t40 kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Oct 29 11:46:48 t40 kernel: uhci_hcd 0000:00:1d.0: irq 11, io base 0x1800
Oct 29 11:46:48 t40 kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
Oct 29 11:46:48 t40 kernel: hub 1-0:1.0: USB hub found
Oct 29 11:46:48 t40 kernel: hub 1-0:1.0: 2 ports detected
Oct 29 11:46:48 t40 kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
Oct 29 11:46:48 t40 kernel: ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
Oct 29 11:46:48 t40 kernel: uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
Oct 29 11:46:48 t40 kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Oct 29 11:46:48 t40 kernel: uhci_hcd 0000:00:1d.1: irq 11, io base 0x1820
Oct 29 11:46:48 t40 kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
Oct 29 11:46:48 t40 kernel: hub 2-0:1.0: USB hub found
Oct 29 11:46:48 t40 kernel: hub 2-0:1.0: 2 ports detected
Oct 29 11:46:48 t40 kernel: ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
Oct 29 11:46:48 t40 kernel: uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
Oct 29 11:46:48 t40 kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Oct 29 11:46:48 t40 kernel: uhci_hcd 0000:00:1d.2: irq 11, io base 0x1840
Oct 29 11:46:48 t40 kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
Oct 29 11:46:48 t40 kernel: hub 3-0:1.0: USB hub found
Oct 29 11:46:48 t40 kernel: hub 3-0:1.0: 2 ports detected
Oct 29 11:46:48 t40 kernel: usb 2-1: new low speed USB device using address 2
Oct 29 11:46:48 t40 kernel: usbcore: registered new driver hiddev
Oct 29 11:46:48 t40 kernel: input: USB HID v1.10 Mouse [B16_b_02 USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
Oct 29 11:46:48 t40 kernel: usbcore: registered new driver usbhid
Oct 29 11:46:48 t40 kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Oct 29 11:46:48 t40 kernel: ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
Oct 29 11:46:48 t40 kernel: ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
Oct 29 11:46:48 t40 kernel: ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
Oct 29 11:46:48 t40 kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
Oct 29 11:46:48 t40 kernel: ehci_hcd 0000:00:1d.7: irq 11, pci mem 0xc0000000
Oct 29 11:46:48 t40 kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
Oct 29 11:46:48 t40 kernel: PCI: cache line size of 32 is not supported by device 0000:00:1d.7
Oct 29 11:46:48 t40 kernel: ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
Oct 29 11:46:48 t40 kernel: usb 2-1: USB disconnect, address 2
Oct 29 11:46:48 t40 kernel: hub 4-0:1.0: USB hub found
Oct 29 11:46:48 t40 kernel: hub 4-0:1.0: 6 ports detected
Oct 29 11:46:48 t40 kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
Oct 29 11:46:48 t40 kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
Oct 29 11:46:48 t40 kernel: usb 2-1: new low speed USB device using address 3
Oct 29 11:46:48 t40 kernel: input: USB HID v1.10 Mouse [B16_b_02 USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
Oct 29 11:46:48 t40 kernel: intel8x0_measure_ac97_clock: measured 49436 usecs
Oct 29 11:46:48 t40 kernel: intel8x0: clocking to 48000
Oct 29 11:46:48 t40 kernel: ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 5 (level, low) -> IRQ 5
Oct 29 11:46:48 t40 kernel: PCI: Setting latency timer of device 0000:00:1f.6 to 64
Oct 29 11:46:48 t40 kernel: Intel(R) PRO/1000 Network Driver - version 5.3.19-k2-NAPI
Oct 29 11:46:48 t40 kernel: Copyright (c) 1999-2004 Intel Corporation.
Oct 29 11:46:48 t40 kernel: ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
Oct 29 11:46:48 t40 kernel: e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Oct 29 11:46:48 t40 kernel: ath_hal: module license 'Proprietary' taints kernel.
Oct 29 11:46:48 t40 kernel: ath_hal: 0.9.12.14 (AR5210, AR5211, AR5212)
Oct 29 11:46:48 t40 kernel: wlan: 0.8.4.4 (EXPERIMENTAL)
Oct 29 11:46:48 t40 kernel: ath_rate_onoe: 1.0
Oct 29 11:46:48 t40 kernel: ath_pci: 0.9.4.10 (EXPERIMENTAL)
Oct 29 11:46:48 t40 kernel: ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
Oct 29 11:46:48 t40 kernel: ath0: 11a rates: 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
Oct 29 11:46:48 t40 kernel: ath0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
Oct 29 11:46:48 t40 kernel: ath0: mac 4.2 phy 3.0 5ghz radio 1.7 2ghz radio 2.3
Oct 29 11:46:48 t40 kernel: ath0: 802.11 address: 00:05:4e:40:47:08
Oct 29 11:46:48 t40 kernel: ath0: Use hw queue 0 for WME_AC_BE traffic
Oct 29 11:46:48 t40 kernel: ath0: Use hw queue 0 for WME_AC_BK traffic
Oct 29 11:46:48 t40 kernel: ath0: Use hw queue 0 for WME_AC_VI traffic
Oct 29 11:46:48 t40 kernel: ath0: Use hw queue 0 for WME_AC_VO traffic
Oct 29 11:46:48 t40 kernel: ath0: Atheros 5211: mem=0xc0210000, irq=11
Oct 29 11:46:48 t40 kernel: ath_pci: No devices found, driver not installed.
Oct 29 11:46:48 t40 kernel: ACPI: Battery Slot [BAT0] (battery present)
Oct 29 11:46:48 t40 kernel: ACPI: AC Adapter [AC] (on-line)
Oct 29 11:46:48 t40 kernel: ACPI: Power Button (FF) [PWRF]
Oct 29 11:46:48 t40 kernel: ACPI: Lid Switch [LID]
Oct 29 11:46:48 t40 kernel: ACPI: Sleep Button (CM) [SLPB]
Oct 29 11:46:48 t40 kernel: ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
Oct 29 11:46:48 t40 kernel: ACPI: Thermal Zone [THM0] (57 C)
Oct 29 11:46:48 t40 kernel: cs: IO port probe 0x0100-0x04ff: clean.
Oct 29 11:46:48 t40 kernel: cs: IO port probe 0x0800-0x08ff: clean.
Oct 29 11:46:48 t40 kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Oct 29 11:46:48 t40 kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Oct 29 11:46:48 t40 kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Oct 29 11:46:48 t40 kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
Oct 29 11:46:48 t40 kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
Oct 29 11:46:48 t40 kernel: [drm] Loading R200 Microcode
Oct 29 11:47:41 t40 kernel: Intel(R) PRO/1000 Network Driver - version 5.3.19-k2-NAPI
Oct 29 11:47:41 t40 kernel: Copyright (c) 1999-2004 Intel Corporation.
Oct 29 11:47:41 t40 kernel: ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
Oct 29 11:47:41 t40 kernel: e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection

--Boundary-00=_ajShBhZTUnJfM1S
Content-Type: text/plain;
  charset="iso-8859-15";
  name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.10-rc1-mm2
# Sun Oct 31 16:55:05 2004
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y

#
# General setup
#
CONFIG_LOCALVERSION="-orig"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HPET_TIMER is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y
CONFIG_REGPARM=y

#
# Performance-monitoring counters support
#
# CONFIG_PERFCTR is not set
CONFIG_KERN_PHYS_OFFSET=1
# CONFIG_KEXEC is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION="/dev/hda5"

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
CONFIG_ACPI_THINKPAD=m
CONFIG_ACPI_IBM=m
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set
CONFIG_ACPI_CONTAINER=m

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_DEBUG is not set
# CONFIG_CPU_FREQ_PROC_INTF is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_24_API is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_TABLE=y

#
# CPUFreq processor drivers
#
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# shared options
#

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
CONFIG_PCCARD=y
# CONFIG_PCMCIA_DEBUG is not set
# CONFIG_PCMCIA_OBSOLETE is not set
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=y
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
# CONFIG_PNPBIOS_PROC_FS is not set
CONFIG_PNPACPI=y

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_IDE_TASK_IOCTL=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLOGIC_1280_1040 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set
# CONFIG_PCMCIA_SYM53C500 is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y
CONFIG_INET_TUNNEL=y
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set
CONFIG_XFRM=y
CONFIG_XFRM_USER=y

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
CONFIG_IRDA=y

#
# IrDA protocols
#
CONFIG_IRLAN=y
# CONFIG_IRNET is not set
CONFIG_IRCOMM=y
CONFIG_IRDA_ULTRA=y

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
# CONFIG_IRDA_FAST_RR is not set
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m

#
# Dongle support
#
# CONFIG_DONGLE is not set

#
# Old SIR device drivers
#
# CONFIG_IRPORT_SIR is not set

#
# Old Serial dongle support
#

#
# FIR device drivers
#
# CONFIG_USB_IRDA is not set
# CONFIG_SIGMATEL_FIR is not set
CONFIG_NSC_FIR=m
# CONFIG_WINBOND_FIR is not set
# CONFIG_TOSHIBA_FIR is not set
# CONFIG_SMC_IRCC_FIR is not set
# CONFIG_ALI_FIR is not set
# CONFIG_VLSI_FIR is not set
# CONFIG_VIA_FIR is not set
CONFIG_BT=y
CONFIG_BT_L2CAP=y
CONFIG_BT_SCO=y
CONFIG_BT_RFCOMM=y
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=y
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=y

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBFUSB is not set
# CONFIG_BT_HCIDTL1 is not set
# CONFIG_BT_HCIBT3C is not set
# CONFIG_BT_HCIBLUECARD is not set
# CONFIG_BT_HCIBTUART is not set
# CONFIG_BT_HCIVHCI is not set
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=y
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=m
CONFIG_E1000_NAPI=y
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_PCMCIA_NETWAVE is not set

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
# CONFIG_AIRO is not set
# CONFIG_HERMES is not set
# CONFIG_ATMEL is not set

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
# CONFIG_AIRO_CS is not set
# CONFIG_PCMCIA_WL3501 is not set

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
# CONFIG_PRISM54 is not set
CONFIG_NET_WIRELESS=y

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1400
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1050
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_UINPUT=y

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=2
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_MULTIPORT is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_I2C_CHARDEV is not set

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_ISA is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set

#
# Other I2C Chip support
#
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_VIDEO_SELECT is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
CONFIG_FB_RADEON=y
# CONFIG_FB_RADEON_I2C is not set
# CONFIG_FB_RADEON_DEBUG is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# USB devices
#
CONFIG_SND_USB_AUDIO=m
# CONFIG_SND_USB_USX2Y is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_VXP440 is not set
# CONFIG_SND_PDAUDIOCF is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m

#
# USB Bluetooth TTY can only be used with disabled Bluetooth subsystem
#
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_RW_DETECT is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Input Devices
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
CONFIG_USB_KBTAB=m
CONFIG_USB_POWERMATE=m
CONFIG_USB_MTOUCH=m
CONFIG_USB_EGALAX=m
CONFIG_USB_XPAD=m
CONFIG_USB_ATI_REMOTE=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m

#
# USB Multimedia devices
#
CONFIG_USB_DABUSB=m

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=m
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_TIGL=m
CONFIG_USB_AUERSWALD=m
CONFIG_USB_RIO500=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_LED=m
CONFIG_USB_CYTHERM=m
# CONFIG_USB_PHIDGETKIT is not set
CONFIG_USB_PHIDGETSERVO=m
# CONFIG_USB_TEST is not set

#
# USB ATM/DSL drivers
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_CIFS is not set
CONFIG_NCP_FS=m
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
CONFIG_NCPFS_NFS_NS=y
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=m
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_PREEMPT is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_4KSTACKS=y
# CONFIG_KGDB is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_AES_586 is not set
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC_CCITT=y
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--Boundary-00=_ajShBhZTUnJfM1S--
