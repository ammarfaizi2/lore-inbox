Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbRFATiR>; Fri, 1 Jun 2001 15:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261394AbRFATiI>; Fri, 1 Jun 2001 15:38:08 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:6663 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S261385AbRFATh5>; Fri, 1 Jun 2001 15:37:57 -0400
Date: Fri, 1 Jun 2001 15:38:35 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@vesta.nine.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.5-ac5 locks on ReiserFS umount (ac4 doesn't)
Message-ID: <Pine.LNX.4.33.0106011528070.951-100000@vesta.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm using ReiserFS in the kernel, not as a module. My root filesystem is
ReiserFS. I mounted another ReiserFS partition and then tried to unmount
it. umount hung. sync hung. shutdown hung.

Both umount and sync were shown in the "D" state on Ctrl-ScrollLock.

I reverted to 2.4.5-ac4 and could not reproduce the problem. I saw a
suggestion that it may have to do with module unloading, but in my case
reiserfs is not a module.

Full config file if here:
http://www.red-bean.com/~proski/linux/config

-- 
Regards,
Pavel Roskin

