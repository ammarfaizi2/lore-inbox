Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275096AbRJAOb6>; Mon, 1 Oct 2001 10:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275097AbRJAObr>; Mon, 1 Oct 2001 10:31:47 -0400
Received: from mail.spylog.com ([194.67.35.220]:47507 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S275096AbRJAObc>;
	Mon, 1 Oct 2001 10:31:32 -0400
Date: Mon, 1 Oct 2001 18:27:53 +0400
From: "Oleg A. Yurlov" <kris@spylog.com>
X-Mailer: The Bat! (v1.53d)
Reply-To: "Oleg A. Yurlov" <kris@spylog.com>
Organization: SpyLOG Ltd.
X-Priority: 3 (Normal)
Message-ID: <1101445461994.20011001182753@spylog.com>
To: linux-kernel@vger.kernel.org
Subject: RAID sync
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Привет :-)

        Kernel 2.4.6.SuSE-4GB-SMP, 2 CPU, 2Gb RAM, 4 HDD SCSI, M/B Intel L440GX.
Messages from dmesg:

(scsi0:0:3:0) Synchronous at 80.0 Mbyte/sec, offset 63.
SCSI device sdd: 35843670 512-byte hdwr sectors (18352 MB)
 sdd: sdd1 sdd2
md: raid1 personality registered
md: raid5 personality registered
raid5: measuring checksumming speed
   8regs     :  1321.600 MB/sec
   32regs    :   978.400 MB/sec
   pIII_sse  :  1632.400 MB/sec
   pII_mmx   :  1790.000 MB/sec
   p5_mmx    :  1885.200 MB/sec
raid5: using function: pIII_sse (1632.400 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
(read) sda2's sb offset: 15815872 [events: 0000001d]
(read) sdb2's sb offset: 15815872 [events: 0000001c]
(read) sdc2's sb offset: 15815872 [events: 0000001d]
(read) sdd2's sb offset: 15815872 [events: 0000001d]
md: autorun ...
md: considering sdd2 ...
md:  adding sdd2 ...
md:  adding sdc2 ...
md: created md1
md: bind<sdc2,1>
md: bind<sdd2,2>
md: running: <sdd2><sdc2>
md: now!
md: sdd2's event counter: 0000001d
md: sdc2's event counter: 0000001d
md1: max total readahead window set to 508k
md1: 1 data-disks, max readahead per data-disk: 508k
raid1: device sdd2 operational as mirror 1
raid1: device sdc2 operational as mirror 0
raid1: raid set md1 active with 2 out of 2 mirrors
md: updating md1 RAID superblock on device
md: sdd2 [events: 0000001e](write) sdd2's sb offset: 15815872
md: sdc2 [events: 0000001e](write) sdc2's sb offset: 15815872
md: considering sdb2 ...
md:  adding sdb2 ...
md:  adding sda2 ...
md: created md0
md: bind<sda2,1>
md: bind<sdb2,2>
md: running: <sdb2><sda2>
md: now!
md: sdb2's event counter: 0000001c
md: sda2's event counter: 0000001d
md: superblock update time inconsistency -- using the most recent one
md: freshest: sda2
md0: max total readahead window set to 508k
md0: 1 data-disks, max readahead per data-disk: 508k
raid1: device sdb2 operational as mirror 1
raid1: device sda2 operational as mirror 0
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
md: sdb2 [events: 0000001e](write) sdb2's sb offset: 15815872
md: sda2 [events: 0000001e](write) sda2's sb offset: 15815872
md: ... autorun DONE.

        Why RAID do not start synchronization ? It is normal ?

--
Oleg A. Yurlov aka Kris Werewolf, SysAdmin      OAY100-RIPN
mailto:kris@spylog.com                          +7 095 332-03-88

