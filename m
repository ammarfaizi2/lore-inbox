Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319755AbSILRS7>; Thu, 12 Sep 2002 13:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319756AbSILRS7>; Thu, 12 Sep 2002 13:18:59 -0400
Received: from mail.broadpark.no ([217.13.4.2]:51388 "HELO mail.broadpark.no")
	by vger.kernel.org with SMTP id <S319755AbSILRS6>;
	Thu, 12 Sep 2002 13:18:58 -0400
Message-ID: <3D80CDAF.5B61EB3E@broadpark.no>
Date: Thu, 12 Sep 2002 19:23:59 +0200
From: Helge Hafting <helge.hafting@broadpark.no>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.5.7-dj2 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.34 unable to mount root fs on 09:00 (smp,raid1,devfs,scsi)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.33 works. 2.5.34 and 2.5.34-bk3 won't mount the
root fs.  The root fs is on /dev/md/1, composed
of 2 partitions on different scsi disks.

The RAID-1 setup is autodetected, so it don't look
like a hardware or scsi problem.  Everything seems normal
until the root mount fail and the kernel hangs.  Not
even sysrq works after that.

Helge Hafting
