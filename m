Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265367AbUBBMAV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 07:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265467AbUBBMAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 07:00:21 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:48901 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S265367AbUBBMAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 07:00:18 -0500
Date: Mon, 2 Feb 2004 13:01:20 +0100
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problem with IDE taskfile
Message-ID: <20040202120120.GC570@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :))

    In my logs I have the following message:

<28>Feb  2 12:18:41 kernel: hda: ST340016A, ATA DISK drive
<28>Feb  2 12:18:41 kernel: hdb: ST34310A, ATA DISK drive
<28>Feb  2 12:18:41 kernel: blk: queue c02d0020, I/O limit 4095Mb (mask 0xffffffff)
<28>Feb  2 12:18:41 kernel: blk: queue c02d015c, I/O limit 4095Mb (mask 0xffffffff)
[...]
<28>Feb  2 12:18:41 kernel: hda: attached ide-disk driver.
<28>Feb  2 12:18:41 kernel: hda: host protected area => 1
<30>Feb  2 12:18:41 kernel: hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63, UDMA(100)
<28>Feb  2 12:18:41 kernel: hdb: attached ide-disk driver.
<28>Feb  2 12:18:41 kernel: hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
<28>Feb  2 12:18:41 kernel: hdb: task_no_data_intr: error=0x04 { DriveStatusError }
<30>Feb  2 12:18:41 kernel: hdb: 8420832 sectors (4311 MB) w/512KiB Cache, CHS=524/255/63, UDMA(33)

    The problem is that message from function 'task_no_data_intr'.
What can be the problem? Should I worry about it? Is the drive
damaged?

    I've tested with another hard disk from the same time (the same
model but 3GB) and the same messages appear. They doesn't appear with
a disk of 10GB, same brand, a bit newer than the other two. And
obviously, it doesn't happen with the 40GB disk which is my hda...

    Thanks a lot in advance.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
