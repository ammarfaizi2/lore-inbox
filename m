Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130701AbRAZScE>; Fri, 26 Jan 2001 13:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131894AbRAZSbz>; Fri, 26 Jan 2001 13:31:55 -0500
Received: from web112.mail.yahoo.com ([205.180.60.82]:25357 "HELO
	web112.yahoomail.com") by vger.kernel.org with SMTP
	id <S130701AbRAZSbl>; Fri, 26 Jan 2001 13:31:41 -0500
Message-ID: <20010126183140.17534.qmail@web112.yahoomail.com>
Date: Fri, 26 Jan 2001 10:31:40 -0800 (PST)
From: Paul Powell <moloch16@yahoo.com>
Subject: Undoing chroot?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a linux bootable CD which executes a custom
init.  The job of init is to figure out on which
device the CD is located.  After finding the CD, init
mounts the device and executes a CHROOT to set the
root directory to the CD.

After I'm done I'd like to umount the CD and then
eject it by sending an IOCTL eject command.  But since
I executed a CHROOT I can't umount the CD, umount
complains that the device is busy.

So how do you reverse a CHROOT?

BTW, I use an initrd image and init is a C program,
not a script.

Thanks

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - Buy the things you want at great prices. 
http://auctions.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
