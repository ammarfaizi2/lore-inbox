Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbSJUUqf>; Mon, 21 Oct 2002 16:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261663AbSJUUqf>; Mon, 21 Oct 2002 16:46:35 -0400
Received: from 205-158-62-55.outblaze.com ([205.158.62.55]:7174 "HELO
	ws1-3.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261660AbSJUUqe>; Mon, 21 Oct 2002 16:46:34 -0400
Message-ID: <20021021205234.22237.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Lee Chin" <leechin@mail.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 21 Oct 2002 15:52:34 -0500
Subject: random failure mounting root fs
X-Originating-Ip: 66.123.16.74
X-Originating-Server: ws1-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm have an entire self-installing app on a bootable cd created using mkisofs.  I use isolinux bootloader to boot from cd with root=/dev/hda (my cdrom drive).  Sometimes the process works fine, root is mounted and INIT starts up.  Others I get this

attempt to access beyond end of device
03:00: rw=0, want=33, limit=2
isofs_read_super: bread failed, dev=03:00, iso_blknum=16, block=32
Kernel panic: VFS: Unable to mount root fs on 03:00

I am not understanding why I would get such a random failure.  Does this have to do with the CDROM drive speed?  Is it preventable?

mkisofs v1.13
isolinux v1.76
2.2 and 2.4 kernels

Thanks
Lee

-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

