Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264364AbRFHVtE>; Fri, 8 Jun 2001 17:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264371AbRFHVsz>; Fri, 8 Jun 2001 17:48:55 -0400
Received: from rumor.cps.intel.com ([192.102.198.242]:42997 "EHLO
	rumor.cps.intel.com") by vger.kernel.org with ESMTP
	id <S264364AbRFHVsr>; Fri, 8 Jun 2001 17:48:47 -0400
Message-ID: <9319DDF797C4D211AC4700A0C96B7C9404AC2011@orsmsx42.jf.intel.com>
From: "Raj, Ashok" <ashok.raj@intel.com>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: mkinitrd errors...
Date: Fri, 8 Jun 2001 14:48:27 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Missed the command line in earlier mail....


ashokr

-----Original Message-----
From: Raj, Ashok [mailto:ashok.raj@intel.com]
Sent: Friday, June 08, 2001 1:08 PM
To: Linux-Kernel (E-mail)
Subject: mkinitrd errors...


Hello.

I have a need to have some drivers pre-loaded before the scsi adapter driver
is loaded.

I followed the usage and i got some errors which iam attaching below in this
mail.

If someone can give me a way to get this to work that would be awesome!!!

please reply back to me..

1. Is the size of the ramdisk limited? if so to what, and how can we
increase the size of the ramdisk created?

# mkinitrd --preload 82808XA xx.img 2.4.2-2
tar: ./lib/82808XA.o: Wrote only 3584 of 10240 bytes
tar: Skipping to next header
tar: ./lib/sd_mod.o: Wrote only 0 of 10240 bytes
tar: Skipping to next header
tar: ./bin/nash: Wrote only 0 of 10240 bytes
tar: Skipping to next header
tar: ./sbin/: Cannot mkdir: No space left on device
tar: ./sbin/bin: Cannot open: No such file or directory
tar: ./sbin/modprobe: Cannot create symlink to `/bin/nash': No such file or
dire
ctory
tar: ./etc/: Cannot mkdir: No space left on device
tar: ./dev/: Cannot mkdir: No space left on device
tar: ./dev/console: Cannot mknod: No such file or directory
tar: ./dev/null: Cannot mknod: No such file or directory
tar: ./dev/ram: Cannot mknod: No such file or directory
tar: ./dev/systty: Cannot mknod: No such file or directory
tar: ./dev/tty1: Cannot mknod: No such file or directory
tar: ./dev/tty2: Cannot mknod: No such file or directory
tar: ./dev/tty3: Cannot mknod: No such file or directory
tar: ./dev/tty4: Cannot mknod: No such file or directory
tar: ./loopfs/: Cannot mkdir: No space left on device
tar: ./linuxrc: Wrote only 0 of 10240 bytes
tar: Error exit delayed from previous errors


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

