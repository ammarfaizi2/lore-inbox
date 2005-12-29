Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbVL2LiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbVL2LiN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 06:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbVL2LiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 06:38:13 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:31170 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP id S932585AbVL2LiN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 06:38:13 -0500
Message-ID: <43B3CA9E.7000804@voltaire.com>
Date: Thu, 29 Dec 2005 13:38:06 +0200
From: Erez Zilber <erezz@voltaire.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: cannot boot 2.6.15-rc6 on Opteron machine
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 29 Dec 2005 11:38:07.0508 (UTC) FILETIME=[56927D40:01C60C6C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've downloaded kernel 2.6.15-rc6 (had the same problem with rc7) and 
built it on RHAS 4:
make
make modules
make modules_install
make install

When I did that on an Opteron machine, after rebooting and selecting the 
2.6.15-rc6 entry in the grub menu, I get the following:

root (hd0,0)
Filesystem type is ext2fs, partition type 0x83
kernel /vmlinuz-2.6.15-rc6 ro root=/dev/VolGroup00/LogVol00 rhgb quiet 
console=ttyS0,115200 console=tty0
[Linux-bzimage, setup=0x1400, size=0x1dfa8c]
initrd /initrd--2.6.15-rc6.img
[Linux-initrd @ 0x37f20000, 0xcff3f bytes]

Uncompressing Linux... Ok, booting the kernel.
Kernel panic - not syncing: VFS: unable to mount root fs on 
unknown-block(0,0)

I made sure that ext2 is compiled with the kernel (not as a module).

When I do the same on an emt64 machine, everything works ok. Any idea?

Thanks
-- 

____________________________________________________________

Erez Zilber | 972-9-971-7689

Software Engineer, Storage Team

Voltaire – _The Grid Backbone_

__

www.voltaire.com <http://www.voltaire.com/>


