Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131845AbRBDPLa>; Sun, 4 Feb 2001 10:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131844AbRBDPLU>; Sun, 4 Feb 2001 10:11:20 -0500
Received: from zeus.kernel.org ([209.10.41.242]:61903 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131789AbRBDPLK>;
	Sun, 4 Feb 2001 10:11:10 -0500
X-Pass-Through: Kazan State University network
Message-ID: <3A7D6BAE.1050700@ksu.ru>
Date: Sun, 04 Feb 2001 17:48:14 +0300
From: Art Boulatov <art@ksu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test10-pre5-reiserfs-3.6.18-acpi-i2c i686; en-US; 0.6) Gecko/20001205
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.4.1] "DEVFS+RAID" not working
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

as I've posted before in [SoftwareRAID in 2.4.1],
I wasn't able to get RAID0 working
with devfs enabled and mounted on /dev.

The problem had gone after I passed devfs=nomount,
and used old device names for configuring/starting raid:

/dev/md0 instead of /dev/md/0
/dev/sda1 instead of /dev/scsi/host0/bus0/target0/lun0/part1
and so on.

Why?
Is that the way it is supposed to be with raid?
Why can't I just use devfs naming scheme,
and mount it on boot?
For some reason I wouldn't want those old device files under /dev.

Thanks in advance,
Art.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
