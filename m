Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129627AbRAFTNC>; Sat, 6 Jan 2001 14:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130510AbRAFTMm>; Sat, 6 Jan 2001 14:12:42 -0500
Received: from ascc.artsci.wustl.edu ([128.252.93.1]:51953 "EHLO
	ascc.artsci.wustl.edu") by vger.kernel.org with ESMTP
	id <S129627AbRAFTMb>; Sat, 6 Jan 2001 14:12:31 -0500
Date: Sat, 6 Jan 2001 13:12:26 -0600 (CST)
From: "Rodney M. Jokerst" <rmjokers@artsci.wustl.edu>
To: linux-kernel@vger.kernel.org
Subject: Screen blanking with 2.4 and vfat
Message-ID: <Pine.SOL.3.96.1010106130641.29119D-100000@ascc.artsci.wustl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have been using linux for a while now and I have noticed, over the past
few months, that with the 2.4 test series and 2.3 series of kernels, that
I have been having problems with what may be the vfat file system driver.
Whenever I am running one of these kernels and I do some sort of large
file transfer operation from one of my ext2 partitions to my windows
(vfat) partition, I get strange behavior in X.  If and only if I am
running X, the screen immediately goes blank and remains blank until I
move the mouse.  Upon doing so, it continues to go blank unless I keep the
mouse in constant motion.  It is almost as if I have the blank screeen set
up to start at 0 seconds or something.  This behavior continues after the
file transfer has completed and the only solution I have found to restore
X functionality is to reboot the computer.  I have noted this behavior in
most of the 2.4 test kernels and most recently in the 2.4.0 kernel.  I
dont recall witnessing this behavior in the 2.2 series.  I do have a VIA
KA-7 motherboard, AMD Athlon 650 processor, and the following hdparm
settings:

hdparm -c 1 -d 1 -k 1 -m 8 -u 1 /dev/hda

If there is any other information that I can supply you with that might
help you in understanding this problem, please let me know.  I have
attempted to contact the maintainer of the vfat driver listed in the
kernel documentation, but the email address is no longer active.  Please
send me a reply personally because I am not currently on the mailing list.

thanks,

Rodney M Jokerst

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
