Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbTLYCjz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 21:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbTLYCjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 21:39:55 -0500
Received: from web80710.mail.yahoo.com ([66.163.170.67]:15525 "HELO
	web80710.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264265AbTLYCjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 21:39:53 -0500
Message-ID: <20031225023952.32560.qmail@web80710.mail.yahoo.com>
Date: Wed, 24 Dec 2003 18:39:52 -0800 (PST)
From: Elwin Eliazer <elwinietf@yahoo.com>
Subject: Kernel panic while upgrading from 2.4.20-6 to 2.4.22
To: linux-kernel@vger.kernel.org
Cc: elwinietf@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am getting kernel panic, when i try to upgrade my
kernel from 2.4.20-6 to 2.4.22.

This is on a Compaq desktop, and the 2.4.20-6 is what
i got as kernel from Redhat 9.0 CDs. I use GRUB
loader, and there is no other OS in the system.

Following are the steps i took, based on the
/usr/src/linux-2.4.20-6/README file.

Downloaded the linux-2.4.22.tar.gz file into /usr/src,
and untarred, which created /usr/src/linux-2.4.22.

# cd /usr/src/linux-2.4.22
# make config
# make dep
# make bzImage
# make modules
# make modules_install
# make install

No error came in any of these steps, and i could see
additional entries added for GRUB, and the boot image
appropriately copied into /boot

After these, when i reboot, i could see the additional
entry for 2.4.22 shown in GRUB menu. When i select
that and enter, following are some of the final
messages i get, saying kernel panic.

ds: no socket drivers loaded!
VFS: Cannot open root device "LABEL=/" or 00:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 00:00

Not sure if i am missing some step, or missing to read
some already written document.

Your help will be appreciated.

Thanks,
Elwin.


__________________________________
Do you Yahoo!?
New Yahoo! Photos - easier uploading and sharing.
http://photos.yahoo.com/
