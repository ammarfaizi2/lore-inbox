Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbTEQF1w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 01:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbTEQF1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 01:27:51 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:24587
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261247AbTEQF1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 01:27:50 -0400
Date: Fri, 16 May 2003 22:33:01 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: LAD Rocks Linux w/ Hot Tarus Quad SATA, in the pipes!
Message-ID: <Pine.LNX.4.10.10305162220590.23972-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Silicon Image and Seagate "ROMP" the bus and overhead is small.

No size specified, using 1278 MB
Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/sec

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     1278   4096    1  77.41 16.5% 0.930 0.77% 40.92 13.6% 0.852 0.21%
   .     1278   4096    2  67.76 14.9% 0.933 0.50% 38.43 13.1% 0.852 0.27%
   .     1278   4096    4  63.22 13.8% 0.938 0.42% 37.05 12.5% 0.857 0.31%
   .     1278   4096    8  59.11 13.2% 0.963 0.46% 36.01 12.1% 0.862 0.30%

File './Bonnie.3990', size: 1073741824, volumes: 1
Writing with putc()...  done:  15337 kB/s  99.5 %CPU
Rewriting...            done:  21097 kB/s   6.9 %CPU
Writing intelligently...done:  63036 kB/s  14.9 %CPU
Reading with getc()...  done:  11821 kB/s  85.2 %CPU
Reading intelligently...done: 106472 kB/s  11.8 %CPU
Seeker 1...Seeker 2...Seeker 3...start 'em...done...done...done...
              ---Sequential Output (nosync)--- ---Sequential Input-- --Rnd Seek-
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --04k (03)-
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU /sec %CPU
       1*1024 15337 99.5 63036 14.9 21097  6.9 11821 85.2 106472 11.8 286.9  1.1

SiI3114 Serial ATA: IDE controller at PCI slot 00:04.0
SiI3114 Serial ATA: chipset revision 1
SiI3114 Serial ATA: not 100% native mode: will probe irqs later
    ide3: BM-DMA at 0x1440-0x1447, BIOS settings: hdg:pio, hdh:pio
    ide4: BM-DMA at 0x1448-0x144f, BIOS settings: hdi:pio, hdj:pio
hdg: ST3120026AS, ATA DISK drive
blk: queue c031aae4, I/O limit 4095Mb (mask 0xffffffff)
hdi: ST3120026AS, ATA DISK drive
blk: queue c031af30, I/O limit 4095Mb (mask 0xffffffff)
ide3 at 0x1480-0x1487,0x1476 on irq 10
ide4 at 0x1478-0x147f,0x1472 on irq 10

This is a quad channel card and is running in compatibility mode!

Andre Hedrick
LAD Storage Consulting Group

