Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267261AbTA0Ry5>; Mon, 27 Jan 2003 12:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267263AbTA0Ry5>; Mon, 27 Jan 2003 12:54:57 -0500
Received: from web20405.mail.yahoo.com ([66.163.169.93]:56992 "HELO
	web20417.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267261AbTA0Ry4>; Mon, 27 Jan 2003 12:54:56 -0500
Message-ID: <20030127180414.85643.qmail@web20417.mail.yahoo.com>
Date: Mon, 27 Jan 2003 10:04:14 -0800 (PST)
From: devnetfs <devnetfs@yahoo.com>
Subject: kernel modules and 64-bit kernels  
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[posted this query on kernelnewbies@nl.linux.org earlier]

Hello,

Do kernel modules need to be aware that they are running in a 64-bit
kernel or a 32-bit kernel? 

I guess yes, especially interacting with 32-bit userspace programs.
For e.g. if a 32-bit program (running on a 64-bit kernel) passes a
pointer to the kernel module (via an ioctl), how does the kernel/module
know that its a 32-bit address? the sizeof(pointer) changes in
kernel/userspace in this case. So in the ioctl handler the kernel
modules does how many bytes of copy_from_use() to get the ioctl args?

How should be the modules be written so they work both on 32/64-bit
kernel AND can interact with both 32/64-bit userspace programs in
a 64-bit kernel??

Any links, pointers to relevant HOWTO/docs/source will be very useful.

Thanks,
A.

ps: Please Cc: me the reply. I am not on this mailing list.

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
