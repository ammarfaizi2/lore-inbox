Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267900AbTBVNfy>; Sat, 22 Feb 2003 08:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267901AbTBVNfw>; Sat, 22 Feb 2003 08:35:52 -0500
Received: from catv-50622ca4.bp13catv.broadband.hu ([80.98.44.164]:22788 "HELO
	dap.index") by vger.kernel.org with SMTP id <S267900AbTBVNef>;
	Sat, 22 Feb 2003 08:34:35 -0500
Subject: cmd680 doesn't works fine with 2.4.20
From: Pallai Roland <dap@mail.index.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 22 Feb 2003 14:44:41 +0100
Message-Id: <1045921481.513.22.camel@dap>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

quote from http://www.uwsg.iu.edu/hypermail/linux/kernel/0207.3/0356.html:
 " I just bought a new kouwell udma133+raid (KW-571B) card that has a
cmd680 chip on it. the card detects nicely my HDs, but after when linux
boots I get something like this:
[...]
Jul 23 18:43:28 wk kernel: hde: MAXTOR 4K080H4, ATA DISK drive
Jul 23 18:43:28 wk kernel: hdf: 00MAXTOR 4K080H4, ATA DISK drive
Jul 23 18:43:28 wk kernel: hde: host protected area => 1
Jul 23 18:43:28 wk kernel: hde: 156301488 sectors (80026 MB) w/2000KiB Cache, CHS=155061/16/63, UDMA(100)
Jul 23 18:43:28 wk kernel: hdf: task_no_data_intr: status=0x53 { DriveReady SeekComplete Index Error }
Jul 23 18:43:28 wk kernel: hdf: task_no_data_intr: error=0x04 { DriveStatusError }
Jul 23 18:43:28 wk kernel: hdf: -122814464 sectors (2136142 MB) w/1KiB Cache, CHS=259704/255/63, DMA
 In both cases the SLAVE drive wasnt detected correctly, and after
reported errors. after I tried this out with another card from the same
brand, I tried primary and secondary channel, no luck, I got these same
sypmtoms. all drives worked perfect with promise controllers. the kernel
I used: 2.4.19-rc3-ac3. "


 I've same problem with kernel 2.4.20 on every CMD680-based card from
different manufacturers. big (eg.: Maxtor DiamondMax Plus9 - 120G) slave
drives wasn't works and detected incorrectly _until the first soft
reboot_! after that everything works fine, but not on the first boot..

 driver problem or it's works for anyone??


please cc me,
-- 
  DaP
