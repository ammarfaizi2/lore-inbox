Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSFYVNJ>; Tue, 25 Jun 2002 17:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315921AbSFYVNI>; Tue, 25 Jun 2002 17:13:08 -0400
Received: from noc.mainstreet.net ([207.5.0.45]:19730 "EHLO noc.mainstreet.net")
	by vger.kernel.org with ESMTP id <S315919AbSFYVNH>;
	Tue, 25 Jun 2002 17:13:07 -0400
From: devnull@adc.idt.com
Date: Tue, 25 Jun 2002 17:13:05 -0400 (EDT)
X-X-Sender: <ram@bom.adc.idt.com>
Reply-To: <devnull@adc.idt.com>
To: <linux-kernel@vger.kernel.org>
Subject: ramfs/ramdisk.
Message-ID: <Pine.GSO.4.31.0206251701200.3694-100000@bom.adc.idt.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I am trying to understand the differences between ramfs and ramdisk, and
also trying to use ramfs.

I am running 2.4.13-ac8.

I do a mount -t ramfs none /tmp/tmpfs

Then use dd to create a file, of size 500M.
do a df, and %Use is 49%(machine has 2G) so i guess default size of
"ramfs" fs will be half of that, 1G.

But when i delete the file. df doesnt show %Use to be 0%.

du -sk doesnt either.

Not sure what is going on.

Cant the utilization of the ramfs be changed.

Also, from fs/ramfs/inode.c

"* NOTE! This filesystem is probably most useful
 * not as a real filesystem, but as an example of
 * how virtual filesystems can be written.
"

1. Can i use ramfs for any practical purposes at all ?


2. I was hoping to create a few ram disks, mount them as swaps on Sun
   machines(so i dont have to buy their expensive memory) and run big
   simulations. (agreed might not be screaming over NFS)


Also, some articles talk about using ramfs when on a webserver. So it
ramfs mostly for read-only stuff rather than read-write.

Thanks,

Regards.

/dev/null

devnull@adc.idt.com


