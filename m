Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275020AbRIYOcm>; Tue, 25 Sep 2001 10:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275021AbRIYOcd>; Tue, 25 Sep 2001 10:32:33 -0400
Received: from conx.aracnet.com ([216.99.200.135]:39360 "HELO cj90.in.cjcj.com")
	by vger.kernel.org with SMTP id <S275020AbRIYOcY>;
	Tue, 25 Sep 2001 10:32:24 -0400
Message-ID: <3BB0958B.8030703@cjcj.com>
Date: Tue, 25 Sep 2001 07:32:43 -0700
From: cj <cj@cjcj.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.10 etherboot initrd init= problem
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.4.10 etherbooting via mknbi-linux panics with:
....
Net4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory 3084k freed
VFS:: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 276k freed
Kernel panic: No init found.  Try passing init= option to kernel.

These kernel command lines work with 2.4.9 but not 2.4.10:
auto rw root=/dev/ram ramdisk_size=8192
auto rw root=/dev/ram init=/sbin/init ramdisk_size=8192
auto rw root=/dev/ram init=/bin/ash ramdisk_size=8192


