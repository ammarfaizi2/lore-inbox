Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264714AbUEJOcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264714AbUEJOcT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 10:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264718AbUEJOcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 10:32:19 -0400
Received: from smtpq1.home.nl ([213.51.128.196]:15794 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S264714AbUEJOcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 10:32:04 -0400
Message-ID: <409F9201.3000302@keyaccess.nl>
Date: Mon, 10 May 2004 16:30:25 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd.Knochenhauer@t-online.de
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [Fwd: Me too : Linux 2.6.6 "IDE cache-flush at shutdown fixes"]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernd.

Fowarded this onto lkml. Note, though, that you can post to lkml without 
being subscribed. Anyways, seems it's then not just the 8M cache drives.

-------- Original Message --------
Subject: Me too : Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Date: Mon, 10 May 2004 16:25:34 +0200
From: Bernd.Knochenhauer@t-online.de (Bernd Knochenhauer)
To: Rene Herman <rene.herman@keyaccess.nl>


Just wanted to let you know I'm having the exact same problem with a
Maxtor 6Y120L0.

Perhaps you can relay this to the linux-kernel mailinglist since I'm
not on there.

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SiI680: IDE controller at PCI slot 0000:02:0d.0
SiI680: chipset revision 2
SiI680: BASE CLOCK == 133
SiI680: 100% native mode on irq 217
     ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
     ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 6Y120L0, ATA DISK drive
hdb: SAMSUNG SP1604N, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0xf8816480-0xf8816487,0xf881648a on irq 217
hdc: Maxtor 6Y120L0, ATA DISK drive
ide1 at 0xf88164c0-0xf88164c7,0xf88164ca on irq 217
hda: max request size: 64KiB
hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, 
UDMA(133)
  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: Write Cache FAILED Flushing!
hdb: max request size: 64KiB
hdb: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63, 
UDMA(100)
  /dev/ide/host0/bus0/target1/lun0: p1 p2
hdc: max request size: 64KiB
hdc: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, 
UDMA(133)
  /dev/ide/host0/bus1/target0/lun0: p1 p2 p3
hdc: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: task_no_data_intr: error=0x04 { DriveStatusError }
hdc: Write Cache FAILED Flushing!


