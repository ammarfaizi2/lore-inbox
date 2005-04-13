Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVDMSx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVDMSx2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 14:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVDMSx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 14:53:28 -0400
Received: from ns2.protei.ru ([195.239.28.26]:52960 "EHLO mail.protei.ru")
	by vger.kernel.org with ESMTP id S261153AbVDMSxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 14:53:25 -0400
Message-ID: <425D6A97.9020300@protei.ru>
Date: Wed, 13 Apr 2005 22:53:11 +0400
From: Nickolay <nickolay@protei.ru>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: initrd support in 2.6 kernels
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.500003, version=0.92.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Guys!

I has initrd, that nice loaded by all 2.4 kernels.
But 2.6.9 kernel has some difference in loading initrd(as i discovered).
This warning produced by kernel on boot:

...SKIP...
Kernel command line: console=ttyS0,115200 root=/dev/ram0 
initrd=0x00800000,32M
...SKIP...
checking if image is initramfs...it isn't (ungzip failed); looks like an 
initrd
Freeing initrd memory: 32768K
... SKIP...
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
...SKIP...
RAMDISK: Couldn't find valid RAM disk image starting at 0.
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(1,0)


Maybe troubles in kernel command line? But this command line work fine 
on 2.4 kernels.

