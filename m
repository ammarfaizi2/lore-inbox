Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129319AbQK0WRc>; Mon, 27 Nov 2000 17:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129408AbQK0WRW>; Mon, 27 Nov 2000 17:17:22 -0500
Received: from natmail2.webmailer.de ([192.67.198.65]:35269 "EHLO
        post.webmailer.de") by vger.kernel.org with ESMTP
        id <S129319AbQK0WRP>; Mon, 27 Nov 2000 17:17:15 -0500
Message-ID: <3A22D519.5BFF146D@pro-linux.de>
Date: Mon, 27 Nov 2000 22:41:45 +0100
From: Kristian <kristian@pro-linux.de>
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, rsousa@grad.physics.sunysb.edu
Subject: awe64-bug in 2.4.0-test11
Content-Type: multipart/mixed;
 boundary="------------CBAAF9ACE136A27954BD8525"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dies ist eine mehrteilige Nachricht im MIME-Format.
--------------CBAAF9ACE136A27954BD8525
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi!

Here're some notes about my problem:

� problems with awe64 soundcard
� maybe it has something to do with changes in sound.c in
  vers. 2.4.0-test11?

a general description of the problem:

� i'm getting some kernel-oopses while loading awe_wave.o .
� This soundcard (Creative Soundblaster AWE64) is detected
  correctly at the very beginning using the "isapnp
  auto-detection" feature of the kernel.
� I tried to change irq as well as a lot of io addresses but
  with no effort.
� This problem occured NOT with 2.4.0-test10 or other
  versions before.
� I hope the attached syslog will help you.

� If you need some more special (maybe hardware-specific)
  notes, let me know.
� I use RedHat 6.2.

regards, Kristian (sorry for my bad haste english)

   ~~ ~~ ~~ liebevolle elektronische Briefaspekte ~~ ~  ~
 ~
 ~ Korseby Online (http://www.korseby.net)
~  tom musics     (http://www.tomlab.de)
 ~
    ~ ~ ~~ ~ ~ reach me (kristian@pro-linux.de) ~~ ~ ~  ~   ~
--------------CBAAF9ACE136A27954BD8525
Content-Type: text/plain; charset=us-ascii;
 name="kernel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel"

Nov 27 13:59:28 adlib syslogd 1.3-3: restart.
Nov 27 13:59:28 adlib syslog: syslogd startup succeeded
Nov 27 13:59:29 adlib kernel: klogd 1.3-3, log source = /proc/kmsg started.
Nov 27 13:59:29 adlib kernel: Inspecting /boot/System.map-2.4.0-test11
Nov 27 13:59:29 adlib syslog: klogd startup succeeded
Nov 27 13:59:29 adlib kernel: Loaded 14318 symbols from /boot/System.map-2.4.0-test11.
Nov 27 13:59:29 adlib kernel: Symbols match kernel version 2.4.0.
Nov 27 13:59:29 adlib kernel: Loaded 92 symbols from 3 modules.
Nov 27 13:59:29 adlib kernel: Linux version 2.4.0-test11 (root@adlib) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Mon Nov 27 13:35:16 CET 2000 
Nov 27 13:59:29 adlib kernel: BIOS-provided physical RAM map: 
Nov 27 13:59:29 adlib kernel:  BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable) 
Nov 27 13:59:29 adlib kernel:  BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved) 
Nov 27 13:59:29 adlib kernel:  BIOS-e820: 0000000000020000 @ 00000000000e0000 (reserved) 
Nov 27 13:59:29 adlib kernel:  BIOS-e820: 000000000bf00000 @ 0000000000100000 (usable) 
Nov 27 13:59:29 adlib kernel:  BIOS-e820: 0000000000040000 @ 00000000fffc0000 (reserved) 
Nov 27 13:59:29 adlib kernel: On node 0 totalpages: 49152 
Nov 27 13:59:29 adlib kernel: zone(0): 4096 pages. 
Nov 27 13:59:29 adlib kernel: zone(1): 45056 pages. 
Nov 27 13:59:29 adlib kernel: zone(2): 0 pages. 
Nov 27 13:59:29 adlib kernel: Kernel command line: BOOT_IMAGE=devel ro root=305 hdb=ide-scsi 
Nov 27 13:59:29 adlib kernel: ide_setup: hdb=ide-scsi 
Nov 27 13:59:29 adlib kernel: Initializing CPU#0 
Nov 27 13:59:29 adlib kernel: Detected 349.183 MHz processor. 
Nov 27 13:59:29 adlib kernel: Console: colour VGA+ 80x25 
Nov 27 13:59:29 adlib kernel: Calibrating delay loop... 696.32 BogoMIPS 
Nov 27 13:59:29 adlib kernel: Memory: 191084k/196608k available (1373k kernel code, 5136k reserved, 75k data, 196k init, 0k highmem) 
Nov 27 13:59:29 adlib kernel: Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes) 
Nov 27 13:59:29 adlib kernel: Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes) 
Nov 27 13:59:29 adlib kernel: Page-cache hash table entries: 65536 (order: 6, 262144 bytes) 
Nov 27 13:59:29 adlib kernel: Inode-cache hash table entries: 16384 (order: 5, 131072 bytes) 
Nov 27 13:59:29 adlib kernel: VFS: Diskquotas version dquot_6.4.0 initialized 
Nov 27 13:59:29 adlib kernel: CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0 
Nov 27 13:59:29 adlib kernel: CPU: L2 cache: 512K 
Nov 27 13:59:29 adlib kernel: Intel machine check architecture supported. 
Nov 27 13:59:29 adlib kernel: Intel machine check reporting enabled on CPU#0. 
Nov 27 13:59:29 adlib kernel: CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000 
Nov 27 13:59:29 adlib kernel: CPU: After generic, caps: 0183f9ff 00000000 00000000 00000000 
Nov 27 13:59:29 adlib kernel: CPU: Common caps: 0183f9ff 00000000 00000000 00000000 
Nov 27 13:59:29 adlib kernel: CPU: Intel Pentium II (Deschutes) stepping 02 
Nov 27 13:59:29 adlib kernel: Checking 'hlt' instruction... OK. 
Nov 27 13:59:29 adlib kernel: POSIX conformance testing by UNIFIX 
Nov 27 13:59:29 adlib kernel: mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au) 
Nov 27 13:59:29 adlib kernel: mtrr: detected mtrr type: Intel 
Nov 27 13:59:29 adlib kernel: PCI: PCI BIOS revision 2.10 entry at 0xed728, last bus=1 
Nov 27 13:59:29 adlib kernel: PCI: Using configuration type 1 
Nov 27 13:59:29 adlib kernel: PCI: Probing PCI hardware 
Nov 27 13:59:29 adlib kernel: Unknown bridge resource 0: assuming transparent 
Nov 27 13:59:29 adlib kernel: PCI: Using IRQ router PIIX [8086/7110] at 00:14.0 
Nov 27 13:59:29 adlib kernel: Limiting direct PCI/PCI transfers. 
Nov 27 13:59:29 adlib kernel: isapnp: Scanning for Pnp cards... 
Nov 27 13:59:29 adlib kernel: ISAPnP: SB audio device quirk - increasing port range 
Nov 27 13:59:29 adlib kernel: isapnp: AWE32 quirk - adding two ports 
Nov 27 13:59:29 adlib kernel: isapnp: Card 'Creative SB AWE64  PnP' 
Nov 27 13:59:29 adlib kernel: isapnp: 1 Plug & Play card detected total 
Nov 27 13:59:29 adlib kernel: Linux NET4.0 for Linux 2.4 
Nov 27 13:59:29 adlib kernel: Based upon Swansea University Computer Society NET3.039 
Nov 27 13:59:29 adlib kernel: Initializing RT netlink socket 
Nov 27 13:59:29 adlib kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.13) 
Nov 27 13:59:29 adlib kernel: Starting kswapd v1.8 
Nov 27 13:59:29 adlib kernel: pty: 256 Unix98 ptys configured 
Nov 27 13:59:29 adlib kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize 
Nov 27 13:59:29 adlib kernel: loop: enabling 8 loop devices 
Nov 27 13:59:29 adlib kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31 
Nov 27 13:59:29 adlib kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx 
Nov 27 13:59:29 adlib kernel: PIIX4: IDE controller on PCI bus 00 dev a1 
Nov 27 13:59:29 adlib kernel: PIIX4: chipset revision 1 
Nov 27 13:59:29 adlib kernel: PIIX4: not 100% native mode: will probe irqs later 
Nov 27 13:59:29 adlib kernel:     ide0: BM-DMA at 0x10a0-0x10a7, BIOS settings: hda:DMA, hdb:pio 
Nov 27 13:59:29 adlib kernel:     ide1: BM-DMA at 0x10a8-0x10af, BIOS settings: hdc:DMA, hdd:DMA 
Nov 27 13:59:29 adlib kernel: hda: IBM-DTLA-305040, ATA DISK drive 
Nov 27 13:59:29 adlib kernel: hdb: CR-2801TE, ATAPI CDROM drive 
Nov 27 13:59:29 adlib kernel: hdc: IBM-DJNA-371350, ATA DISK drive 
Nov 27 13:59:29 adlib kernel: hdd: LTN483L, ATAPI CDROM drive 
Nov 27 13:59:29 adlib crond: crond startup succeeded
Nov 27 13:59:29 adlib kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14 
Nov 27 13:59:29 adlib kernel: ide1 at 0x170-0x177,0x376 on irq 15 
Nov 27 13:59:29 adlib kernel: hda: 80418240 sectors (41174 MB) w/380KiB Cache, CHS=5318/240/63, UDMA(33) 
Nov 27 13:59:29 adlib kernel: hdc: 26520480 sectors (13578 MB) w/1966KiB Cache, CHS=26310/16/63, UDMA(33) 
Nov 27 13:59:29 adlib kernel: hdd: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33) 
Nov 27 13:59:29 adlib kernel: Uniform CD-ROM driver Revision: 3.11 
Nov 27 13:59:29 adlib kernel: Partition check: 
Nov 27 13:59:29 adlib kernel:  hda: [PTBL] [5005/255/63] hda1 hda2 hda3 < hda5 hda6 > 
Nov 27 13:59:29 adlib kernel:  hdc: [PTBL] [1754/240/63] hdc1 hdc2 < hdc5 > 
Nov 27 13:59:29 adlib kernel: Floppy drive(s): fd0 is 1.44M 
Nov 27 13:59:29 adlib kernel: FDC 0 is a National Semiconductor PC87306 
Nov 27 13:59:29 adlib kernel: Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled 
Nov 27 13:59:29 adlib kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A 
Nov 27 13:59:29 adlib kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A 
Nov 27 13:59:29 adlib kernel: Real Time Clock Driver v1.10d 
Nov 27 13:59:29 adlib kernel: SCSI subsystem driver Revision: 1.00 
Nov 27 13:59:29 adlib kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices 
Nov 27 13:59:29 adlib kernel:   Vendor: MITSUMI   Model: CR-2801TE         Rev: 1.06 
Nov 27 13:59:29 adlib kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02 
Nov 27 13:59:29 adlib loopback: Starting loopback: 
Nov 27 13:59:29 adlib kernel: NET4: Linux TCP/IP 1.0 for NET4.0 
Nov 27 13:59:29 adlib kernel: IP Protocols: ICMP, UDP, TCP, IGMP 
Nov 27 13:59:29 adlib kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes 
Nov 27 13:59:29 adlib rc: Starting loopback succeeded
Nov 27 13:59:29 adlib kernel: TCP: Hash tables configured (established 16384 bind 16384) 
Nov 27 13:59:30 adlib kernel: Linux IP multicast router 0.06 plus PIM-SM 
Nov 27 13:59:30 adlib kernel: IP-Config: No network devices available. 
Nov 27 13:59:30 adlib kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0. 
Nov 27 13:59:30 adlib kernel: VFS: Mounted root (ext2 filesystem) readonly. 
Nov 27 13:59:30 adlib kernel: Freeing unused kernel memory: 196k freed 
Nov 27 13:59:30 adlib kernel: Adding Swap: 200804k swap-space (priority -1) 
Nov 27 13:59:30 adlib kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000004c 
Nov 27 13:59:30 adlib kernel:  printing eip: 
Nov 27 13:59:30 adlib kernel: cc81a074 
Nov 27 13:59:30 adlib kernel: *pde = 00000000 
Nov 27 13:59:30 adlib kernel: Oops: 0000 
Nov 27 13:59:30 adlib kernel: CPU:    0 
Nov 27 13:59:30 adlib kernel: EIP:    0010:[awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-73612/80] 
Nov 27 13:59:30 adlib kernel: EFLAGS: 00010202 
Nov 27 13:59:30 adlib kernel: eax: 0000004c   ebx: cc81c000   ecx: cbfcb000   edx: cbfcb000 
Nov 27 13:59:30 adlib kernel: esi: cc81cfd8   edi: 00000001   ebp: cc81a890   esp: cba03ea8 
Nov 27 13:59:30 adlib kernel: ds: 0018   es: 0018   ss: 0018 
Nov 27 13:59:30 adlib kernel: Process modprobe (pid: 96, stackpage=cba03000) 
Nov 27 13:59:30 adlib kernel: Stack: cba03eac cc81a183 cbfcbee0 cc81af44 cc828840 ffffffff 00000001 00000002  
Nov 27 13:59:30 adlib modules-2.4.0: Starting modules: 
Nov 27 13:59:30 adlib kernel:        cc81c000 cc81cfd8 00000001 cc82a314 c025a720 0000a7fe 0000a7fe 00000296  
Nov 27 13:59:30 adlib kernel:        cc81a2ae cc81af44 cc828840 ffffffff 00000001 00000002 cc81a890 00000180  
Nov 27 13:59:30 adlib kernel: Call Trace: [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-73341/80] [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-69820/80] [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-14272/80] [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-65536/80] [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-61480/80] [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-7404/80] [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-73042/80]  
Nov 27 13:59:30 adlib kernel:        [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-69820/80] [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-14272/80] [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-71536/80] [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-61676/80] [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-14272/80] [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-61453/80] [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-65536/80] [sys_init_module+1409/1576]  
Nov 27 13:59:30 adlib kernel:        [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-73728/80] [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-73728/80] [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-7424/80] [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-73728/80] [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-65440/80] [system_call+51/56]  
Nov 27 13:59:30 adlib kernel: Code: 39 10 7d 09 8d 58 08 83 78 08 00 75 f1 39 f2 7d 18 8b 03 85  
Nov 27 13:59:30 adlib kernel: Unable to handle kernel NULL pointer dereference at virtual address 000007d9 
Nov 27 13:59:30 adlib kernel:  printing eip: 
Nov 27 13:59:26 adlib rc.sysinit: Mounting proc filesystem succeeded 
Nov 27 13:59:30 adlib kernel: cc82c050 
Nov 27 13:59:26 adlib sysctl: net.ipv4.ip_forward = 0 
Nov 27 13:59:30 adlib kernel: *pde = 00000000 
Nov 27 13:59:26 adlib sysctl: net.ipv4.conf.all.rp_filter = 1 
Nov 27 13:59:30 adlib kernel: Oops: 0002 
Nov 27 13:59:26 adlib sysctl: kernel.sysrq = 0 
Nov 27 13:59:30 adlib kernel: CPU:    0 
Nov 27 13:59:26 adlib sysctl: error: 'net.ipv4.ip_always_defrag' is an unknown key 
Nov 27 13:59:30 adlib modprobe: modprobe: Can't locate module parport_lowlevel
Nov 27 13:59:30 adlib kernel: EIP:    0010:[awe_wave:__insmod_awe_wave_S.text_L29392+0/29520] 
Nov 27 13:59:26 adlib rc.sysinit: Configuring kernel parameters succeeded 
Nov 27 13:59:30 adlib kernel: EFLAGS: 00010282 
Nov 27 13:59:26 adlib date: Mon Nov 27 13:59:25 CET 2000 
Nov 27 13:59:30 adlib kernel: eax: 000007d9   ebx: cc82c000   ecx: c025a72c   edx: c025a72c 
Nov 27 13:59:26 adlib rc.sysinit: Setting clock : Mon Nov 27 13:59:25 CET 2000 succeeded 
Nov 27 13:59:30 adlib rc: Starting modules-2.4.0 succeeded
Nov 27 13:59:26 adlib rc.sysinit: Loading default keymap succeeded 
Nov 27 13:59:30 adlib kernel: esi: cc8332f8   edi: 00000001   ebp: cc8523fc   esp: cb8f7f18 
Nov 27 13:59:26 adlib rc.sysinit: Activating swap partitions succeeded 
Nov 27 13:59:30 adlib kernel: ds: 0018   es: 0018   ss: 0018 
Nov 27 13:59:26 adlib rc.sysinit: Setting hostname adlib succeeded 
Nov 27 13:59:30 adlib kernel: Process modprobe (pid: 102, stackpage=cb8f7000) 
Nov 27 13:59:26 adlib fsck: /dev/hda5: clean, 141957/4489216 files, 1381628/8970286 blocks 
Nov 27 13:59:30 adlib kernel: Stack: cc8332fd c011904d cb8f6000 40112008 08066a28 bfffe094 00000001 cc81c000  
Nov 27 13:59:26 adlib rc.sysinit: Checking root filesystem succeeded 
Nov 27 13:59:30 adlib kernel:        cc81c000 cc8523e8 0000004c cb8f7f60 cb7b0000 0000ab70 00000008 cb7b1000  
Nov 27 13:59:26 adlib isapnp: Board 1 has Identity 08 05 00 69 f2 e4 00 8c 0e:  CTL00e4 Serial No 83913202 [checksum 08] 
Nov 27 13:59:30 adlib kernel:        ffffffea cbfcbec0 00000060 cc81c000 cc82c060 000263f4 00000000 00000000  
Nov 27 13:59:26 adlib isapnp: CTL00e4/83913202[0]{Audio               }: Ports 0x240 0x300; IRQ5 DMA0 DMA5 --- Enabled OK 
Nov 27 13:59:30 adlib kernel: Call Trace: [awe_wave:__insmod_awe_wave_S.text_L29392+29357/29520] [sys_init_module+1409/1576] [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-65536/80] [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-65536/80] [sound:__insmod_sound_S.bss_L5280+169352/30655794] [awe_wave:__insmod_awe_wave_O/lib/modules/2.4.0-test11/sound/awe_wave+-65536/80] [awe_wave:__insmod_awe_wave_S.text_L29392+16/29520]  
Nov 27 13:59:26 adlib isapnp: CTL00e4/83913202[1]{Game                }: Port 0x200; --- Enabled OK 
Nov 27 13:59:30 adlib kernel:        [system_call+51/56]  
Nov 27 13:59:26 adlib isapnp: CTL00e4/83913202[2]{WaveTable           }: Ports 0x620 0xA20 0xE20; --- Enabled OK 
Nov 27 13:59:30 adlib kernel: Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 e8 03 5f 00  
Nov 27 13:59:26 adlib rc.sysinit: Setting up ISA PNP devices succeeded 
Nov 27 13:59:30 adlib kernel: CSLIP: code copyright 1989 Regents of the University of California 
Nov 27 13:59:26 adlib rc.sysinit: Remounting root filesystem in read-write mode succeeded 
Nov 27 13:59:30 adlib kernel: PPP generic driver version 2.4.1 
Nov 27 13:59:30 adlib inet: inetd startup succeeded
Nov 27 13:59:26 adlib depmod: depmod:  
Nov 27 13:59:30 adlib kernel: PPP Deflate Compression module registered 
Nov 27 13:59:26 adlib depmod: *** Unresolved symbols in /lib/modules/2.4.0-test11/misc/vmmon.o 
Nov 27 13:59:31 adlib kernel: lp: driver loaded but no devices found 
Nov 27 13:59:26 adlib depmod: depmod: *** Unresolved symbols in /lib/modules/2.4.0-test11/misc/vmnet.o 
Nov 27 13:59:31 adlib kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000 
Nov 27 13:59:26 adlib rc.sysinit: Finding module dependencies succeeded 
Nov 27 13:59:31 adlib kernel:  printing eip: 
Nov 27 13:59:27 adlib rc.sysinit: Loading sound module (sb) failed 
Nov 27 13:59:31 adlib kernel: cc86d050 
Nov 27 13:59:27 adlib rc.sysinit: Loading midi module (awe_wave) failed 
Nov 27 13:59:31 adlib kernel: *pde = 00000000 
Nov 27 13:59:27 adlib fsck: /boot: clean, 29/8032 files, 6627/32098 blocks 
Nov 27 13:59:31 adlib kernel: Oops: 0002 
Nov 27 13:59:31 adlib squid: Starting squid: init_cache_dir ufs... 
Nov 27 13:59:27 adlib rc.sysinit: Checking filesystems succeeded 
Nov 27 13:59:31 adlib kernel: CPU:    0 
Nov 27 13:59:27 adlib rc.sysinit: Mounting local filesystems succeeded 
Nov 27 13:59:32 adlib kernel: EIP:    0010:[sound:__insmod_sound_S.bss_L5280+279024/30546122] 
Nov 27 13:59:27 adlib rc.sysinit: Turning on user and group quotas for local filesystems succeeded 
Nov 27 13:59:32 adlib kernel: EFLAGS: 00010246 
Nov 27 13:59:27 adlib rc.sysinit: Enabling swap space succeeded 
Nov 27 13:59:32 adlib kernel: eax: 00000000   ebx: fffffffe   ecx: cc86f704   edx: 00000000 
Nov 27 13:59:27 adlib init: Entering runlevel: 4 
Nov 27 13:59:33 adlib kernel: esi: fffffffd   edi: 00000000   ebp: cc86f7e0   esp: cb5cfec8 
Nov 27 13:59:28 adlib hdparm: Starting harddisk acceleration:  
Nov 27 13:59:33 adlib kernel: ds: 0018   es: 0018   ss: 0018 
Nov 27 13:59:28 adlib hdparm: Setting acceleration to X66! 
Nov 27 13:59:33 adlib kernel: Process insmod (pid: 260, stackpage=cb5cf000) 
Nov 27 13:59:28 adlib hdparm:  
Nov 27 13:59:33 adlib kernel: Stack: cc86df25 fffffffd fffffffe cc86f760 cc86f800 00000000 cc86dfe4 fffffffd  
Nov 27 13:59:28 adlib hdparm: /dev/hda: 
Nov 27 13:59:34 adlib kernel:        fffffffe 00000000 cc86dff4 00000000 00002958 00000000 cc86e0c9 cc86f760  
Nov 27 13:59:28 adlib hdparm:  setting using_dma to 1 (on) 
Nov 27 13:59:34 adlib kernel:        cc86f7a0 cc86f800 cc86f7e0 cc86d000 cc86d000 c011904d cb5ce000 08069aa0  
Nov 27 13:59:28 adlib hdparm:  setting xfermode to 66 (UltraDMA mode2) 
Nov 27 13:59:34 adlib kernel: Call Trace: [sound:__insmod_sound_S.bss_L5280+282821/30542325] [sound:__insmod_sound_S.bss_L5280+289024/30536122] [sound:__insmod_sound_S.bss_L5280+289184/30535962] [sound:__insmod_sound_S.bss_L5280+283012/30542134] [sound:__insmod_sound_S.bss_L5280+283028/30542118] [sound:__insmod_sound_S.bss_L5280+283241/30541905] [sound:__insmod_sound_S.bss_L5280+289024/30536122]  
Nov 27 13:59:28 adlib hdparm:  using_dma    =  1 (on) 
Nov 27 13:59:35 adlib kernel:        [sound:__insmod_sound_S.bss_L5280+289088/30536058] [sound:__insmod_sound_S.bss_L5280+289184/30535962] [sound:__insmod_sound_S.bss_L5280+289152/30535994] [sound:__insmod_sound_S.bss_L5280+278944/30546202] [sound:__insmod_sound_S.bss_L5280+278944/30546202] [sys_init_module+1409/1576] [sound:__insmod_sound_S.bss_L5280+289496/30535650] [sound:__insmod_sound_S.bss_L5280+266656/30558490]  
Nov 27 13:59:28 adlib hdparm:  
Nov 27 13:59:35 adlib kernel:        [sound:__insmod_sound_S.bss_L5280+279040/30546106] [system_call+51/56]  
Nov 27 13:59:28 adlib hdparm: /dev/hdc: 
Nov 27 13:59:35 adlib kernel: Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 c4 08 c3 90  
Nov 27 13:59:28 adlib hdparm:  setting using_dma to 1 (on) 
Nov 27 13:59:28 adlib hdparm:  setting xfermode to 66 (UltraDMA mode2) 
Nov 27 13:59:28 adlib hdparm:  setting standby to 4 (20 seconds) 
Nov 27 13:59:28 adlib hdparm:  using_dma    =  1 (on) 
Nov 27 13:59:28 adlib rc: Starting hdparm succeeded 
Nov 27 13:59:28 adlib apmd[191]: Version 3.0final (APM BIOS 1.2, Linux driver 1.13) 
Nov 27 13:59:28 adlib apmd: apmd startup succeeded 
Nov 27 13:59:28 adlib random: Initializing random number generator succeeded 
Nov 27 13:59:39 adlib squid: squid
Nov 27 13:59:39 adlib squid[290]: Squid Parent: child process 291 started
Nov 27 13:59:39 adlib rc: Starting squid succeeded
Nov 27 13:59:39 adlib squid[291]: Starting Squid Cache version 2.3.STABLE1 for i686-pc-linux-gnu... 
Nov 27 13:59:39 adlib squid[291]: Process ID 291 
Nov 27 13:59:39 adlib squid[291]: With 1024 file descriptors available 
Nov 27 13:59:39 adlib squid[291]: DNS Socket created on FD 2 
Nov 27 13:59:39 adlib lpd: lpd startup succeeded
Nov 27 13:59:39 adlib lpd[304]: restarted
Nov 27 13:59:40 adlib keytable: Loading keymap: 
Nov 27 13:59:40 adlib keytable: Loading /usr/lib/kbd/keymaps/i386/qwertz/de-latin1-nodeadkeys.kmap.gz
Nov 27 13:59:40 adlib keytable: Loading system font: 
Nov 27 13:59:40 adlib rc: Starting keytable succeeded
Nov 27 13:59:40 adlib squid[291]: Unlinkd pipe opened on FD 7 
Nov 27 13:59:40 adlib squid[291]: Swap maxSize 1024000 KB, estimated 78769 objects 
Nov 27 13:59:40 adlib squid[291]: Target number of buckets: 1575 
Nov 27 13:59:40 adlib squid[291]: Using 8192 Store buckets 
Nov 27 13:59:40 adlib squid[291]: Max Mem  size: 8192 KB 
Nov 27 13:59:40 adlib squid[291]: Max Swap size: 1024000 KB 
Nov 27 13:59:40 adlib squid[291]: Using LFUDA disk replacement policy 
Nov 27 13:59:40 adlib squid[291]: Rebuilding storage in /var/spool/squid (CLEAN) 
Nov 27 13:59:40 adlib squid[291]: Set Current Directory to /var/spool/squid 
Nov 27 13:59:42 adlib squid[291]: Loaded Icons. 
Nov 27 13:59:42 adlib squid[291]: Accepting HTTP connections at 127.0.0.1, port 3128, FD 9. 
Nov 27 13:59:42 adlib squid[291]: Accepting ICP messages at 0.0.0.0, port 3130, FD 10. 
Nov 27 13:59:42 adlib squid[291]: Accepting SNMP messages on port 3401, FD 11. 
Nov 27 13:59:42 adlib squid[291]: WCCP Disabled. 
Nov 27 13:59:42 adlib squid[291]: Ready to serve requests. 
Nov 27 13:59:42 adlib squid[291]: Done reading /var/spool/squid swaplog (8046 entries) 
Nov 27 13:59:42 adlib squid[291]: Finished rebuilding storage from disk. 
Nov 27 13:59:42 adlib squid[291]:      8046 Entries scanned 
Nov 27 13:59:42 adlib squid[291]:         0 Invalid entries. 
Nov 27 13:59:42 adlib squid[291]:         0 With invalid flags. 
Nov 27 13:59:42 adlib squid[291]:      8046 Objects loaded. 
Nov 27 13:59:42 adlib squid[291]:         0 Objects expired. 
Nov 27 13:59:42 adlib squid[291]:         0 Objects cancelled. 
Nov 27 13:59:42 adlib squid[291]:         0 Duplicate URLs purged. 
Nov 27 13:59:42 adlib squid[291]:         0 Swapfile clashes avoided. 
Nov 27 13:59:42 adlib squid[291]:   Took 3.4 seconds (2351.9 objects/sec). 
Nov 27 13:59:42 adlib squid[291]: Beginning Validation Procedure 
Nov 27 13:59:42 adlib squid[291]:   Completed Validation Procedure 
Nov 27 13:59:42 adlib squid[291]:   Validated 8046 Entries 
Nov 27 13:59:42 adlib squid[291]:   store_swap_size = 50522k 
Nov 27 13:59:43 adlib squid[291]: storeLateRelease: released 0 objects 
Nov 27 13:59:43 adlib xfs: xfs startup succeeded
Nov 27 13:59:44 adlib xfs: Warning: The directory "/usr/share/fonts/default/TrueType" does not exist. 
Nov 27 13:59:44 adlib xfs:          Entry deleted from font path. 
Nov 27 13:59:44 adlib ATextMode: Starting SVGATextMode: 
Nov 27 13:59:44 adlib ATextMode: Warning: this is a shell wrapper; consider using consolechars(8)
Nov 27 13:59:44 adlib ATextMode: Chipset = `MATROX', Textmode clock = 45.00 MHz, 132x34 chars, CharCell = 9x14. Refresh = 31.25kHz/59.5Hz.
Nov 27 13:59:44 adlib ATextMode: Warning: this is a shell wrapper; consider using consolechars(8)
Nov 27 13:59:44 adlib rc: Starting SVGATextMode succeeded
Nov 27 13:59:45 adlib gpm: gpm startup succeeded
Nov 27 13:59:45 adlib xdm: Starting X Display Manager: 
Nov 27 13:59:46 adlib rc: Starting xdm succeeded
Nov 27 13:59:54 adlib PAM_pwdb[465]: (gdm) session opened for user root by (uid=0)
Nov 27 14:01:06 adlib kernel: Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996 
Nov 27 14:01:06 adlib kernel: sb: Creative SB AWE64  PnP detected 
Nov 27 14:01:06 adlib kernel: sb: ISAPnP reports 'Creative SB AWE64  PnP' at i/o 0x220, irq 5, dma 1, 5 
Nov 27 14:01:06 adlib kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000001 
Nov 27 14:01:06 adlib kernel:  printing eip: 
Nov 27 14:01:06 adlib kernel: cc87a050 
Nov 27 14:01:06 adlib kernel: *pde = 00000000 
Nov 27 14:01:06 adlib kernel: Oops: 0002 
Nov 27 14:01:06 adlib kernel: CPU:    0 
Nov 27 14:01:06 adlib kernel: EIP:    0010:[sound:__insmod_sound_S.bss_L5280+332272/30492874] 
Nov 27 14:01:06 adlib kernel: EFLAGS: 00010002 
Nov 27 14:01:06 adlib kernel: eax: 00000001   ebx: c9241e0c   ecx: 00000003   edx: 0000022a 
Nov 27 14:01:06 adlib kernel: esi: c9241e0c   edi: 00000202   ebp: 00000000   esp: c9241db4 
Nov 27 14:01:06 adlib kernel: ds: 0018   es: 0018   ss: 0018 
Nov 27 14:01:06 adlib kernel: Process modprobe (pid: 562, stackpage=c9241000) 
Nov 27 14:01:06 adlib kernel: Stack: cc87a2e8 c9241e0c 000000e1 c9241e0c 00000005 00000001 00000000 cc87a827  
Nov 27 14:01:06 adlib kernel:        c9241e0c 00000000 cc8855e0 00000000 cc885700 00000220 00000000 00000000  
Nov 27 14:01:06 adlib kernel:        69647541 0000006f 00000000 00000000 00000000 00000000 ffffffff 00000000  
Nov 27 14:01:06 adlib modprobe: modprobe: Can't locate module sound-service-0-3
Nov 27 14:01:06 adlib kernel: Call Trace: [sound:__insmod_sound_S.bss_L5280+332936/30492210] [sound:__insmod_sound_S.bss_L5280+334279/30490867] [sound:__insmod_sound_S.bss_L5280+378752/30446394] [sound:__insmod_sound_S.bss_L5280+379040/30446106] [sound:__insmod_sound_S.bss_L5280+373351/30451795] [sound:__insmod_sound_S.bss_L5280+378752/30446394] [sound:__insmod_sound_S.bss_L5280+375094/30450052]  
Nov 27 14:01:06 adlib kernel:        [sound:__insmod_sound_S.bss_L5280+378752/30446394] [sound:__insmod_sound_S.bss_L5280+373152/30451994] [sound:__insmod_sound_S.bss_L5280+374872/30450274] [sound:__insmod_sound_S.bss_L5280+379332/30445814] [sys_init_module+1409/1576] [sound:__insmod_sound_S.bss_L5280+332192/30492954] [sound:__insmod_sound_S.bss_L5280+332192/30492954] [sound:__insmod_sound_S.bss_L5280+379312/30445834]  
Nov 27 14:01:06 adlib kernel:        [sound:__insmod_sound_S.bss_L5280+332192/30492954] [sound:__insmod_sound_S.bss_L5280+373248/30451898] [system_call+51/56] [error_table+4059/16228]  
Nov 27 14:01:06 adlib kernel: Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 44 24 0f a1  




--------------CBAAF9ACE136A27954BD8525--



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
