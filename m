Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265862AbSIRJgh>; Wed, 18 Sep 2002 05:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265866AbSIRJgh>; Wed, 18 Sep 2002 05:36:37 -0400
Received: from mx0.gmx.net ([213.165.64.100]:57864 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S265862AbSIRJgg>;
	Wed, 18 Sep 2002 05:36:36 -0400
Date: Wed, 18 Sep 2002 11:41:32 +0200 (MEST)
From: Eric Tchepannou <tcheer@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Question about the dd command
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0014751070@gmx.net
X-Authenticated-IP: [193.155.23.5]
Message-ID: <18955.1032342092@www26.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am trying to build a boot image in order to boot from a CD device. I have
already created all the parts ( Kernel, Lilo and Rootfs ) and try to bring
them together. I first copied it on a floppy in order to see wether I could
boot from it and  it worked. In the Linux-Bootdisk-HOWTO It is said that on
should transfer the rootfs with the following command

dd if=rootfs of=/dev/fd0 bs=1k seek=KERNEL_BLOCKS 

I calculated the KERNEL_BLOCK value in my case and applied the command. It
is supposed to transfer the rootfs file into the same floppy containing the
kernel. I am surprised to see that with a ls-command the rootfs.gz is invisible
on the floppy, though the boot process from floppy works properly. Later i
created an image of the floppy ( dd if=/dev/fd0 of=boot.img bs=10k count=144
as in the Linux-Bootdisk-HOWTO ), created an iso file from it with mkisofs and
copied it on CD. Now I can't boot the image from this CD!

I hope I am in the appropriate ML, I hope someone can help me with this
issue,

Regards.

Eric

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

