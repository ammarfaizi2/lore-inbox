Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275172AbRJAPnT>; Mon, 1 Oct 2001 11:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275173AbRJAPnJ>; Mon, 1 Oct 2001 11:43:09 -0400
Received: from fw.tnt.de ([194.55.63.2]:57199 "EHLO de188w20.intra.tnt.de")
	by vger.kernel.org with ESMTP id <S275172AbRJAPm7>;
	Mon, 1 Oct 2001 11:42:59 -0400
X-Mailer: Lotus Notes Release 5.0.6a  January 17, 2001
Subject: nfs - high_memory
To: <linux-kernel@vger.kernel.org>
Message-ID: <OFA1C23172.3BD81DE2-ONC1256AD8.0055FBCE@intra.tnt.de>
From: Michael.May@tnt.de
Date: Mon, 1 Oct 2001 17:43:28 +0200
X-MIMETrack: Serialize by Router on DE188W20/SRV/DE/TNT/TPG(Release 5.0.8 |June 18, 2001) at
 01.10.2001 17:43:28
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

when you're interested in, here is a little Problem, appeared on weekend.
I'm proud to got 1.5 GB of Memory in my workstation, and with the new
kernel
2.4.10, the nfs-client won't run anymore.
I think, there is a little problem with the high-memory mapping, but I
can't solve it.
On work, there is not such a problem, because my computer got only 256 MB
RAM.

Here is the message:

meikel1:/usr/src/linux # insmod nfs
Using /lib/modules/2.4.10/kernel/fs/nfs/nfs.o
/lib/modules/2.4.10/kernel/fs/nfs/nfs.o: unresolved symbol kunmap_high
/lib/modules/2.4.10/kernel/fs/nfs/nfs.o: unresolved symbol
highmem_start_page
/lib/modules/2.4.10/kernel/fs/nfs/nfs.o: unresolved symbol kmap_high


System-overview:

  Checking the system meikel1  30.09.01. 16:56:54 - Up since 1 h 02 3
 System is meikel1.privat, the OS is linux on Processortype i386
 Running is Kernel 2.4.10, version #1 SMP Sun Sep 30 15:16:11 CEST 2001

 2 CPU('s) detected,  Type is Pentium III;
 frequency is 801/801/ MHz,
 ( 1599.07/ 1602.35/) BogoMIPS

 Memory |   Installed |   available |    used     |
 -------|-------------|-------------|-------------|
 phys.  |  1546104 kB |  1496928 kB |    49176 kB |
 swap   |   313296 kB |   313296 kB |        0 kB |
 total  |  1859400 kB |  1810224 kB |    49176 kB |

 IDE:
 hda: disk Maxtor 90750D6 7157 Mbytes
 hdb: disk HP 1600 A 1554 Mbytes
 hdc: cdrom LTN382

 Harddisks:
 sda (4303.65 MB)  sdb (4303.65 MB)  hda (7157.39 MB)  hdb (1554.77 MB)

 sda1 (20.9844 MB) mounted on /boot
 sda5 (4128.98 MB) mounted on /
 sdb5 (1000.98 MB) mounted on /usr/lib
 sdb6 (3127.98 MB) mounted on /usr/src

 Logical Volumes
 /dev/vg00 - (1.52 GB) /dev/hdb1(1552/1552)

 PCI-devices found:
 00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev c4)
 00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP]
 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South]
(rev 23)
 00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
 00:07.3 Bridge: VIA Technologies, Inc. VT82C596 Power Management (rev 30)
 00:08.0 VGA compatible Card: nVidia Corp. Riva TnT 128 [NV04] (rev 04)
 00:09.0 Ethernet Card: Digital Equipment Corp. DECchip 21142/43 (rev 41)
 00:0b.0 Unknown mass storage Card: Triones Technologies, Inc. HPT366 (rev
03)
 00:0c.0 SCSI storage Card: Adaptec AHA-294x / AIC-7871 (rev 03)

 SCSI-Devices :
 scsi0:00:00:00 scsi-02-HardDisk IBM DCHS04W rev.6464
 scsi0:00:01:00 scsi-02-HardDisk IBM DCHS04W rev.6464
 scsi0:00:03:00 scsi-02-CD-ROM SANYO CRD-254S rev.1.06
 scsi0:00:05:00 scsi-02-Scanner Model Scanner rev.3.01

 1  NIC('s) found:
 NIC  |   IP-Address    |    SN-Mask      |    Broadcast    |   HW-Address
|
      |   ipv6-addr     |                 |                 |
|

-----|-----------------|-----------------|-----------------|------------------|
 eth0 |     192.168.2.5 |   255.255.255.0 |   192.168.2.255 |
00:40:C7:99:E1:21
      |     fe80:00:240:c7ff:fe99:e121/10 |

Hope, this message is useful to you, if not don't hesitate to mail.
With kind regards

Michael May

