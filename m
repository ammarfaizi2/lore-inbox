Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129593AbQKGVnY>; Tue, 7 Nov 2000 16:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129699AbQKGVnP>; Tue, 7 Nov 2000 16:43:15 -0500
Received: from packetst0rm.net ([213.229.11.120]:23044 "HELO mail.f00bar.net")
	by vger.kernel.org with SMTP id <S129593AbQKGVnK>;
	Tue, 7 Nov 2000 16:43:10 -0500
Date: Tue, 7 Nov 2000 22:43:06 +0100 (CET)
From: Michael Kummer <frost@f00bar.net>
To: <linux-kernel@vger.kernel.org>
Subject: need urgent help with 2.2.17 + ipchains
Message-ID: <Pine.LNX.4.30.0011072239150.31349-100000@warp4.lan-rockerz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

i have the following very nasty problem.
everytime i execute ipchains -F [rule] my box freezes for 25 minutes!
i run slackware on 2.2.17.

a friend of mine told me that he had a simliar problem and fixed it with
downgrading shlibs.


any suggestion??


thx

michael



below the output of dmesg


-- CUT --
Linux version 2.2.17 (root@gatekeeper) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #2 Sun Sep 17 00:56:47 /e$Detected
166591 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 332.60 BogoMIPS
Memory: 128092k/131072k available (1012k kernel code, 408k reserved, 1516k
data, 44k init)
Dentry hash table entries: 16384 (order 5, 128k)
Buffer cache hash table entries: 131072 (order 7, 512k)
Page cache hash table entries: 32768 (order 5, 128k)
CPU: Intel Pentium MMX stepping 03
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
Intel Pentium with F0 0F bug - workaround enabled.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb3a0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 131072 bhash 65536)
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
early initialization of device sit0 is deferred
Initializing RT netlink socket
Starting kswapd v 1.5
Detected PS/2 Mouse Port.
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.13)
PIIX3: IDE controller on PCI bus 00 dev 39
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DHEA-36480, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: IBM-DHEA-36480, 6197MB w/476kB Cache, CHS=790/255/63, (U)DMA
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 8272A
Partition check:
 hda: hda1 hda2
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 44k freed
Adding Swap: 136544k swap-space (priority -1)
parport0: PC-style at 0x378 (0x778) [SPP,EPP,ECP,ECPEPP,ECPPS2]
parport0: detected irq 7; use procfs to enable interrupt-driven operation.
lp0: using parport0 (polling).
CSLIP: code copyright 1989 Regents of the University of California
PPP: version 2.3.7 (demand dialling)
PPP line discipline registered.
PPP BSD Compression module registered
rtl8139.c:v1.07 5/6/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/rtl8139.html
eth0: RealTek RTL8139 Fast Ethernet at 0x6300, IRQ 9, 00:00:21:cd:8e:37.
ne2k-pci.c:vpre-1.00e 5/27/99 D. Becker/P. Gortmaker
http://cesdis.gsfc.nasa.gov/linux/drivers/ne2k-pci.html
ne2k-pci.c: PCI NE2000 clone 'RealTek RTL-8029' at I/O 0x6100, IRQ 11.
eth1: RealTek RTL-8029 found at 0x6100, IRQ 11, 00:00:B4:59:13:7D.
registered device ppp0
eth0: no IPv6 routers present
PPP Deflate Compression module registered
eth1: no IPv6 routers present

-- CUT --

------------------------------------------
 10:00pm  up 114 days,  5:19,  3 users,  load average: 0.03, 0.02, 0.00

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
