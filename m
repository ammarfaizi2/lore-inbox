Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129473AbQJaTZf>; Tue, 31 Oct 2000 14:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129662AbQJaTZ0>; Tue, 31 Oct 2000 14:25:26 -0500
Received: from cmr2.ash.ops.us.uu.net ([198.5.241.40]:48022 "EHLO
	cmr2.ash.ops.us.uu.net") by vger.kernel.org with ESMTP
	id <S129473AbQJaTZN>; Tue, 31 Oct 2000 14:25:13 -0500
Message-ID: <39FF1CB5.99594ACF@uu.net>
Date: Tue, 31 Oct 2000 14:25:41 -0500
From: Alex Deucher <adeucher@UU.NET>
Organization: UUNET
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
Newsgroups: comp.os.linux.setup
To: linux-kernel@vger.kernel.org
Subject: 2.4test kernels, hpt366, sg devices
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a abit BP6 (I know this board has a bad wrap), but it has always
worked  well in the past.  I installed a fresh copy of redhat 7.  I
tried the redhat 2.4test kernel and complied several of my own
(2.4test9,10preX).  

Now I realize, that these are beta kernels, but my PC was always rock
solid with 2.3.99 and redhat 6.1.  

Anyway, here are the symptoms:

No matter what 2.4test kernel I boot (self compiled or redhat's), both
hardrives in my PC (one is ext2 other is fat32, both on the hpt366)
start to thrash heavily about 5-6 minutes after boot.  First the ext2
drive and then the fat32 drive.  the drives thrash for about 1-2 minutes
and then stop and don't do it again afer that.  This happens without
fail with no load on the system. I don't remember this ever happening
before.

I think this may also be related to burning CDR's under the recent
2.4test kernels.  When I try and burn a cd with cdrecord or cdrdao using
my SAF 12x burner attached to the adaptec 2940, the burn will start and
then lock the machine hard about 7-10% of the way through the burn.

The 2.3.99 and early 2.4test kernels refused to burn a cd at all when
burning from a ide cdrom to the cdr.  the burn would work fine if it was
from the harddisk, but only up to 4x, at any higher speeds, cdrecord
would either refuse to burn at all complaining about the pre-burn area
or an error in retrying commands, or it would burn the cd about 80%
through and then die due to a buffer underrun.  I know the hardrives can
deliver, The burns work fine under win NT and 98 at any speed.  even in
linux hdparm -tT gives me about 23MB/sec (7200rpm Maxtor) on the ext2
drive and about 15MB/sec (5400rpm WD) on the fat32 drive, both are
ata/66.  

Now, If the machine locks during a burn with the 2.4testpre9/10 kernels
and I reboot it, with these kernels, the computer will lock up during
the fsck dumping a stack trace to the screen, without fail.  if it locks
up under the redhat 2.4 kernel and I reboot with that kernel or reboot
with that kernel after a lock in one of the test9/10 kernels fsck works
fine.

Any ideas are much appreciated,

Thanks,

Alex
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
