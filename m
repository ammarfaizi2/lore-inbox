Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263389AbTCNQDj>; Fri, 14 Mar 2003 11:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263365AbTCNQDi>; Fri, 14 Mar 2003 11:03:38 -0500
Received: from [80.88.111.2] ([80.88.111.2]:18451 "EHLO gandalf.benka.com")
	by vger.kernel.org with ESMTP id <S263389AbTCNQDD>;
	Fri, 14 Mar 2003 11:03:03 -0500
Date: Fri, 14 Mar 2003 17:22:30 +0100
From: lasse <lasse@st0kk.com>
To: linux-kernel@vger.kernel.org
Subject: Problem upgrading kernel 2.2.x ->2.4.x it's a case of "Cannot find
 device "341"
Message-Id: <20030314172230.06415f62.lasse@st0kk.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I hope this is the right list.
Now i have a couple of motorolas cpn 5360's and cpn5300. on the 5300 i have no problems with 2.4 or 2.2 kernels. But i have not been able boot with the 2.4.x kernel, as far as i can understand it looks like a ide problem. 
Im sorry about the long post.. but i'm not sure i can explan the problem without showing the bootup message.

I hope this information helps to understand what goes wrong.



--------2.2.20-bootup------
PhoenixPICOBIOS 4.0 Release 6.0     Copyright 1985-2000 Phoenix Technologies Ltd.All Rights ReservedCPN5360 BIOS 2.0RM01, Copyright 1999-2000 Motorola, Inc.Build Time: 09/12/00 14:45:20     CPU = Intel(R) Mobile Pentium(R) II processor  333 MHzPress <F2> to enter SETUP640K System RAM Passed127M Extended RAM Passed256K Cache SRAM PassedSystem BIOS shadowedVideo BIOS shadowedUMB upper limit segment address: E674Fixed Disk 0: SunDisk SDTB-128                        Fixed Disk 1: IBM-DBCA-206480                                             version 2.2.20 (root@cpn5360) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Tue Mar 4 13:59:00 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0009e000 @ 00000000 (usable)
 BIOS-e820: 07f00000 @ 00100000 (usable)
Detected 332505 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 663.55 BogoMIPS
Memory: 127484k/131072k available (1460k kernel code, 416k reserved, 1588k data, 124k init)
Dentry hash table entries: 16384 (order 5, 128k)
Buffer cache hash table entries: 131072 (order 7, 512k)
Page cache hash table entries: 32768 (order 5, 128k)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
256K L2 cache (4 way)
CPU: L2 Cache: 256K
CPU: Intel Mobile Pentium II stepping 0a
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xfd99e
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Enabling I/O for device 00:88
PCI: Enabling memory for device 00:88
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 131072 bhash 65536)
Starting kswapd v 1.5 
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
Console: switching to colour frame buffer device 80x30
fb0: VGA16 VGA frame buffer device
Detected PS/2 Mouse Port.
Serial driver version 4.27 with<4>keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
 HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1440-0x1447, BIOS settings: hda:pio, hdb:DMA
hda: SunDisk SDTB-128, ATA DISK drive
hdb: IBM-DBCA-206480, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: SunDisk SDTB-128, 15MB w/1kB Cache, CHS=490/2/32
hdb: IBM-DBCA-206480, 6194MB w/420kB Cache, CHS=789/255/63, UDMA
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
aacraid raid driver version, Mar  4 2003
scsi: <fdomain> Detection failed (no card)
DC390: 0 adapters found
scsi : 0 hosts.
scsi : detected total.
cpqarray: Sorry, I don't know how to access the SMART Array controller 00000000
3c59x.c 18Feb01 Donald Becker and others http://www.scyld.com/network/vortex.html
pcnet32.c: PCI bios is present, checking for devices...
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com> 2000/11/15
eth0: OEM i82557/i82558 10/100 Ethernet, 00:01:AF:01:BC:2B, IRQ 10.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 413503-241, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com> 2000/11/15
via-rhine.c:v1.08b-LK1.0.1 12/14/2000  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
Partition check:
 hda:
 hdb: hdb1 hdb2 hdb4 < hdb5 hdb6 hdb7 >
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 124k freed
INIT: version 2.84 booting
Activating swap.
Adding Swap: 192772k swap-space (priority -1)
Checking root file system...
fsck 1.27 (8-Mar-2002)
/dev/hdb1: clean, 6891/122880 files, 35373/489951 blocks
/etc/init.d/rcS: System clock was not updated at this time.
Calculating module dependencies... done.
Loading modules: af_packet linear modprobe: Can't locate module linear

Checking all file systems...
fsck 1.27 (8-Mar-2002)
/dev/hdb5: clean, 33174/256512 files, 197162/512064 blocks
Setting kernel variables.
Mounting local filesystems...
/dev/hdb5 on /usr type ext2 (rw,errors=remount-ro)
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
/dev/hdb6 on /var type ext2 (rw)
Running 0dns-down to make sure resolv.conf is ok...done.
Cleaning: /etc/network/ifstate.
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces: done.
Starting portmap daemon: portmap.

Setting the System Clock using the Hardware Clock as reference...
modprobe: modprobe: Can't locate module char-major-10-135
System Clock set. Local time: Thu Mar 13 19:05:53 CET 2003

Cleaning: /tmp /var/lock /var/run.
Initializing random number generator... rm: cannot remove `/var/lib/urandom/random-seed': Input/output error
urandom start: failed.
done.
Recovering nvi editor sessions... done.
INIT: Entering runlevel: 2
Starting system log daemon: syslogd.
Starting kernel log daemon: klogd.
Starting NFS common utilities: statd lockd.
Setting NIS domainname to: lanparty
Starting NIS services: ypbind 
Starting automounter:  /var/autofs/misc /var/autofs/net /homedone.
Starting internet superserver: inetd.
Not starting NFS kernel daemon: No exports.
Starting OpenBSD Secure Shell server: sshd.
Starting uptime daemon: uptimed.
Starting X font server: xfs.
Starting NTP server: ntpd.
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: cron.
Starting X display manager: xdm.

Debian GNU/Linux 3.0 cpn5360 ttyS0

cpn5360 login:
----------------/2.2.20-boot-up-----

And now the kernel i want to use.

----------------2.4.18-fail---------
PhoenixPICOBIOS 4.0 Release 6.0     Copyright 1985-2000 Phoenix Technologies Ltd.All Rights ReservedCPN5360 BIOS 2.0RM01, Copyright 1999-2000 Motorola, Inc.Build Time: 09/12/00 14:45:20     CPU = Intel(R) Mobile Pentium(R) II processor  333 MHzPress <F2> to enter SETUP640K System RAM Passed127M Extended RAM Passed256K Cache SRAM PassedSystem BIOS shadowedVideo BIOS shadowedUMB upper limit segment address: E674Fixed Disk 0: SunDisk SDTB-128                        Fixed Disk 1: IBM-DBCA-206480                                              
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
 BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6400 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=2.4 ro root=341 console=ttyS0,38400
Initializing CPU#0
Detected 332.507 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 663.55 BogoMIPS
Memory: 126204k/131072k available (1495k kernel code, 4476k reserved, 441k data, 232k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Mobile Pentium II stepping 0a
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd99e, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Found IRQ 5 for device 00:11.0
PCI: Sharing IRQ 5 with 01:00.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
udf: registering filesystem
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1440-0x1447, BIOS settings: hda:pio, hdb:DMA
hda: SunDisk SDTB-128, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 31360 sectors (16 MB) w/1KiB Cache, CHS=490/2/32
Partition check:
 /dev/ide/host0/bus0/target0/lun0:
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 10 for device 00:12.0
eth0: OEM i82557/i82558 10/100 Ethernet, 00:01:AF:01:BC:2B, IRQ 10.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 413503-241, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 96M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xf8000000
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: not found.
md: linear personality registered as nr 1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Cannot open root device "341" or 03:41
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 03:41
--------------/2.4.18-fail 


/Lasse
