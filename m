Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbSK0DjK>; Tue, 26 Nov 2002 22:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261524AbSK0DjK>; Tue, 26 Nov 2002 22:39:10 -0500
Received: from server1.safepages.com ([216.127.146.3]:11273 "EHLO
	server1.safepages.com") by vger.kernel.org with ESMTP
	id <S261492AbSK0DjA>; Tue, 26 Nov 2002 22:39:00 -0500
Message-ID: <3DE43F4B.EABBA93@tfn.net>
Date: Tue, 26 Nov 2002 22:43:07 -0500
From: Charles Bibber <cab3@tfn.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19-6.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM  RedHat Linux 6.2 / kernel 2.2.22-6.2.3
Content-Type: multipart/mixed;
 boundary="------------8509053D8C4EAF3C7E28468D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8509053D8C4EAF3C7E28468D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Problem involves RedHat Linux 6.2 / kernel 2.2.22-6.2.3 PCMCIA fails
after upgrade from kernel version 2.2.19-6.2.16. Message log on startup
is in attachment tempfile attached to this e-mail. The only resolution I
have found is to reboot the old kernel. I had installed kernel
2.2.22-6.2.2 and the same problem existed. Please advise
--------------8509053D8C4EAF3C7E28468D
Content-Type: text/plain; charset=us-ascii;
 name="tempfile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tempfile"


Nov 26 15:51:38 Begin 1st boot of 2.2.2-6.2.3 kernel update cb3
Nov 26 15:52:53 cbibber syslogd 1.3-3: restart.
Nov 26 15:52:53 cbibber syslog: syslogd startup succeeded
Nov 26 15:52:53 cbibber syslog: klogd startup succeeded
Nov 26 15:52:53 cbibber kernel: klogd 1.3-3, log source = /proc/kmsg started.
Nov 26 15:52:53 cbibber kernel: Inspecting /boot/System.map-2.2.22-6.2.3
Nov 26 15:52:55 cbibber identd: identd startup succeeded
Nov 26 15:52:55 cbibber kernel: Loaded 7363 symbols from /boot/System.map-2.2.22-6.2.3.
Nov 26 15:52:55 cbibber kernel: Symbols match kernel version 2.2.22.
Nov 26 15:52:55 cbibber kernel: Loaded 17 symbols from 2 modules.
Nov 26 15:52:55 cbibber kernel: Linux version 2.2.22-6.2.3 (bhcompile@bugs.devel.redhat.com) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Thu Nov 21 14:00:18 EST 2002 
Nov 26 15:52:55 cbibber kernel: BIOS-provided physical RAM map: 
Nov 26 15:52:55 cbibber kernel:  BIOS-e820: 0009f000 @ 00000000 (usable) 
Nov 26 15:52:55 cbibber kernel:  BIOS-e820: 02700000 @ 00100000 (usable) 
Nov 26 15:52:55 cbibber kernel: Detected 119753 kHz processor. 
Nov 26 15:52:55 cbibber kernel: ide_setup: hdb=ide-scsi 
Nov 26 15:52:55 cbibber kernel: ide_setup: hdg=ide-scsi 
Nov 26 15:52:55 cbibber kernel: Console: colour VGA+ 80x25 
Nov 26 15:52:55 cbibber kernel: Calibrating delay loop... 238.38 BogoMIPS 
Nov 26 15:52:55 cbibber kernel: Memory: 38556k/40960k available (1080k kernel code, 412k reserved, 840k data, 72k init, 0k bigmem) 
Nov 26 15:52:55 cbibber kernel: Dentry hash table entries: 8192 (order 4, 64k) 
Nov 26 15:52:55 cbibber kernel: Buffer cache hash table entries: 65536 (order 6, 256k) 
Nov 26 15:52:55 cbibber kernel: Page cache hash table entries: 16384 (order 4, 64k) 
Nov 26 15:52:55 cbibber kernel: VFS: Diskquotas version dquot_6.4.0 initialized 
Nov 26 15:52:55 cbibber kernel: Intel old style machine check architecture supported. 
Nov 26 15:52:55 cbibber kernel: Intel old style machine check reporting enabled on CPU#0. 
Nov 26 15:52:55 cbibber kernel: CPU: Intel Pentium 75 - 200 stepping 0c 
Nov 26 15:52:55 cbibber kernel: Checking 386/387 coupling... OK, FPU using exception 16 error reporting. 
Nov 26 15:52:55 cbibber kernel: Checking 'hlt' instruction... OK. 
Nov 26 15:52:55 cbibber kernel: Intel Pentium with F0 0F bug - workaround enabled. 
Nov 26 15:52:55 cbibber kernel: POSIX conformance testing by UNIFIX 
Nov 26 15:52:55 cbibber kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdac0 
Nov 26 15:52:55 cbibber kernel: PCI: Using configuration type 1 
Nov 26 15:52:55 cbibber kernel: PCI: Probing PCI hardware 
Nov 26 15:52:55 cbibber kernel: Linux NET4.0 for Linux 2.2 
Nov 26 15:52:55 cbibber kernel: Based upon Swansea University Computer Society NET3.039 
Nov 26 15:52:55 cbibber kernel: NET4: Unix domain sockets 1.0 for Linux NET4.0. 
Nov 26 15:52:55 cbibber kernel: NET4: Linux TCP/IP 1.0 for NET4.0 
Nov 26 15:52:55 cbibber kernel: IP Protocols: ICMP, UDP, TCP, IGMP 
Nov 26 15:52:55 cbibber kernel: TCP: Hash tables configured (ehash 65536 bhash 65536) 
Nov 26 15:52:55 cbibber kernel: IPVS: Connection hash table configured (size=4096, memory=32Kbytes) 
Nov 26 15:52:55 cbibber kernel: Linux IP multicast router 0.06 plus PIM-SM 
Nov 26 15:52:55 cbibber kernel: Initializing RT netlink socket 
Nov 26 15:52:55 cbibber kernel: Starting kswapd v 1.5  
Nov 26 15:52:55 cbibber kernel: Detected PS/2 Mouse Port. 
Nov 26 15:52:55 cbibber kernel: Serial driver version 4.27 with MANY_PORTS MULTIPORT SHARE_IRQ enabled 
Nov 26 15:52:55 cbibber kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A 
Nov 26 15:52:55 cbibber kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A 
Nov 26 15:52:55 cbibber kernel: pty: 256 Unix98 ptys configured 
Nov 26 15:52:55 cbibber kernel: Real Time Clock Driver v1.09 
Nov 26 15:52:55 cbibber kernel: RAM disk driver initialized:  16 RAM disks of 4096K size 
Nov 26 15:52:55 cbibber kernel: PIIX: IDE controller on PCI bus 00 dev 08 
Nov 26 15:52:55 cbibber kernel: PIIX: not 100%% native mode: will probe irqs later 
Nov 26 15:52:55 cbibber kernel: PIIX: neither IDE port enabled (BIOS) 
Nov 26 15:52:55 cbibber kernel: hda: IBM-DADA-25120, ATA DISK drive 
Nov 26 15:52:55 cbibber kernel: hdb: CD-44E, ATAPI CDROM drive 
Nov 26 15:52:55 cbibber kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14 
Nov 26 15:52:55 cbibber kernel: hda: IBM-DADA-25120, 4887MB w/460kB Cache, CHS=662/240/63 
Nov 26 15:52:55 cbibber kernel: Floppy drive(s): fd0 is 1.44M 
Nov 26 15:52:55 cbibber kernel: FDC 0 is a National Semiconductor PC87306 
Nov 26 15:52:55 cbibber kernel: md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12 
Nov 26 15:52:55 cbibber kernel: raid5: measuring checksumming speed 
Nov 26 15:52:55 cbibber kernel:    8regs     :   111.252 MB/sec 
Nov 26 15:52:55 cbibber kernel:    32regs    :    76.200 MB/sec 
Nov 26 15:52:55 cbibber kernel: using fastest function: 8regs (111.252 MB/sec) 
Nov 26 15:52:55 cbibber kernel: scsi : 0 hosts. 
Nov 26 15:52:55 cbibber kernel: scsi : detected total. 
Nov 26 15:52:55 cbibber kernel: md.c: sizeof(mdp_super_t) = 4096 
Nov 26 15:52:55 cbibber kernel: Partition check: 
Nov 26 15:52:55 cbibber kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 > 
Nov 26 15:52:55 cbibber kernel: autodetecting RAID arrays 
Nov 26 15:52:55 cbibber kernel: autorun ... 
Nov 26 15:52:55 cbibber kernel: ... autorun DONE. 
Nov 26 15:52:55 cbibber kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.13) 
Nov 26 15:52:55 cbibber kernel: VFS: Mounted root (ext2 filesystem) readonly. 
Nov 26 15:52:55 cbibber kernel: Freeing unused kernel memory: 72k freed 
Nov 26 15:52:55 cbibber kernel: Adding Swap: 75560k swap-space (priority -1) 
Nov 26 15:52:55 cbibber kernel: CSLIP: code copyright 1989 Regents of the University of California 
Nov 26 15:52:55 cbibber kernel: PPP: version 2.3.7 (demand dialling) 
Nov 26 15:52:55 cbibber kernel: PPP line discipline registered. 
Nov 26 15:52:55 cbibber atd: atd startup succeeded
Nov 26 15:52:56 cbibber crond: crond startup succeeded

BELOW ERRORS UPON PCMCIA STARTUP-------------------------------------------
Nov 26 15:52:57 cbibber pcmcia: Starting PCMCIA services:
Nov 26 15:52:57 cbibber pcmcia:  modules
Nov 26 15:52:57 cbibber pcmcia: /lib/modules/2.2.22-6.2.3/pcmcia/pcmcia_core.o: 
Nov 26 15:52:57 cbibber pcmcia: unresolved symbol request_mem_region
Nov 26 15:52:57 cbibber pcmcia: /lib/modules/2.2.22-6.2.3/pcmcia/pcmcia_core.o: unresolved symbol release_mem_region
Nov 26 15:52:57 cbibber pcmcia: /lib/modules/2.2.22-6.2.3/pcmcia/i82365.o: 
Nov 26 15:52:57 cbibber pcmcia: unresolved symbol pci_set_power_state
Nov 26 15:52:57 cbibber pcmcia: /lib/modules/2.2.22-6.2.3/pcmcia/i82365.o: unresolved symbol pci_enable_device
Nov 26 15:52:57 cbibber pcmcia: /lib/modules/2.2.22-6.2.3/pcmcia/i82365.o: unresolved symbol unregister_ss_entry
Nov 26 15:52:57 cbibber pcmcia: /lib/modules/2.2.22-6.2.3/pcmcia/i82365.o: unresolved symbol pci_irq_mask
Nov 26 15:52:57 cbibber pcmcia: /lib/modules/2.2.22-6.2.3/pcmcia/i82365.o: unresolved symbol register_ss_entry
Nov 26 15:52:57 cbibber pcmcia: /lib/modules/2.2.22-6.2.3/pcmcia/i82365.o: unresolved symbol CardServices
Nov 26 15:52:57 cbibber pcmcia: /lib/modules/2.2.22-6.2.3/pcmcia/ds.o: 
Nov 26 15:52:57 cbibber pcmcia:  cardmgr.
Nov 26 15:52:57 cbibber pcmcia: unresolved symbol proc_pccard
Nov 26 15:52:57 cbibber pcmcia: /lib/modules/2.2.22-6.2.3/pcmcia/ds.o: unresolved symbol CardServices
Nov 26 15:52:58 cbibber rc: Starting pcmcia succeeded
Nov 26 15:52:58 cbibber cardmgr[434]: starting, version is 3.1.24
Nov 26 15:52:58 cbibber cardmgr[434]: no pcmcia driver in /proc/devices
Nov 26 15:52:58 cbibber cardmgr[434]: exiting
Nov 26 15:52:58 cbibber inet: inetd startup succeeded
Nov 26 15:52:59 cbibber lpd: lpd startup succeeded
Nov 26 15:52:59 cbibber lpd[462]: restarted
Nov 26 15:52:59 cbibber keytable: Loading keymap: 
Nov 26 15:52:59 cbibber keytable: Loading /usr/lib/kbd/keymaps/i386/qwerty/us.kmap.gz
Nov 26 15:53:00 cbibber keytable: Loading system font: 
Nov 26 15:53:00 cbibber rc: Starting keytable succeeded
Nov 26 15:53:00 cbibber apmd[301]: Now using AC Power
Nov 26 15:53:02 cbibber sendmail: sendmail startup succeeded
Nov 26 15:53:02 cbibber gpm: gpm startup succeeded
Nov 26 15:53:04 cbibber xfs: Warning: The directory "/usr/share/fonts/default/TrueType" does not exist. 
Nov 26 15:53:04 cbibber xfs:          Entry deleted from font path. 
Nov 26 15:53:04 cbibber xfs: xfs startup succeeded
Nov 26 15:53:05 cbibber rhnsd: rhnsd startup succeeded
Nov 26 15:53:05 cbibber rhnsd[577]: Red Hat Network Services Daemon starting up.
Nov 26 15:53:05 cbibber linuxconf: Linuxconf final setup
Nov 26 15:53:08 cbibber rc: Starting linuxconf succeeded
Nov 26 15:53:09 cbibber kernel: parport0: PC-style at 0x3bc [SPP,PS2] 
Nov 26 15:53:09 cbibber kernel: parport0: no IEEE-1284 device present. 
Nov 26 15:53:09 cbibber kernel: imm: Version 2.03 (for Linux 2.0.0) 
Nov 26 15:53:09 cbibber kernel: imm: Found device at ID 6, Attempting to use PS/2 
Nov 26 15:53:09 cbibber kernel: imm: Communication established at 0x3bc with ID 6 using PS/2 
Nov 26 15:53:09 cbibber kernel: scsi0 : Iomega VPI2 (imm) interface 
Nov 26 15:53:09 cbibber kernel: scsi : 1 host. 
Nov 26 15:53:09 cbibber kernel:   Vendor: IOMEGA    Model: ZIP 100           Rev: P.04 
Nov 26 15:53:09 cbibber kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02 
Nov 26 15:53:09 cbibber kernel: Detected scsi removable disk sda at scsi0, channel 0, id 6, lun 0 
Nov 26 15:53:09 cbibber kernel: sda : READ CAPACITY failed. 
Nov 26 15:53:09 cbibber kernel: sda : status = 0, message = 00, host = 0, driver = 28  
Nov 26 15:53:09 cbibber kernel: sda : extended sense code = 2  
Nov 26 15:53:09 cbibber kernel: sda : block size assumed to be 512 bytes, disk size 1GB.   
Nov 26 15:53:09 cbibber kernel:  sda:scsidisk I/O error: dev 08:00, sector 0 
Nov 26 15:53:09 cbibber kernel:  unable to read partition table 
Nov 26 15:53:09 cbibber kernel: scsi1 : SCSI host adapter emulation for IDE ATAPI devices 
Nov 26 15:53:09 cbibber kernel: scsi : 2 hosts. 
Nov 26 15:53:09 cbibber kernel:   Vendor: TEAC      Model: CD-44E            Rev: 2.0C 
Nov 26 15:53:09 cbibber kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02 
Nov 26 15:53:09 cbibber kernel: Detected scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0 
Nov 26 15:53:09 cbibber kernel: sr0: scsi3-mmc drive: 4x/4x xa/form2 cdda tray 
Nov 26 15:53:09 cbibber kernel: Uniform CD-ROM driver Revision: 3.11 
Nov 26 15:53:21 cbibber PAM_pwdb[616]: (login) session opened for user root by LOGIN(uid=0)
Nov 26 15:54:41 cbibber ifup-ppp: pppd started for ppp0 on /dev/modem at 57600
Nov 26 15:54:41 cbibber pppd[672]: no device specified and stdin is not a tty
Nov 26 15:56:29 cbibber init: Switching to runlevel: 6
Nov 26 15:56:30 cbibber rhnsd[577]: Exiting
Nov 26 15:56:31 cbibber rhnsd: rhnsd shutdown succeeded
Nov 26 15:56:31 cbibber rc: Stopping keytable succeeded
Nov 26 15:56:32 cbibber Font Server[560]: terminating 
Nov 26 15:56:32 cbibber xfs: xfs shutdown succeeded
Nov 26 15:56:33 cbibber gpm: gpm shutdown succeeded
Nov 26 15:56:34 cbibber sendmail: sendmail shutdown succeeded
Nov 26 15:56:34 cbibber inet: inetd shutdown succeeded
Nov 26 15:56:35 cbibber atd: atd shutdown succeeded
Nov 26 15:56:36 cbibber crond: crond shutdown succeeded
Nov 26 15:56:37 cbibber lpd: lpd shutdown succeeded
Nov 26 15:56:38 cbibber identd: identd shutdown succeeded
Nov 26 15:56:38 cbibber rpc.statd[287]: Caught signal 15, un-registering and exiting.
Nov 26 15:56:38 cbibber nfslock: rpc.statd shutdown succeeded
Nov 26 15:56:39 cbibber dd: 1+0 records in
Nov 26 15:56:39 cbibber dd: 1+0 records out
Nov 26 15:56:39 cbibber random: Saving random seed succeeded
Nov 26 15:56:40 cbibber apmd[301]: Exiting
Nov 26 15:56:40 cbibber apmd: apmd shutdown succeeded
Nov 26 15:56:41 cbibber portmap: portmap shutdown succeeded
Nov 26 15:56:41 cbibber network: Shutting down interface ppp0 succeeded
Nov 26 15:56:42 cbibber pcmcia: Shutting down PCMCIA services:
Nov 26 15:56:42 cbibber pcmcia: .
Nov 26 15:56:42 cbibber rc: Stopping pcmcia succeeded
Nov 26 15:56:43 cbibber kernel: Kernel logging (proc) stopped.
Nov 26 15:56:43 cbibber kernel: Kernel log daemon terminating.
Nov 26 15:56:44 cbibber syslog: klogd shutdown succeeded
Nov 26 15:56:44 cbibber exiting on signal 15


RESTART USING OLD KERNEL 2.2.19-6.2.16 -------------------------
Nov 26 19:56:46 cbibber syslogd 1.3-3: restart.
Nov 26 19:56:46 cbibber syslog: syslogd startup succeeded
Nov 26 19:56:47 cbibber syslog: klogd startup succeeded
Nov 26 19:56:47 cbibber kernel: klogd 1.3-3, log source = /proc/kmsg started.
Nov 26 19:56:47 cbibber kernel: Inspecting /boot/System.map-2.2.19-6.2.16
Nov 26 19:56:17 cbibber rc.sysinit: Mounting proc filesystem succeeded 
Nov 26 19:56:17 cbibber sysctl: net.ipv4.ip_forward = 0 
Nov 26 19:56:17 cbibber sysctl: net.ipv4.conf.all.rp_filter = 1 
Nov 26 19:56:17 cbibber sysctl: net.ipv4.ip_always_defrag = 0 
Nov 26 19:56:17 cbibber sysctl: kernel.sysrq = 0 
Nov 26 19:56:17 cbibber rc.sysinit: Configuring kernel parameters succeeded 
Nov 26 19:56:17 cbibber date: Tue Nov 26 19:56:15 EST 2002 
Nov 26 19:56:17 cbibber rc.sysinit: Setting clock : Tue Nov 26 19:56:15 EST 2002 succeeded 
Nov 26 19:56:17 cbibber rc.sysinit: Loading default keymap succeeded 
Nov 26 19:56:17 cbibber rc.sysinit: Activating swap partitions succeeded 
Nov 26 19:56:17 cbibber rc.sysinit: Setting hostname cbibber succeeded 
Nov 26 19:56:17 cbibber fsck: /dev/hda3: clean, 58025/179872 files, 235679/359100 blocks 
Nov 26 19:56:17 cbibber rc.sysinit: Checking root filesystem succeeded 
Nov 26 19:56:17 cbibber rc.sysinit: Remounting root filesystem in read-write mode succeeded 
Nov 26 19:56:25 cbibber rc.sysinit: Finding module dependencies succeeded 
Nov 26 19:56:26 cbibber fsck: /: clean, 88845/212992 files, 344598/425250 blocks 
Nov 26 19:56:26 cbibber rc.sysinit: Checking filesystems succeeded 
Nov 26 19:56:27 cbibber rc.sysinit: Mounting local filesystems succeeded 
Nov 26 19:56:27 cbibber rc.sysinit: Turning on user and group quotas for local filesystems succeeded 
Nov 26 19:56:28 cbibber rc.sysinit: Enabling swap space succeeded 
Nov 26 19:56:28 cbibber init: Entering runlevel: 3 
Nov 26 19:56:41 cbibber kudzu:  succeeded 
Nov 26 19:56:42 cbibber sysctl: net.ipv4.ip_forward = 0 
Nov 26 19:56:42 cbibber sysctl: net.ipv4.conf.all.rp_filter = 1 
Nov 26 19:56:42 cbibber sysctl: net.ipv4.ip_always_defrag = 0 
Nov 26 19:56:42 cbibber sysctl: kernel.sysrq = 0 
Nov 26 19:56:42 cbibber network: Setting network parameters succeeded 
Nov 26 19:56:43 cbibber network: Bringing up interface lo succeeded 
Nov 26 19:56:44 cbibber portmap: portmap startup succeeded 
Nov 26 19:56:45 cbibber nfslock: rpc.statd startup succeeded 
Nov 26 19:56:45 cbibber rpc.statd[286]: Version 0.3.1 Starting 
Nov 26 19:56:45 cbibber apmd: apmd startup succeeded 
Nov 26 19:56:45 cbibber apmd[300]: Version 3.0final (APM BIOS 1.2, Linux driver 1.13) 
Nov 26 19:56:45 cbibber random: Initializing random number generator succeeded 
Nov 26 19:56:46 cbibber netfs: Mounting other filesystems succeeded 
Nov 26 19:56:48 cbibber identd: identd startup succeeded
Nov 26 19:56:48 cbibber kernel: Loaded 7334 symbols from /boot/System.map-2.2.19-6.2.16.
Nov 26 19:56:48 cbibber kernel: Symbols match kernel version 2.2.19.
Nov 26 19:56:48 cbibber kernel: Loaded 17 symbols from 2 modules.
Nov 26 19:56:48 cbibber kernel: Linux version 2.2.19-6.2.16 (root@porky.devel.redhat.com) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Wed Mar 13 13:34:14 EST 2002 
Nov 26 19:56:48 cbibber kernel: BIOS-provided physical RAM map: 
Nov 26 19:56:48 cbibber kernel:  BIOS-e820: 0009f000 @ 00000000 (usable) 
Nov 26 19:56:48 cbibber kernel:  BIOS-e820: 02700000 @ 00100000 (usable) 
Nov 26 19:56:48 cbibber kernel: Detected 119754 kHz processor. 
Nov 26 19:56:48 cbibber kernel: ide_setup: hdb=ide-scsi 
Nov 26 19:56:48 cbibber kernel: ide_setup: hdg=ide-scsi 
Nov 26 19:56:48 cbibber kernel: Console: colour VGA+ 80x25 
Nov 26 19:56:48 cbibber kernel: Calibrating delay loop... 238.38 BogoMIPS 
Nov 26 19:56:48 cbibber kernel: Memory: 38560k/40960k available (1076k kernel code, 416k reserved, 836k data, 72k init, 0k bigmem) 
Nov 26 19:56:48 cbibber kernel: Dentry hash table entries: 8192 (order 4, 64k) 
Nov 26 19:56:48 cbibber kernel: Buffer cache hash table entries: 65536 (order 6, 256k) 
Nov 26 19:56:48 cbibber kernel: Page cache hash table entries: 16384 (order 4, 64k) 
Nov 26 19:56:48 cbibber kernel: VFS: Diskquotas version dquot_6.4.0 initialized 
Nov 26 19:56:48 cbibber kernel: CPU: Intel Pentium 75 - 200 stepping 0c 
Nov 26 19:56:48 cbibber kernel: Checking 386/387 coupling... OK, FPU using exception 16 error reporting. 
Nov 26 19:56:48 cbibber kernel: Checking 'hlt' instruction... OK. 
Nov 26 19:56:48 cbibber kernel: Intel Pentium with F0 0F bug - workaround enabled. 
Nov 26 19:56:49 cbibber kernel: POSIX conformance testing by UNIFIX 
Nov 26 19:56:49 cbibber kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdac0 
Nov 26 19:56:49 cbibber kernel: PCI: Using configuration type 1 
Nov 26 19:56:49 cbibber kernel: PCI: Probing PCI hardware 
Nov 26 19:56:49 cbibber kernel: Linux NET4.0 for Linux 2.2 
Nov 26 19:56:49 cbibber kernel: Based upon Swansea University Computer Society NET3.039 
Nov 26 19:56:49 cbibber kernel: NET4: Unix domain sockets 1.0 for Linux NET4.0. 
Nov 26 19:56:49 cbibber kernel: NET4: Linux TCP/IP 1.0 for NET4.0 
Nov 26 19:56:49 cbibber kernel: IP Protocols: ICMP, UDP, TCP, IGMP 
Nov 26 19:56:49 cbibber kernel: TCP: Hash tables configured (ehash 65536 bhash 65536) 
Nov 26 19:56:49 cbibber kernel: IPVS: Connection hash table configured (size=4096, memory=32Kbytes) 
Nov 26 19:56:49 cbibber kernel: Linux IP multicast router 0.06 plus PIM-SM 
Nov 26 19:56:49 cbibber kernel: Initializing RT netlink socket 
Nov 26 19:56:49 cbibber kernel: Starting kswapd v 1.5  
Nov 26 19:56:49 cbibber kernel: Detected PS/2 Mouse Port. 
Nov 26 19:56:49 cbibber kernel: Serial driver version 4.27 with MANY_PORTS MULTIPORT SHARE_IRQ enabled 
Nov 26 19:56:49 cbibber kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A 
Nov 26 19:56:49 cbibber kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A 
Nov 26 19:56:49 cbibber kernel: pty: 256 Unix98 ptys configured 
Nov 26 19:56:49 cbibber kernel: Real Time Clock Driver v1.09 
Nov 26 19:56:49 cbibber kernel: RAM disk driver initialized:  16 RAM disks of 4096K size 
Nov 26 19:56:49 cbibber kernel: PIIX: IDE controller on PCI bus 00 dev 08 
Nov 26 19:56:49 cbibber kernel: PIIX: not 100%% native mode: will probe irqs later 
Nov 26 19:56:49 cbibber kernel: PIIX: neither IDE port enabled (BIOS) 
Nov 26 19:56:49 cbibber kernel: hda: IBM-DADA-25120, ATA DISK drive 
Nov 26 19:56:49 cbibber kernel: hdb: CD-44E, ATAPI CDROM drive 
Nov 26 19:56:49 cbibber kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14 
Nov 26 19:56:49 cbibber kernel: hda: IBM-DADA-25120, 4887MB w/460kB Cache, CHS=662/240/63 
Nov 26 19:56:49 cbibber kernel: Floppy drive(s): fd0 is 1.44M 
Nov 26 19:56:49 cbibber kernel: FDC 0 is a National Semiconductor PC87306 
Nov 26 19:56:49 cbibber kernel: md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12 
Nov 26 19:56:49 cbibber kernel: raid5: measuring checksumming speed 
Nov 26 19:56:49 cbibber kernel:    8regs     :   111.252 MB/sec 
Nov 26 19:56:49 cbibber kernel:    32regs    :    76.200 MB/sec 
Nov 26 19:56:49 cbibber kernel: using fastest function: 8regs (111.252 MB/sec) 
Nov 26 19:56:49 cbibber kernel: scsi : 0 hosts. 
Nov 26 19:56:49 cbibber kernel: scsi : detected total. 
Nov 26 19:56:49 cbibber kernel: md.c: sizeof(mdp_super_t) = 4096 
Nov 26 19:56:49 cbibber kernel: Partition check: 
Nov 26 19:56:49 cbibber kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 > 
Nov 26 19:56:49 cbibber kernel: autodetecting RAID arrays 
Nov 26 19:56:49 cbibber kernel: autorun ... 
Nov 26 19:56:49 cbibber kernel: ... autorun DONE. 
Nov 26 19:56:49 cbibber kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.13) 
Nov 26 19:56:49 cbibber kernel: VFS: Mounted root (ext2 filesystem) readonly. 
Nov 26 19:56:49 cbibber kernel: Freeing unused kernel memory: 72k freed 
Nov 26 19:56:49 cbibber kernel: Adding Swap: 75560k swap-space (priority -1) 
Nov 26 19:56:49 cbibber kernel: CSLIP: code copyright 1989 Regents of the University of California 
Nov 26 19:56:49 cbibber kernel: PPP: version 2.3.7 (demand dialling) 
Nov 26 19:56:49 cbibber kernel: PPP line discipline registered. 
Nov 26 19:56:49 cbibber atd: atd startup succeeded
Nov 26 19:56:50 cbibber crond: crond startup succeeded
Nov 26 19:56:50 cbibber pcmcia: Starting PCMCIA services:
Nov 26 19:56:50 cbibber pcmcia:  modules
Nov 26 19:56:50 cbibber kernel: Linux PCMCIA Card Services 3.1.24 
Nov 26 19:56:50 cbibber kernel:   kernel build: 2.2.19-6.2.16 #1 Wed Mar 13 13:34:14 EST 2002 
Nov 26 19:56:50 cbibber kernel:   options:  [pci] [cardbus] [apm] 
Nov 26 19:56:50 cbibber kernel: Intel PCIC probe:  
Nov 26 19:56:50 cbibber kernel:   Intel i82365sl B step rev 00 ISA-to-PCMCIA at port 0x3e0 ofs 0x00 
Nov 26 19:56:50 cbibber kernel:     host opts [0]: none 
Nov 26 19:56:50 cbibber kernel:     host opts [1]: none 
Nov 26 19:56:51 cbibber kernel:     ISA irqs (scanned) = 3,4,7,9,10,11,12,15 status change on irq 15 
Nov 26 19:56:51 cbibber pcmcia:  cardmgr.
Nov 26 19:56:51 cbibber rc: Starting pcmcia succeeded
Nov 26 19:56:51 cbibber cardmgr[433]: starting, version is 3.1.24
Nov 26 19:56:52 cbibber cardmgr[433]: watching 2 sockets
Nov 26 19:56:52 cbibber kernel: cs: IO port probe 0x0c00-0x0cff: excluding 0xcf8-0xcff 
Nov 26 19:56:52 cbibber kernel: cs: IO port probe 0x0800-0x08ff: clean. 
Nov 26 19:56:52 cbibber kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x22f 0x268-0x26f 0x330-0x337 0x388-0x38f 0x3b8-0x3e7 0x4d0-0x4d7 
Nov 26 19:56:52 cbibber kernel: cs: IO port probe 0x0a00-0x0aff: excluding 0xa20-0xa2f 0xa68-0xa6f 0xaf8-0xaff 
Nov 26 19:56:52 cbibber cardmgr[433]: initializing socket 0
Nov 26 19:56:52 cbibber kernel: cs: memory probe 0x0d0000-0x0dffff: clean. 
Nov 26 19:56:52 cbibber cardmgr[433]: socket 0: 3Com/Megahertz 3CXEM556 Ethernet/Modem
Nov 26 19:56:52 cbibber inet: inetd startup succeeded
Nov 26 19:56:52 cbibber cardmgr[433]: executing: 'modprobe 3c589_cs'
Nov 26 19:56:52 cbibber cardmgr[433]: executing: 'modprobe serial_cs'
Nov 26 19:56:52 cbibber kernel: eth0: 3Com 3c589, io 0x300, irq 3, hw_addr 00:00:86:1C:F8:27 
Nov 26 19:56:52 cbibber kernel:   8K FIFO split 5:3 Rx:Tx, auto xcvr 
Nov 26 19:56:52 cbibber kernel: tty02 at 0x03e8 (irq = 3) is a 16550A 
Nov 26 19:56:53 cbibber cardmgr[433]: executing: './network start eth0'
Nov 26 19:56:53 cbibber lpd: lpd startup succeeded
Nov 26 19:56:53 cbibber lpd[465]: restarted
Nov 26 19:56:53 cbibber keytable: Loading keymap: 
Nov 26 19:56:53 cbibber cardmgr[433]: + usage: ifup <device name>
Nov 26 19:56:53 cbibber cardmgr[433]: start cmd exited with status 1
Nov 26 19:56:53 cbibber cardmgr[433]: executing: './serial start ttyS2'
Nov 26 19:56:53 cbibber keytable: Loading /usr/lib/kbd/keymaps/i386/qwerty/us.kmap.gz
Nov 26 19:56:54 cbibber keytable: Loading system font: 
Nov 26 19:56:54 cbibber cardmgr[433]: initializing socket 1
Nov 26 19:56:54 cbibber cardmgr[433]: socket 1: EXP CD940 CD-ROM
Nov 26 19:56:54 cbibber rc: Starting keytable succeeded
Nov 26 19:56:54 cbibber cardmgr[433]: executing: 'modprobe ide_cs'
Nov 26 19:56:57 cbibber kernel: ide2: ports already in use, skipping probe 
Nov 26 19:56:57 cbibber kernel: hdg: LG CD-RW CED-8080B, ATAPI CDROM drive 
Nov 26 19:56:57 cbibber kernel: ide3 at 0x168-0x16f,0x36e on irq 9 
Nov 26 19:56:57 cbibber kernel: ide_cs: hdg: Vcc = 5.0, Vpp = 0.0 
Nov 26 19:56:57 cbibber cardmgr[433]: executing: './ide start hdg'
Nov 26 19:56:58 cbibber kernel: hdg: driver not present 
Nov 26 19:56:58 cbibber cardmgr[433]: + open() failed: Device not configured
Nov 26 19:56:59 cbibber sendmail: sendmail startup succeeded
Nov 26 19:57:00 cbibber gpm: gpm startup succeeded
Nov 26 19:57:00 cbibber apmd[300]: Now using AC Power
Nov 26 19:57:02 cbibber xfs: xfs startup succeeded
Nov 26 19:57:02 cbibber xfs: Warning: The directory "/usr/share/fonts/default/TrueType" does not exist. 
Nov 26 19:57:02 cbibber xfs:          Entry deleted from font path. 
Nov 26 19:57:03 cbibber rhnsd: rhnsd startup succeeded
Nov 26 19:57:03 cbibber rhnsd[612]: Red Hat Network Services Daemon starting up.
Nov 26 19:57:03 cbibber linuxconf: Linuxconf final setup
Nov 26 19:57:05 cbibber rc: Starting linuxconf succeeded
Nov 26 19:57:06 cbibber kernel: parport0: PC-style at 0x3bc [SPP,PS2] 
Nov 26 19:57:06 cbibber kernel: parport0: no IEEE-1284 device present. 
Nov 26 19:57:06 cbibber kernel: imm: Version 2.03 (for Linux 2.0.0) 
Nov 26 19:57:06 cbibber kernel: imm: Found device at ID 6, Attempting to use PS/2 
Nov 26 19:57:06 cbibber kernel: imm: Communication established at 0x3bc with ID 6 using PS/2 
Nov 26 19:57:06 cbibber kernel: scsi0 : Iomega VPI2 (imm) interface 
Nov 26 19:57:06 cbibber kernel: scsi : 1 host. 
Nov 26 19:57:06 cbibber kernel:   Vendor: IOMEGA    Model: ZIP 100           Rev: P.04 
Nov 26 19:57:06 cbibber kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02 
Nov 26 19:57:06 cbibber kernel: Detected scsi removable disk sda at scsi0, channel 0, id 6, lun 0 
Nov 26 19:57:06 cbibber kernel: sda : READ CAPACITY failed. 
Nov 26 19:57:06 cbibber kernel: sda : status = 0, message = 00, host = 0, driver = 28  
Nov 26 19:57:06 cbibber kernel: sda : extended sense code = 2  
Nov 26 19:57:06 cbibber kernel: sda : block size assumed to be 512 bytes, disk size 1GB.   
Nov 26 19:57:06 cbibber kernel:  sda:scsidisk I/O error: dev 08:00, sector 0 
Nov 26 19:57:06 cbibber kernel:  unable to read partition table 
Nov 26 19:57:07 cbibber kernel: scsi1 : SCSI host adapter emulation for IDE ATAPI devices 
Nov 26 19:57:07 cbibber kernel: scsi : 2 hosts. 
Nov 26 19:57:07 cbibber kernel:   Vendor: TEAC      Model: CD-44E            Rev: 2.0C 
Nov 26 19:57:07 cbibber kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02 
Nov 26 19:57:07 cbibber kernel: Detected scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0 
Nov 26 19:57:07 cbibber kernel:   Vendor: LG        Model: CD-RW CED-8080B   Rev: 1.06 
Nov 26 19:57:07 cbibber kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02 
Nov 26 19:57:07 cbibber kernel: Detected scsi CD-ROM sr1 at scsi1, channel 0, id 1, lun 0 
Nov 26 19:57:07 cbibber kernel: sr0: scsi3-mmc drive: 4x/4x xa/form2 cdda tray 
Nov 26 19:57:07 cbibber kernel: Uniform CD-ROM driver Revision: 3.11 
Nov 26 19:57:07 cbibber kernel: sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray 
Nov 26 19:57:19 cbibber PAM_pwdb[651]: (login) session opened for user root by LOGIN(uid=0)
Nov 26 19:57:51 cbibber kernel: lp0: using parport0 (polling). 
Nov 26 21:22:14 cbibber rhnsd[612]: Exiting
Nov 26 21:22:15 cbibber rhnsd: rhnsd shutdown succeeded
Nov 26 21:22:15 cbibber rc: Stopping keytable succeeded
Nov 26 21:22:15 cbibber Font Server[595]: terminating 
Nov 26 21:22:16 cbibber xfs: xfs shutdown succeeded
Nov 26 21:22:17 cbibber gpm: gpm shutdown succeeded
Nov 26 21:22:18 cbibber sendmail: sendmail shutdown succeeded
Nov 26 21:22:18 cbibber inet: inetd shutdown succeeded
Nov 26 21:22:19 cbibber atd: atd shutdown succeeded
Nov 26 21:22:20 cbibber crond: crond shutdown succeeded
Nov 26 21:22:21 cbibber lpd: lpd shutdown succeeded
Nov 26 21:22:21 cbibber identd: identd shutdown succeeded
Nov 26 21:22:22 cbibber nfslock: rpc.statd shutdown succeeded
Nov 26 21:22:23 cbibber dd: 1+0 records in
Nov 26 21:22:23 cbibber dd: 1+0 records out
Nov 26 21:22:23 cbibber random: Saving random seed succeeded
Nov 26 21:22:24 cbibber apmd[300]: Exiting
Nov 26 21:22:24 cbibber apmd: apmd shutdown succeeded
Nov 26 21:22:25 cbibber portmap: portmap shutdown succeeded
Nov 26 21:22:25 cbibber network: Shutting down interface ppp0 succeeded
Nov 26 21:22:26 cbibber pcmcia: Shutting down PCMCIA services:
Nov 26 21:22:26 cbibber cardmgr[433]: executing: './network check eth0'
Nov 26 21:22:26 cbibber pcmcia:  cardmgr
Nov 26 21:22:27 cbibber cardmgr[433]: executing: './serial check ttyS2'
Nov 26 21:22:27 cbibber cardmgr[433]: shutting down socket 0
Nov 26 21:22:27 cbibber cardmgr[433]: executing: './network stop eth0'
Nov 26 21:22:27 cbibber cardmgr[433]: + usage: ifdown <device name>
Nov 26 21:22:27 cbibber cardmgr[433]: stop cmd exited with status 1
Nov 26 21:22:27 cbibber cardmgr[433]: executing: './serial stop ttyS2'
Nov 26 21:22:27 cbibber kernel: tty02 unloaded 
Nov 26 21:22:27 cbibber cardmgr[433]: executing: 'modprobe -r 3c589_cs'
Nov 26 21:22:27 cbibber cardmgr[433]: executing: 'modprobe -r serial_cs'
Nov 26 21:22:28 cbibber cardmgr[433]: executing: './ide check hdg'
Nov 26 21:22:28 cbibber cardmgr[433]: shutting down socket 1
Nov 26 21:22:28 cbibber cardmgr[433]: executing: './ide stop hdg'
Nov 26 21:22:28 cbibber cardmgr[433]: executing: 'modprobe -r ide_cs'
Nov 26 21:22:29 cbibber cardmgr[433]: exiting
Nov 26 21:22:31 cbibber pcmcia:  modules
Nov 26 21:22:31 cbibber kernel: unloading PCMCIA Card Services 
Nov 26 21:22:31 cbibber pcmcia: .
Nov 26 21:22:31 cbibber rc: Stopping pcmcia succeeded
Nov 26 21:22:31 cbibber kernel: Kernel logging (proc) stopped.
Nov 26 21:22:31 cbibber kernel: Kernel log daemon terminating.
Nov 26 21:22:33 cbibber syslog: klogd shutdown succeeded
Nov 26 21:22:33 cbibber exiting on signal 15





Nov 26 21:27:08 cbibber syslogd 1.3-3: restart.
Nov 26 21:27:08 cbibber syslog: syslogd startup succeeded
Nov 26 21:27:09 cbibber syslog: klogd startup succeeded
Nov 26 21:27:09 cbibber kernel: klogd 1.3-3, log source = /proc/kmsg started.
Nov 26 21:27:09 cbibber kernel: Inspecting /boot/System.map-2.2.19-6.2.16
Nov 26 21:26:39 cbibber rc.sysinit: Mounting proc filesystem succeeded 
Nov 26 21:26:39 cbibber sysctl: net.ipv4.ip_forward = 0 
Nov 26 21:26:39 cbibber sysctl: net.ipv4.conf.all.rp_filter = 1 
Nov 26 21:26:39 cbibber sysctl: net.ipv4.ip_always_defrag = 0 
Nov 26 21:26:39 cbibber sysctl: kernel.sysrq = 0 
Nov 26 21:26:39 cbibber rc.sysinit: Configuring kernel parameters succeeded 
Nov 26 21:26:39 cbibber date: Tue Nov 26 21:26:37 EST 2002 
Nov 26 21:26:39 cbibber rc.sysinit: Setting clock : Tue Nov 26 21:26:37 EST 2002 succeeded 
Nov 26 21:26:39 cbibber rc.sysinit: Loading default keymap succeeded 
Nov 26 21:26:39 cbibber rc.sysinit: Activating swap partitions succeeded 
Nov 26 21:26:39 cbibber rc.sysinit: Setting hostname cbibber succeeded 
Nov 26 21:26:39 cbibber fsck: /dev/hda3: clean, 58025/179872 files, 235688/359100 blocks 
Nov 26 21:26:39 cbibber rc.sysinit: Checking root filesystem succeeded 
Nov 26 21:26:39 cbibber rc.sysinit: Remounting root filesystem in read-write mode succeeded 
Nov 26 21:26:48 cbibber rc.sysinit: Finding module dependencies succeeded 
Nov 26 21:26:48 cbibber fsck: /: clean, 88845/212992 files, 344598/425250 blocks 
Nov 26 21:26:48 cbibber rc.sysinit: Checking filesystems succeeded 
Nov 26 21:26:49 cbibber rc.sysinit: Mounting local filesystems succeeded 
Nov 26 21:26:49 cbibber rc.sysinit: Turning on user and group quotas for local filesystems succeeded 
Nov 26 21:26:50 cbibber rc.sysinit: Enabling swap space succeeded 
Nov 26 21:26:50 cbibber init: Entering runlevel: 3 
Nov 26 21:27:03 cbibber kudzu:  succeeded 
Nov 26 21:27:04 cbibber sysctl: net.ipv4.ip_forward = 0 
Nov 26 21:27:04 cbibber sysctl: net.ipv4.conf.all.rp_filter = 1 
Nov 26 21:27:04 cbibber sysctl: net.ipv4.ip_always_defrag = 0 
Nov 26 21:27:04 cbibber sysctl: kernel.sysrq = 0 
Nov 26 21:27:04 cbibber network: Setting network parameters succeeded 
Nov 26 21:27:05 cbibber network: Bringing up interface lo succeeded 
Nov 26 21:27:06 cbibber portmap: portmap startup succeeded 
Nov 26 21:27:07 cbibber nfslock: rpc.statd startup succeeded 
Nov 26 21:27:07 cbibber rpc.statd[286]: Version 0.3.1 Starting 
Nov 26 21:27:07 cbibber apmd: apmd startup succeeded 
Nov 26 21:27:07 cbibber apmd[300]: Version 3.0final (APM BIOS 1.2, Linux driver 1.13) 
Nov 26 21:27:07 cbibber random: Initializing random number generator succeeded 
Nov 26 21:27:08 cbibber netfs: Mounting other filesystems succeeded 
Nov 26 21:27:10 cbibber identd: identd startup succeeded
Nov 26 21:27:11 cbibber kernel: Loaded 7334 symbols from /boot/System.map-2.2.19-6.2.16.
Nov 26 21:27:11 cbibber kernel: Symbols match kernel version 2.2.19.
Nov 26 21:27:11 cbibber kernel: Loaded 17 symbols from 2 modules.
Nov 26 21:27:11 cbibber kernel: Linux version 2.2.19-6.2.16 (root@porky.devel.redhat.com) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Wed Mar 13 13:34:14 EST 2002 
Nov 26 21:27:11 cbibber kernel: BIOS-provided physical RAM map: 
Nov 26 21:27:11 cbibber kernel:  BIOS-e820: 0009f000 @ 00000000 (usable) 
Nov 26 21:27:11 cbibber kernel:  BIOS-e820: 02700000 @ 00100000 (usable) 
Nov 26 21:27:11 cbibber kernel: Detected 119754 kHz processor. 
Nov 26 21:27:11 cbibber kernel: ide_setup: hdb=ide-scsi 
Nov 26 21:27:11 cbibber kernel: ide_setup: hdg=ide-scsi 
Nov 26 21:27:11 cbibber kernel: Console: colour VGA+ 80x25 
Nov 26 21:27:11 cbibber kernel: Calibrating delay loop... 238.38 BogoMIPS 
Nov 26 21:27:11 cbibber kernel: Memory: 38560k/40960k available (1076k kernel code, 416k reserved, 836k data, 72k init, 0k bigmem) 
Nov 26 21:27:11 cbibber kernel: Dentry hash table entries: 8192 (order 4, 64k) 
Nov 26 21:27:11 cbibber kernel: Buffer cache hash table entries: 65536 (order 6, 256k) 
Nov 26 21:27:11 cbibber kernel: Page cache hash table entries: 16384 (order 4, 64k) 
Nov 26 21:27:11 cbibber kernel: VFS: Diskquotas version dquot_6.4.0 initialized 
Nov 26 21:27:11 cbibber kernel: CPU: Intel Pentium 75 - 200 stepping 0c 
Nov 26 21:27:11 cbibber kernel: Checking 386/387 coupling... OK, FPU using exception 16 error reporting. 
Nov 26 21:27:11 cbibber kernel: Checking 'hlt' instruction... OK. 
Nov 26 21:27:11 cbibber kernel: Intel Pentium with F0 0F bug - workaround enabled. 
Nov 26 21:27:11 cbibber kernel: POSIX conformance testing by UNIFIX 
Nov 26 21:27:11 cbibber kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdac0 
Nov 26 21:27:11 cbibber kernel: PCI: Using configuration type 1 
Nov 26 21:27:11 cbibber kernel: PCI: Probing PCI hardware 
Nov 26 21:27:11 cbibber kernel: Linux NET4.0 for Linux 2.2 
Nov 26 21:27:11 cbibber kernel: Based upon Swansea University Computer Society NET3.039 
Nov 26 21:27:11 cbibber kernel: NET4: Unix domain sockets 1.0 for Linux NET4.0. 
Nov 26 21:27:11 cbibber kernel: NET4: Linux TCP/IP 1.0 for NET4.0 
Nov 26 21:27:11 cbibber kernel: IP Protocols: ICMP, UDP, TCP, IGMP 
Nov 26 21:27:11 cbibber kernel: TCP: Hash tables configured (ehash 65536 bhash 65536) 
Nov 26 21:27:11 cbibber kernel: IPVS: Connection hash table configured (size=4096, memory=32Kbytes) 
Nov 26 21:27:11 cbibber kernel: Linux IP multicast router 0.06 plus PIM-SM 
Nov 26 21:27:11 cbibber kernel: Initializing RT netlink socket 
Nov 26 21:27:11 cbibber kernel: Starting kswapd v 1.5  
Nov 26 21:27:11 cbibber kernel: Detected PS/2 Mouse Port. 
Nov 26 21:27:11 cbibber kernel: Serial driver version 4.27 with MANY_PORTS MULTIPORT SHARE_IRQ enabled 
Nov 26 21:27:11 cbibber kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A 
Nov 26 21:27:11 cbibber kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A 
Nov 26 21:27:11 cbibber kernel: pty: 256 Unix98 ptys configured 
Nov 26 21:27:11 cbibber kernel: Real Time Clock Driver v1.09 
Nov 26 21:27:11 cbibber kernel: RAM disk driver initialized:  16 RAM disks of 4096K size 
Nov 26 21:27:11 cbibber kernel: PIIX: IDE controller on PCI bus 00 dev 08 
Nov 26 21:27:11 cbibber kernel: PIIX: not 100%% native mode: will probe irqs later 
Nov 26 21:27:11 cbibber kernel: PIIX: neither IDE port enabled (BIOS) 
Nov 26 21:27:11 cbibber kernel: hda: IBM-DADA-25120, ATA DISK drive 
Nov 26 21:27:11 cbibber kernel: hdb: CD-44E, ATAPI CDROM drive 
Nov 26 21:27:11 cbibber kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14 
Nov 26 21:27:11 cbibber kernel: hda: IBM-DADA-25120, 4887MB w/460kB Cache, CHS=662/240/63 
Nov 26 21:27:11 cbibber kernel: Floppy drive(s): fd0 is 1.44M 
Nov 26 21:27:11 cbibber kernel: FDC 0 is a National Semiconductor PC87306 
Nov 26 21:27:11 cbibber kernel: md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12 
Nov 26 21:27:11 cbibber kernel: raid5: measuring checksumming speed 
Nov 26 21:27:11 cbibber kernel:    8regs     :   111.252 MB/sec 
Nov 26 21:27:11 cbibber kernel:    32regs    :    76.200 MB/sec 
Nov 26 21:27:11 cbibber kernel: using fastest function: 8regs (111.252 MB/sec) 
Nov 26 21:27:11 cbibber kernel: scsi : 0 hosts. 
Nov 26 21:27:11 cbibber kernel: scsi : detected total. 
Nov 26 21:27:11 cbibber kernel: md.c: sizeof(mdp_super_t) = 4096 
Nov 26 21:27:11 cbibber kernel: Partition check: 
Nov 26 21:27:11 cbibber kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 > 
Nov 26 21:27:11 cbibber kernel: autodetecting RAID arrays 
Nov 26 21:27:11 cbibber kernel: autorun ... 
Nov 26 21:27:11 cbibber kernel: ... autorun DONE. 
Nov 26 21:27:11 cbibber kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.13) 
Nov 26 21:27:11 cbibber kernel: VFS: Mounted root (ext2 filesystem) readonly. 
Nov 26 21:27:11 cbibber kernel: Freeing unused kernel memory: 72k freed 
Nov 26 21:27:11 cbibber kernel: Adding Swap: 75560k swap-space (priority -1) 
Nov 26 21:27:11 cbibber kernel: CSLIP: code copyright 1989 Regents of the University of California 
Nov 26 21:27:11 cbibber kernel: PPP: version 2.3.7 (demand dialling) 
Nov 26 21:27:11 cbibber kernel: PPP line discipline registered. 
Nov 26 21:27:11 cbibber atd: atd startup succeeded
Nov 26 21:27:12 cbibber crond: crond startup succeeded
Nov 26 21:27:12 cbibber pcmcia: Starting PCMCIA services:
Nov 26 21:27:13 cbibber pcmcia:  modules
Nov 26 21:27:13 cbibber kernel: Linux PCMCIA Card Services 3.1.24 
Nov 26 21:27:13 cbibber kernel:   kernel build: 2.2.19-6.2.16 #1 Wed Mar 13 13:34:14 EST 2002 
Nov 26 21:27:13 cbibber kernel:   options:  [pci] [cardbus] [apm] 
Nov 26 21:27:13 cbibber kernel: Intel PCIC probe:  
Nov 26 21:27:13 cbibber kernel:   Intel i82365sl B step rev 00 ISA-to-PCMCIA at port 0x3e0 ofs 0x00 
Nov 26 21:27:13 cbibber kernel:     host opts [0]: none 
Nov 26 21:27:13 cbibber kernel:     host opts [1]: none 
Nov 26 21:27:13 cbibber kernel:     ISA irqs (scanned) = 3,4,7,9,10,11,12,15 status change on irq 15 
Nov 26 21:27:13 cbibber pcmcia:  cardmgr.
Nov 26 21:27:13 cbibber rc: Starting pcmcia succeeded
Nov 26 21:27:13 cbibber cardmgr[433]: starting, version is 3.1.24
Nov 26 21:27:14 cbibber cardmgr[433]: watching 2 sockets
Nov 26 21:27:14 cbibber kernel: cs: IO port probe 0x0c00-0x0cff: excluding 0xcf8-0xcff 
Nov 26 21:27:14 cbibber kernel: cs: IO port probe 0x0800-0x08ff: clean. 
Nov 26 21:27:14 cbibber kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x22f 0x268-0x26f 0x330-0x337 0x388-0x38f 0x3b8-0x3e7 0x4d0-0x4d7 
Nov 26 21:27:14 cbibber kernel: cs: IO port probe 0x0a00-0x0aff: excluding 0xa20-0xa2f 0xa68-0xa6f 0xaf8-0xaff 
Nov 26 21:27:14 cbibber cardmgr[433]: initializing socket 0
Nov 26 21:27:14 cbibber kernel: cs: memory probe 0x0d0000-0x0dffff: clean. 
Nov 26 21:27:14 cbibber cardmgr[433]: socket 0: 3Com/Megahertz 3CXEM556 Ethernet/Modem
Nov 26 21:27:14 cbibber cardmgr[433]: executing: 'modprobe 3c589_cs'
Nov 26 21:27:14 cbibber inet: inetd startup succeeded
Nov 26 21:27:14 cbibber cardmgr[433]: executing: 'modprobe serial_cs'
Nov 26 21:27:15 cbibber kernel: eth0: 3Com 3c589, io 0x300, irq 3, hw_addr 00:00:86:1C:F8:27 
Nov 26 21:27:15 cbibber kernel:   8K FIFO split 5:3 Rx:Tx, auto xcvr 
Nov 26 21:27:15 cbibber kernel: tty02 at 0x03e8 (irq = 3) is a 16550A 
Nov 26 21:27:15 cbibber cardmgr[433]: executing: './network start eth0'
Nov 26 21:27:15 cbibber lpd: lpd startup succeeded
Nov 26 21:27:15 cbibber lpd[471]: restarted
Nov 26 21:27:15 cbibber cardmgr[433]: + usage: ifup <device name>
Nov 26 21:27:15 cbibber cardmgr[433]: start cmd exited with status 1
Nov 26 21:27:15 cbibber cardmgr[433]: executing: './serial start ttyS2'
Nov 26 21:27:15 cbibber keytable: Loading keymap: 
Nov 26 21:27:16 cbibber keytable: Loading /usr/lib/kbd/keymaps/i386/qwerty/us.kmap.gz
Nov 26 21:27:16 cbibber cardmgr[433]: initializing socket 1
Nov 26 21:27:16 cbibber cardmgr[433]: socket 1: EXP CD940 CD-ROM
Nov 26 21:27:16 cbibber keytable: Loading system font: 
Nov 26 21:27:16 cbibber cardmgr[433]: executing: 'modprobe ide_cs'
Nov 26 21:27:16 cbibber rc: Starting keytable succeeded
Nov 26 21:27:19 cbibber kernel: ide2: ports already in use, skipping probe 
Nov 26 21:27:19 cbibber kernel: hdg: LG CD-RW CED-8080B, ATAPI CDROM drive 
Nov 26 21:27:19 cbibber kernel: ide3 at 0x168-0x16f,0x36e on irq 9 
Nov 26 21:27:19 cbibber kernel: ide_cs: hdg: Vcc = 5.0, Vpp = 0.0 
Nov 26 21:27:19 cbibber cardmgr[433]: executing: './ide start hdg'
Nov 26 21:27:20 cbibber kernel: hdg: driver not present 
Nov 26 21:27:20 cbibber cardmgr[433]: + open() failed: Device not configured
Nov 26 21:27:21 cbibber sendmail: sendmail startup succeeded
Nov 26 21:27:22 cbibber gpm: gpm startup succeeded
Nov 26 21:27:24 cbibber xfs: Warning: The directory "/usr/share/fonts/default/TrueType" does not exist. 
Nov 26 21:27:24 cbibber xfs:          Entry deleted from font path. 
Nov 26 21:27:24 cbibber xfs: xfs startup succeeded
Nov 26 21:27:25 cbibber rhnsd: rhnsd startup succeeded
Nov 26 21:27:25 cbibber rhnsd[612]: Red Hat Network Services Daemon starting up.
Nov 26 21:27:26 cbibber linuxconf: Linuxconf final setup
Nov 26 21:27:28 cbibber rc: Starting linuxconf succeeded
Nov 26 21:27:28 cbibber kernel: parport0: PC-style at 0x3bc [SPP,PS2] 
Nov 26 21:27:29 cbibber kernel: parport0: no IEEE-1284 device present. 
Nov 26 21:27:29 cbibber kernel: imm: Version 2.03 (for Linux 2.0.0) 
Nov 26 21:27:29 cbibber kernel: imm: Found device at ID 6, Attempting to use PS/2 
Nov 26 21:27:29 cbibber kernel: imm: Communication established at 0x3bc with ID 6 using PS/2 
Nov 26 21:27:29 cbibber kernel: scsi0 : Iomega VPI2 (imm) interface 
Nov 26 21:27:29 cbibber kernel: scsi : 1 host. 
Nov 26 21:27:29 cbibber kernel:   Vendor: IOMEGA    Model: ZIP 100           Rev: P.04 
Nov 26 21:27:29 cbibber kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02 
Nov 26 21:27:29 cbibber kernel: Detected scsi removable disk sda at scsi0, channel 0, id 6, lun 0 
Nov 26 21:27:29 cbibber kernel: sda : READ CAPACITY failed. 
Nov 26 21:27:29 cbibber kernel: sda : status = 0, message = 00, host = 0, driver = 28  
Nov 26 21:27:29 cbibber kernel: sda : extended sense code = 2  
Nov 26 21:27:29 cbibber kernel: sda : block size assumed to be 512 bytes, disk size 1GB.   
Nov 26 21:27:29 cbibber kernel:  sda:scsidisk I/O error: dev 08:00, sector 0 
Nov 26 21:27:29 cbibber kernel:  unable to read partition table 
Nov 26 21:27:29 cbibber kernel: scsi1 : SCSI host adapter emulation for IDE ATAPI devices 
Nov 26 21:27:29 cbibber kernel: scsi : 2 hosts. 
Nov 26 21:27:29 cbibber kernel:   Vendor: TEAC      Model: CD-44E            Rev: 2.0C 
Nov 26 21:27:29 cbibber kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02 
Nov 26 21:27:29 cbibber kernel: Detected scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0 
Nov 26 21:27:29 cbibber kernel:   Vendor: LG        Model: CD-RW CED-8080B   Rev: 1.06 
Nov 26 21:27:29 cbibber kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02 
Nov 26 21:27:29 cbibber kernel: Detected scsi CD-ROM sr1 at scsi1, channel 0, id 1, lun 0 
Nov 26 21:27:29 cbibber kernel: sr0: scsi3-mmc drive: 4x/4x xa/form2 cdda tray 
Nov 26 21:27:29 cbibber kernel: Uniform CD-ROM driver Revision: 3.11 
Nov 26 21:27:29 cbibber kernel: sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray 
Nov 26 21:27:36 cbibber PAM_pwdb[651]: (login) session opened for user root by LOGIN(uid=0)
Nov 26 21:28:00 cbibber apmd[300]: Now using AC Power
Nov 26 21:56:10 cbibber ifup-ppp: pppd started for ppp0 on /dev/modem at 57600
Nov 26 21:56:10 cbibber kernel: registered device ppp0 
Nov 26 21:56:10 cbibber pppd[710]: pppd 2.3.11 started by root, uid 0
Nov 26 21:56:11 cbibber chat[720]: abort on (BUSY)
Nov 26 21:56:11 cbibber chat[720]: abort on (ERROR)
Nov 26 21:56:11 cbibber chat[720]: abort on (NO CARRIER)
Nov 26 21:56:11 cbibber chat[720]: abort on (NO DIALTONE)
Nov 26 21:56:11 cbibber chat[720]: abort on (Invalid Login)
Nov 26 21:56:11 cbibber chat[720]: abort on (Login incorrect)
Nov 26 21:56:11 cbibber chat[720]: send (ATZ^M)
Nov 26 21:56:11 cbibber chat[720]: expect (OK)
Nov 26 21:56:11 cbibber chat[720]: ATZ^M^M
Nov 26 21:56:11 cbibber chat[720]: OK
Nov 26 21:56:11 cbibber chat[720]:  -- got it 
Nov 26 21:56:11 cbibber chat[720]: send (ATDT407-648-1375^M)
Nov 26 21:56:12 cbibber chat[720]: expect (CONNECT)
Nov 26 21:56:12 cbibber chat[720]: ^M
Nov 26 21:56:38 cbibber chat[720]: ATDT407-648-1375^M^M
Nov 26 21:56:38 cbibber chat[720]: CONNECT
Nov 26 21:56:38 cbibber chat[720]:  -- got it 
Nov 26 21:56:38 cbibber chat[720]: send (^M)
Nov 26 21:56:38 cbibber chat[720]: expect (Username:)
Nov 26 21:56:38 cbibber chat[720]:  42666/ARQ/V90/LAPM/V42BIS^M
Nov 26 21:56:38 cbibber chat[720]: ^M
Nov 26 21:56:38 cbibber chat[720]: UQKT2^M
Nov 26 21:56:38 cbibber chat[720]: ^M
Nov 26 21:56:38 cbibber chat[720]: Username:
Nov 26 21:56:38 cbibber chat[720]:  -- got it 
Nov 26 21:56:38 cbibber chat[720]: send (sfb42603@pop.net^M)
Nov 26 21:56:39 cbibber chat[720]: expect (ord:)
Nov 26 21:56:39 cbibber chat[720]:  ^M
Nov 26 21:56:39 cbibber chat[720]: Username: sfb42603@pop.net^M
Nov 26 21:56:39 cbibber chat[720]: Password:
Nov 26 21:56:39 cbibber chat[720]:  -- got it 
Nov 26 21:56:39 cbibber chat[720]: send (Goodn5.f^M)
Nov 26 21:56:39 cbibber chat[720]: timeout set to 5 seconds
Nov 26 21:56:39 cbibber chat[720]: expect (~)
Nov 26 21:56:39 cbibber chat[720]:  ^M
Nov 26 21:56:39 cbibber chat[720]: Entering PPP mode.^M
Nov 26 21:56:39 cbibber chat[720]: Async interface address is unnumbered (Loopback0)^M
Nov 26 21:56:39 cbibber chat[720]: Your IP address is 65.137.72.212. MTU is 1500 bytes^M
Nov 26 21:56:39 cbibber chat[720]: ^M
Nov 26 21:56:40 cbibber PAM_pwdb[652]: (login) session opened for user guidescope by LOGIN(uid=0)
Nov 26 21:56:43 cbibber chat[720]: ~
Nov 26 21:56:43 cbibber chat[720]:  -- got it 
Nov 26 21:56:43 cbibber chat[720]: send (^M)
Nov 26 21:56:43 cbibber pppd[710]: Serial connection established.
Nov 26 21:56:43 cbibber pppd[710]: Using interface ppp0
Nov 26 21:56:43 cbibber pppd[710]: Connect: ppp0 <--> /dev/modem
Nov 26 21:56:46 cbibber kernel: PPP BSD Compression module registered 
Nov 26 21:56:46 cbibber kernel: PPP Deflate Compression module registered 
Nov 26 21:56:46 cbibber pppd[710]: local  IP address 65.137.72.212
Nov 26 21:56:46 cbibber pppd[710]: remote IP address 63.152.8.56
Nov 26 21:56:46 cbibber pppd[710]: primary   DNS address 205.171.3.65
Nov 26 21:56:46 cbibber pppd[710]: secondary DNS address 205.171.13.251
Nov 26 21:56:59 cbibber PAM_pwdb[653]: (login) session opened for user root by LOGIN(uid=0)
Nov 26 21:57:21 cbibber gnome-name-server[842]: starting
Nov 26 21:57:22 cbibber gnome-name-server[842]: name server starting
Nov 26 21:57:54 cbibber PAM_pwdb[653]: (login) session closed for user root
Nov 26 21:58:11 cbibber PAM_pwdb[875]: authentication failure; (uid=0) -> root for login service
Nov 26 21:58:12 cbibber login[875]: FAILED LOGIN 1 FROM (null) FOR root, Authentication failure
Nov 26 21:58:18 cbibber PAM_pwdb[875]: (login) session opened for user root by (uid=0)


--------------8509053D8C4EAF3C7E28468D--

