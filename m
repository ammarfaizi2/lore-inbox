Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbTLFTSb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 14:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbTLFTSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 14:18:31 -0500
Received: from web14904.mail.yahoo.com ([216.136.225.56]:47432 "HELO
	web14904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265232AbTLFTSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 14:18:30 -0500
Message-ID: <20031206191829.23188.qmail@web14904.mail.yahoo.com>
Date: Sat, 6 Dec 2003 11:18:29 -0800 (PST)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] FIx  'noexec' behavior
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CC me on replies. I'm not subscribed.

Here's my fstab.

/dev/sda5               /                       ext3    defaults        1 1
/dev/sda1               /boot                   ext3    defaults        1 2
LABEL=/dos              /rh9                    ext3    defaults        1 2
/dev/sda2               swap                    swap    defaults        0 0
/dev/hda3               swap                    swap    defaults        0 0
/dev/cdrom              /mnt/cdrom              udf,iso9660
noauto,owner,kudzu,ro 0 0
/dev/fd0                /mnt/floppy             auto    noauto,owner,kudzu 0 0
none                    /sys                    sysfs   defaults        0 0
tmpfs                   /tmp                    tmpfs   defaults,size=800M 0 0
none                    /dev/pts                devpts  gid=5,mode=620  0 0
none                    /proc                   proc    defaults        0 0
none                    /dev/shm                tmpfs   defaults        0 0
/dev/md0                /home                   ext3    defaults        1 2
/dev/cdrom1             /mnt/cdrom1             udf,iso9660
noauto,owner,kudzu,ro 0 0


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
New Yahoo! Photos - easier uploading and sharing.
http://photos.yahoo.com/
