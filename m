Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262505AbRENVcm>; Mon, 14 May 2001 17:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262506AbRENVcc>; Mon, 14 May 2001 17:32:32 -0400
Received: from baltazar.tecnoera.com ([200.29.128.1]:2827 "EHLO
	baltazar.tecnoera.com") by vger.kernel.org with ESMTP
	id <S262505AbRENVcR>; Mon, 14 May 2001 17:32:17 -0400
Date: Mon, 14 May 2001 17:31:48 -0400 (CLT)
From: Juan Pablo Abuyeres <jpabuyer@tecnoera.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec RAID SCSI 2100S
In-Reply-To: <E14zLl1-0000zk-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0105141655590.4694-100000@baltazar.tecnoera.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2001, Alan Cox wrote:

> > well, I applied 2.4.4ac8 (I couldn't find ac9) and I still have only
> > errors when recognizing the hardware. The long waiting is gone. I will try
> > to send the messages somehow. They were not saved on log files because it
> > couldn't mount the devices (and I don't have a spare disk to do the trick
> > :/)
> >
> > Ideas?
>
> "Mine works" 8)
>
> Send me the messages. I'd really like to see whats up

you asked for it :-)

This is a RedHat 7.1 with kernel-2.4.4-ac9

May 14 16:29:12 lala kernel: SCSI subsystem driver Revision: 1.00
May 14 16:29:12 lala kernel: request_module[scsi_hostadapter]: Root fs not
mounted
May 14 16:29:12 lala kernel: i2o_scsi.c: Version 0.0.1
May 14 16:29:12 lala kernel:   chain_pool: 2048 bytes @ c14b7800
May 14 16:29:12 lala kernel:   (512 byte buffers X 4 can_queue X 1 i2o
controllers)
May 14 16:29:12 lala kernel: PARAMS_GET - Error:
May 14 16:29:12 lala kernel:   ErrorInfoSize = 0x01, BlockStatus = 0x08,
BlockSize = 0x0002
May 14 16:29:12 lala kernel: PARAMS_GET - Error:
May 14 16:29:12 lala kernel:   ErrorInfoSize = 0x01, BlockStatus = 0x08,
BlockSize = 0x0002
May 14 16:29:12 lala kernel: scsi0 : i2o/iop0
May 14 16:29:12 lala kernel:   Vendor: QUANTUM   Model: ATLAS10K2-TY184L
Rev: DDD6
May 14 16:29:12 lala kernel:   Type:   Direct-Access
ANSI SCSI revision: 03
May 14 16:29:12 lala kernel:   Vendor: QUANTUM   Model: ATLAS10K2-TY184L
Rev: DDD6
May 14 16:29:12 lala kernel:   Type:   Direct-Access
ANSI SCSI revision: 03
May 14 16:29:12 lala kernel: Attached scsi disk sda at scsi0, channel 0,
id 1, lun 0
May 14 16:29:12 lala kernel: Attached scsi disk sdb at scsi0, channel 0,
id 2, lun 0
May 14 16:29:12 lala kernel: scsi0 channel 0 : resetting for second half
of retries.
May 14 16:29:12 lala kernel: SCSI bus is being reset for host 0 channel 0.
May 14 16:29:12 lala kernel: i2o_scsi: Attempting to reset the bus.
May 14 16:29:12 lala kernel: i2o_scsi: bus reset reply.
May 14 16:29:12 lala kernel: scsi0 channel 0 : resetting for second half
of retries.
May 14 16:29:12 lala kernel: SCSI bus is being reset for host 0 channel 0.
May 14 16:29:12 lala kernel: i2o_scsi: Attempting to reset the bus.
May 14 16:29:12 lala kernel: i2o_scsi: bus reset reply.
May 14 16:29:12 lala kernel: scsi0 channel 0 : resetting for second half
of retries.
May 14 16:29:12 lala kernel: SCSI bus is being reset for host 0 channel 0.
May 14 16:29:12 lala kernel: i2o_scsi: Attempting to reset the bus.
May 14 16:29:12 lala kernel: i2o_scsi: bus reset reply.
May 14 16:29:12 lala kernel: sda : READ CAPACITY failed.
May 14 16:29:12 lala keytable:
May 14 16:29:12 lala kernel: sda : status = 0, message = 00, host = 7,
driver = 27
May 14 16:29:12 lala keytable: Loading system font:
May 14 16:29:12 lala kernel: sda : sense not available.
May 14 16:29:12 lala kernel: sda : block size assumed to be 512 bytes,
disk size 1GB.
May 14 16:29:12 lala kernel:  sda: sda1 sda2 < sda5 sda6 >
May 14 16:29:12 lala kernel: scsi0 channel 0 : resetting for second half
of retries.
May 14 16:29:12 lala kernel: SCSI bus is being reset for host 0 channel 0.
May 14 16:29:12 lala kernel: i2o_scsi: Attempting to reset the bus.
May 14 16:29:12 lala kernel: i2o_scsi: bus reset reply.
May 14 16:29:12 lala kernel: scsi0 channel 0 : resetting for second half
of retries.
May 14 16:29:12 lala kernel: SCSI bus is being reset for host 0 channel 0.
May 14 16:29:12 lala kernel: i2o_scsi: Attempting to reset the bus.
May 14 16:29:12 lala kernel: i2o_scsi: bus reset reply.
May 14 16:29:12 lala kernel: scsi0 channel 0 : resetting for second half
of retries.
May 14 16:29:12 lala kernel: SCSI bus is being reset for host 0 channel 0.
May 14 16:29:12 lala kernel: i2o_scsi: Attempting to reset the bus.
May 14 16:29:12 lala kernel: i2o_scsi: bus reset reply.
May 14 16:29:12 lala kernel: sdb : READ CAPACITY failed.
May 14 16:29:12 lala kernel: sdb : status = 0, message = 00, host = 7,
driver = 27
May 14 16:29:12 lala kernel: sdb : sense not available.
May 14 16:29:12 lala kernel: sdb : block size assumed to be 512 bytes,
disk size 1GB.
May 14 16:29:12 lala kernel:  sdb: sdb1 sdb2 < sdb5 sdb6 >
May 14 16:29:12 lala kernel: NET4: Linux TCP/IP 1.0 for NET4.0
May 14 16:29:12 lala kernel: IP Protocols: ICMP, UDP, TCP, IGMP
May 14 16:29:12 lala kernel: IP: routing cache hash table of 2048 buckets,
16Kbytes
May 14 16:29:12 lala kernel: TCP: Hash tables configured (established
16384 bind 16384)
May 14 16:29:12 lala kernel: NET4: Unix domain sockets 1.0/SMP for Linux
NET4.0.
May 14 16:29:12 lala kernel: VFS: Mounted root (ext2 filesystem) readonly.
May 14 16:29:12 lala kernel: Freeing unused kernel memory: 208k freed
May 14 16:29:12 lala kernel: Adding Swap: 265032k swap-space (priority -1)
May 14 16:29:12 lala kernel: Claim Claimed Mount Lock Ready.
May 14 16:29:12 lala kernel: Flushing...Unlocking...Unlocked.
May 14 16:29:12 lala kernel: Unclaim
May 14 16:29:12 lala kernel: Claim Claimed Mount Lock Ready.
May 14 16:29:12 lala kernel: Flushing...Unlocking...Unlocked.
May 14 16:29:12 lala kernel: Unclaim
May 14 16:29:12 lala kernel: Claim Claimed Mount Lock Ready.
May 14 16:29:12 lala kernel: Flushing...Unlocking...Unlocked.
May 14 16:29:12 lala kernel: Unclaim
May 14 16:29:12 lala kernel: Claim Claimed Mount Lock Ready.
May 14 16:29:12 lala kernel: Flushing...Unlocking...Unlocked.
May 14 16:29:12 lala kernel: Unclaim
May 14 16:29:12 lala kernel: Claim Claimed Mount Lock Ready.
May 14 16:29:12 lala kernel: Flushing...Unlocking...Unlocked.
May 14 16:29:12 lala kernel: Unclaim
May 14 16:29:12 lala kernel: Claim Claimed Mount Lock Ready.
May 14 16:29:12 lala kernel: Flushing...Unlocking...Unlocked.
May 14 16:29:12 lala kernel: Unclaim
May 14 16:29:12 lala kernel: Claim Claimed Mount Lock Ready.
May 14 16:29:12 lala kernel: Flushing...Unlocking...Unlocked.
May 14 16:29:12 lala kernel: Unclaim
May 14 16:29:12 lala kernel: Claim Claimed Mount Lock Ready.
May 14 16:29:12 lala kernel: Flushing...Unlocking...Unlocked.
May 14 16:29:12 lala kernel: Unclaim
May 14 16:29:12 lala kernel: Claim Claimed Mount Lock Ready.
May 14 16:29:12 lala kernel: Flushing...Unlocking...Unlocked.
May 14 16:29:12 lala kernel: Unclaim


Then When I tried to fdisk /dev/sda (/dev/sda is a RAID1 of two
Quantum disks) syslog shows this:

May 14 16:32:58 lala kernel: Queue depth now 2.
May 14 16:32:58 lala kernel: Queue depth now 3.
May 14 16:32:58 lala kernel: Queue depth now 4.
May 14 16:33:28 lala kernel: scsi : aborting command due to timeout : pid
0, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 00 00 06 00 00 02 00
May 14 16:33:28 lala kernel: i2o_scsi: Aborting command block.
May 14 16:33:28 lala kernel: SCSI host 0 abort (pid 0) timed out -
resetting
May 14 16:33:28 lala kernel: SCSI bus is being reset for host 0 channel 0.
May 14 16:33:28 lala kernel: i2o_scsi: Attempting to reset the bus.
May 14 16:33:28 lala kernel: i2o_scsi: bus reset reply.
May 14 16:33:29 lala kernel: SCSI host 0 channel 0 reset (pid 0) timed out
- trying harder
May 14 16:33:29 lala kernel: SCSI bus is being reset for host 0 channel 0.
May 14 16:33:29 lala kernel: i2o_scsi: Attempting to reset the bus.
May 14 16:33:29 lala kernel: i2o_scsi: bus reset reply.
May 14 16:33:29 lala kernel: SCSI host 0 reset (pid 0) timed out again -
May 14 16:33:29 lala kernel: probably an unrecoverable SCSI bus or device
hang.

After that, I got into fdisk... and that was a little ugly:

[root@lala log]# fdisk /dev/sda

Command (m for help): p

Disk /dev/sda: 64 heads, 32 sectors, 1023 cylinders
Units = cylinders of 2048 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sda1   *         1        16     16033+  83  Linux
Partition 1 has different physical/logical beginnings (non-Linux?):
     phys=(0, 1, 1) logical=(0, 1, 32)
Partition 1 has different physical/logical endings:
     phys=(1, 254, 63) logical=(15, 44, 2)
Partition 1 does not end on cylinder boundary:
     phys=(1, 254, 63) should be (1, 63, 32)
/dev/sda2            16     17509  17912475    5  Extended
Partition 2 has different physical/logical beginnings (non-Linux?):
     phys=(2, 0, 1) logical=(15, 44, 3)
Partition 2 has different physical/logical endings:
     phys=(1023, 254, 63) logical=(17508, 21, 24)
Partition 2 does not end on cylinder boundary:
     phys=(1023, 254, 63) should be (1023, 63, 32)
/dev/sda5            16       518    514048+  82  Linux swap
/dev/sda6           518     17509  17398363+  83  Linux

Command (m for help):


[root@lala log]# uname -a
Linux lala 2.4.4-ac9 #3 Mon May 14 16:24:06 CLT 2001 i686 unknown

[root@lala log]# lspci
00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and
Memory Controller Hub (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82815 CGC [Chipset
Graphics Controller]  (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82820 820 (Camino 2) Chipset PCI
(rev 02)
00:1f.0 ISA bridge: Intel Corporation 82820 820 (Camino 2) Chipset ISA
Bridge (ICH2) (rev 02)
00:1f.1 IDE interface: Intel Corporation 82820 820 (Camino 2) Chipset IDE
U100 (rev 02)
00:1f.2 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB
(Hub A) (rev 02)
00:1f.3 SMBus: Intel Corporation 82820 820 (Camino 2) Chipset SMBus (rev
02)
00:1f.4 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB
(Hub B) (rev 02)
01:08.0 Ethernet controller: Intel Corporation 82820 820 (Camino 2)
Chipset Ethernet (rev 01)
01:09.0 PCI bridge: Distributed Processing Technology PCI Bridge (rev 02)
01:09.1 I2O: Distributed Processing Technology SmartRAID V Controller (rev
02)
01:0a.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
01:0b.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
01:0c.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
01:0d.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)


Now, I removed the IDE Hard disk I used to get the previous logs and
booted up with the SCSI array itself, with kernel 2.2.19 patched with some
patch from adaptec to get dpt_i2o support:

[root@lala /root]# uname -a
Linux lala 2.2.19-6.2.1.DPT #1 Tue May 8 19:11:16 EDT 2001 i686 unknown

May 14 17:13:11 lala kernel: Adaptec: Reading the hardware resource table.
This could take up to 5 minutes
May 14 17:13:11 lala kernel: Adaptec: Hardware resource table read.
May 14 17:13:11 lala kernel: scsi0 : Vendor: DPT Model: 2100S
Rev: 320P
May 14 17:13:11 lala kernel: scsi : 1 host.
May 14 17:13:11 lala kernel:   Vendor: ADAPTEC   Model: RAID-1
Rev: 320P
May 14 17:13:11 lala kernel:   Type:   Direct-Access
ANSI SCSI revision: 02
May 14 17:13:11 lala kernel: Detected scsi disk sda at scsi0, channel 0,
id 1, lun 0
May 14 17:13:11 lala kernel: scsi : detected 1 SCSI disk total.
May 14 17:13:11 lala kernel: SCSI device sda: hdwr sector= 512 bytes.
Sectors= 35860480 [17510 MB] [17.5 GB]
May 14 17:13:11 lala kernel: Partition check:
May 14 17:13:11 lala kernel:  sda: sda1 sda2 < sda5 sda6 >
..
.
May 14 17:13:13 lala dpt: Starting Adaptec daemons

And issuing a fdisk:

[root@lala log]# fdisk /dev/sda

The number of cylinders for this disk is set to 2232.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)

Command (m for help): p

Disk /dev/sda: 255 heads, 63 sectors, 2232 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sda1   *         1         2     16033+  83  Linux
/dev/sda2             3      2232  17912475    5  Extended
/dev/sda5             3        66    514048+  82  Linux swap
/dev/sda6            67      2232  17398363+  83  Linux

Command (m for help):

So, I don't know if I'm doing something wrong or what, but I haven't been
able to get it working on 2.4.4 yet... please help.

Thanks.

Juan Pablo

