Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267591AbSLFUQe>; Fri, 6 Dec 2002 15:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267595AbSLFUQe>; Fri, 6 Dec 2002 15:16:34 -0500
Received: from basket.ball.reliam.net ([213.91.6.7]:40463 "EHLO
	basket.ball.reliam.net") by vger.kernel.org with ESMTP
	id <S267591AbSLFUQd>; Fri, 6 Dec 2002 15:16:33 -0500
Date: Fri, 6 Dec 2002 21:22:19 +0100
From: Tobias Rittweiler <inkognito.anonym@uni.de>
X-Mailer: The Bat! (v1.60q)
Reply-To: Tobias Rittweiler <inkognito.anonym@uni.de>
X-Priority: 3 (Normal)
Message-ID: <10525789281.20021206212219@uni.de>
To: linux-kernel@vger.kernel.org
Subject: [2.5.50] IDE error messages appearing after upgrade
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,

Upgrading from 2.4.19 to 2.5.50 results in getting IDE error log-messages on startup:

Dec  6 21:00:23 brood kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Dec  6 21:00:23 brood kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Dec  6 21:00:23 brood kernel: hda: JTS CORPORATION CHAMPION MODEL C2100-2A, ATA DISK drive
Dec  6 21:00:23 brood kernel: hdb: ST31720A, ATA DISK drive
Dec  6 21:00:23 brood kernel: hdc: ATAPI 12X DVDROM, ATAPI CD/DVD-ROM drive
Dec  6 21:00:23 brood kernel: hdd: CRD-8240B, ATAPI CD/DVD-ROM drive
Dec  6 21:00:23 brood kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec  6 21:00:23 brood kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec  6 21:00:23 brood kernel: hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Dec  6 21:00:23 brood kernel: hda: task_no_data_intr: error=0x04 { DriveStatusError }
Dec  6 21:00:23 brood kernel: hda: 4128768 sectors (2114 MB) w/256KiB Cache, CHS=1024/64/63
Dec  6 21:00:23 brood kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2
Dec  6 21:00:23 brood kernel: hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Dec  6 21:00:23 brood kernel: hdb: task_no_data_intr: error=0x04 { DriveStatusError }
Dec  6 21:00:23 brood kernel: hdb: 3329424 sectors (1705 MB), CHS=825/64/63
Dec  6 21:00:23 brood /usr/sbin/cron[111]: (CRON) INFO (Running @reboot jobs) 
Dec  6 21:00:23 brood kernel:  /dev/ide/host0/bus0/target1/lun0: p1 p2 p3 p4
Dec  6 21:00:23 brood /usr/sbin/gpm[119]: info: [/rock-linux/src/gpm-1.20.0/src/gpn.c(363)]: 
Dec  6 21:00:24 brood /usr/sbin/gpm[119]: Started gpm successfully. Entered daemon mode.
Dec  6 21:00:24 brood kernel: end_request: I/O error, dev hdc, sector 0
Dec  6 21:00:24 brood kernel: hdc: ATAPI 40X DVD-ROM drive, 512kB Cache
Dec  6 21:00:24 brood kernel: Uniform CD-ROM driver Revision: 3.12
Dec  6 21:00:24 brood kernel: end_request: I/O error, dev hdc, sector 0
Dec  6 21:00:24 brood kernel: end_request: I/O error, dev hdd, sector 0
Dec  6 21:00:24 brood kernel: end_request: I/O error, dev hdd, sector 0
Dec  6 21:00:24 brood kernel: hdd: ATAPI 24X CD-ROM drive, 128kB Cache

/proc/ide/hda/model: JTS CORPORATION CHAMPION MODEL C2100-2A
/proc/ide/hdb/model: ST31720A
/proc/ide/hdc/model: ATAPI 12x DVDROM
/proc/ide/hdd/model: CRD-8240B

Please come up with instructions what information (out of /proc/ide)
you need additionally.

--
cheers,
 Tobias

