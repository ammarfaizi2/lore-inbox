Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUAJIVn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 03:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265238AbUAJIVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 03:21:43 -0500
Received: from [216.127.68.117] ([216.127.68.117]:24973 "HELO 216.127.68.117")
	by vger.kernel.org with SMTP id S265237AbUAJIVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 03:21:41 -0500
Message-ID: <3FFFB60C.9010309@meerkatsoft.com>
Date: Sat, 10 Jan 2004 17:21:32 +0900
From: Alex <alex@meerkatsoft.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Cannot boot after new Kernel Build
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am trying to build a new kernel but what ever version 2.4.24, 2.6.0,
2.6.1 i am trying to build I come across the same problem.

when doing a "make install" i get the following error.

/dev/mapper/control: open failed: No such file or directlry
Is device-mapper driver missing from kernel?
Comman failed.

I have installed the lates packages
device mapper 1.00.07
initscripts 7.28.1
modutils, lvm2.2.00.08
mkinitrd-3.5.15.1-2

If I just ignore the message and try to boot the machine with the new
kernel then I get a Kernel Panic.

VFS: Cannot open root device "LABEL=/" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic: VFS: Unapble to mount root fs on unknown-block(0,0).

The boot command in grub is
root (hd0,0)
kernel /vmlinuz-2.6.1 ro root=LABEL=/ hdc=ide-scsi
initrd /initrd-2.6.1.img

It is basically the same (except the version) as I use for 2.4.20-28 so
I assume the label is correct.

I saw quite a few messages of similar type but no real answer to the
problem. Any Ideas what it could be ?  I am using RH9.0

Thanks
Alex






