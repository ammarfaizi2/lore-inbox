Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132106AbRAHCg4>; Sun, 7 Jan 2001 21:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135621AbRAHCgq>; Sun, 7 Jan 2001 21:36:46 -0500
Received: from web11904.mail.yahoo.com ([216.136.172.188]:44808 "HELO
	web11904.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132106AbRAHCg2>; Sun, 7 Jan 2001 21:36:28 -0500
Message-ID: <20010108023627.9279.qmail@web11904.mail.yahoo.com>
Date: Sun, 7 Jan 2001 18:36:27 -0800 (PST)
From: Barry Wu <wqb123@yahoo.com>
Subject: How to boot linux kernel from floppy
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

I am new to this maillist. I want to boot my system
from a single floppy. If I use 1.44MB, the space
is too small. So I format my floppy to 1.6MB.
I do the following things,

#fdformat /dev/fd0H1600
#cp /usr/src/linux/arch/i386/boot/zImage /dev/fd0
#rdev /dev/fd0 /dev/fd0
#rdev -r /dev/fd0 49552

When I boot from floppy, the console print:
Loading...........
But then not print other things, then system
reboot again.
I read arch/i386/boot/bootsect.S file and find
no support for 1.6MB floppy. How can I support
this floppy in kernel? 
If someone knows, please help me.
Thanks in advance!

Qingbo

__________________________________________________
Do You Yahoo!?
Yahoo! Photos - Share your holiday photos online!
http://photos.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
