Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271673AbRHQPdi>; Fri, 17 Aug 2001 11:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271676AbRHQPd3>; Fri, 17 Aug 2001 11:33:29 -0400
Received: from 200-221-84-35.dsl-sp.uol.com.br ([200.221.84.35]:56836 "HELO
	dumont.rtb.ath.cx") by vger.kernel.org with SMTP id <S271673AbRHQPdS>;
	Fri, 17 Aug 2001 11:33:18 -0400
Date: Wed, 15 Aug 2001 05:36:55 -0300
From: =?us-ascii?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Subject: Problems with 2.2.19 but not with 2.2.18 (was: Re: [OOPS] Oopsen with
 2.2.19)
In-Reply-To: <20010813212031.A3106@iname.com>
To: linux-kernel@vger.kernel.org
Mail-followup-to: linux-kernel@vger.kernel.org
Message-id: <asdfsadf20010815053655.A6693@iname.com>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_9wp4BWBlMIpVMuMe9wUZQw)"
Content-transfer-encoding: 8BIT
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010813212031.A3106@iname.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_9wp4BWBlMIpVMuMe9wUZQw)
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
Content-transfer-encoding: 8BIT

On Aug 13 2001, Rogério Brito wrote:
> 	Dear People,
> 
> 	I have a friend with a computer running a vanilla Linux 2.2.19
> 	that is a bit unstable nowadays.
(...)

	Thank you very much for everybody that helped with the problem
	that I have. I'll be checking the hardware of the machine and
	I'll let you know what the results that I have are (i.e., if
	the problem is indeed with cooling or with other hardware
	part).

	Meanwhile, I'm having other problems when I use a kernel
	2.2.19 in a computer with an Adaptec card.

	I get a lot of messages saying "Data overrun detected" when
	there is any slight disk activity (like the init scripts being
	loaded during boot). When the disk is almost idle, I don't see
	these messages, but if I trigger something (like a find
	process) that does something a bit more intense, then I get a
	huge number of these messages. I'm sending a dmesg attached to
	this e-mail.

	I don't see any such messages with kernel 2.2.18. Are these
	messages "dangerous" in any way? May it be the case that these
	events are also occuring when 2.2.18 is running but it is not
	reporting, while 2.2.19 is? Is there any potential bug with
	the hardware?

	The machine in question is a Samba server with low load
	generally.

	BTW, reading Alan Cox release notes
	(http://www.linux.org.uk/VERSION/relnotes.2219.html), I see
	that between kernels 2.2.18 and 2.2.19, the AIC7xxx driver was
	updated. May that be a cause of the problem?

	Is there any other information that is necessary? I see no
	Oops this time, BTW.


	Thank you very much for any help, Roger...

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito/
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

--Boundary_(ID_9wp4BWBlMIpVMuMe9wUZQw)
Content-type: text/plain; charset=us-ascii; NAME=dmesg.txt
Content-disposition: attachment; filename=dmesg.txt
Content-transfer-encoding: 7BIT

Linux version 2.2.19-1 (root@serv01) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 Fri Jul 20 17:13:20 BRT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0009f000 @ 00000000 (usable)
 BIOS-e820: 03cf0000 @ 00100000 (usable)
Detected 427753 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 851.96 BogoMIPS
Memory: 61312k/63424k available (840k kernel code, 416k reserved, 820k data, 36k init)
Dentry hash table entries: 8192 (order 4, 64k)
Buffer cache hash table entries: 65536 (order 6, 256k)
Page cache hash table entries: 16384 (order 4, 64k)
CPU: L1 I Cache: 32K  L1 D Cache: 32K
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xfdb81
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 65536 bhash 65536)
Initializing RT netlink socket
Starting kswapd v 1.5 
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.09
(scsi0) <Adaptec AHA-294X Ultra SCSI host adapter> found at PCI 0/10/0
(scsi0) Wide Channel, SCSI ID=0, 16/255 SCBs
(scsi0) Downloading sequencer code... 436 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.33/3.2.4
       <Adaptec AHA-294X Ultra SCSI host adapter>
scsi : 1 host.
  Vendor: FUJITSU   Model: MAB3091SP         Rev: 0106
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
(scsi0:0:1:2) Synchronous at 40.0 Mbyte/sec, offset 8.
scsi : detected 1 SCSI disk total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 17824700 [8703 MB] [8.7 GB]
Partition check:
 sda: sda1 sda2 sda3
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 36k freed
Adding Swap: 128484k swap-space (priority -1)
(scsi0:0:1:0) Data overrun detected in Data-In phase, tag 2;
  Have seen Data Phase. Length=1024, NumSGs=1.
  Raw SCSI Command: 0x28 00 00 9d 6c 56 00 00 02 00 
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS03 at 0x02e8 (irq = 3) is a 16550A
ne2k-pci.c: v1.02 for Linux 2.2, 10/19/2000, D. Becker/P. Gortmaker, http://www.scyld.com/network/ne2k-pci.html
ne2k-pci.c: PCI NE2000 clone 'Winbond 89C940' at I/O 0xdc00, IRQ 11.
eth0: Winbond 89C940 found at 0xdc00, IRQ 11, 00:40:95:02:7D:62.
(scsi0:0:1:0) Data overrun detected in Data-In phase, tag 1;
  Have seen Data Phase. Length=2048, NumSGs=1.
  Raw SCSI Command: 0x28 00 00 9b 3c 2e 00 00 04 00 
(scsi0:0:1:0) Data overrun detected in Data-In phase, tag 1;
  Have seen Data Phase. Length=1024, NumSGs=1.
  Raw SCSI Command: 0x28 00 00 b4 2c 5a 00 00 02 00 
(scsi0:0:1:0) Data overrun detected in Data-In phase, tag 1;
  Have seen Data Phase. Length=1024, NumSGs=1.
  Raw SCSI Command: 0x28 00 00 59 6c 68 00 00 02 00 
(scsi0:0:1:0) Data overrun detected in Data-In phase, tag 2;
  Have seen Data Phase. Length=1024, NumSGs=1.
  Raw SCSI Command: 0x28 00 00 65 f0 a2 00 00 02 00 
(scsi0:0:1:0) Data overrun detected in Data-In phase, tag 2;
  Have seen Data Phase. Length=1024, NumSGs=1.
  Raw SCSI Command: 0x28 00 01 0a 6c 60 00 00 02 00 
(scsi0:0:1:0) Data overrun detected in Data-In phase, tag 2;
  Have seen Data Phase. Length=1024, NumSGs=1.
  Raw SCSI Command: 0x28 00 00 a1 ac 5c 00 00 02 00 
(scsi0:0:1:0) Data overrun detected in Data-In phase, tag 1;
  Have seen Data Phase. Length=1024, NumSGs=1.
  Raw SCSI Command: 0x28 00 00 6d ac 5c 00 00 02 00 
(scsi0:0:1:0) Data overrun detected in Data-In phase, tag 1;
  Have seen Data Phase. Length=1024, NumSGs=1.
  Raw SCSI Command: 0x28 00 00 97 2c 5a 00 00 02 00 
(scsi0:0:1:0) Data overrun detected in Data-In phase, tag 2;
  Have seen Data Phase. Length=1024, NumSGs=1.
  Raw SCSI Command: 0x28 00 00 97 ae 98 00 00 02 00 
(scsi0:0:1:0) Data overrun detected in Data-In phase, tag 2;
  Have seen Data Phase. Length=1024, NumSGs=1.
  Raw SCSI Command: 0x28 00 00 96 2e da 00 00 02 00 

--Boundary_(ID_9wp4BWBlMIpVMuMe9wUZQw)--

