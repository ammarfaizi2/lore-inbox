Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267349AbSLESqy>; Thu, 5 Dec 2002 13:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267354AbSLESqy>; Thu, 5 Dec 2002 13:46:54 -0500
Received: from gbmail.cc.gettysburg.edu ([138.234.4.100]:14502 "EHLO
	gettysburg.edu") by vger.kernel.org with ESMTP id <S267349AbSLESqy>;
	Thu, 5 Dec 2002 13:46:54 -0500
To: linux-kernel@vger.kernel.org
Subject: attempt to access beyond end of device
Message-Id: <E18K18h-0005Ru-00@perseus.homeunix.net>
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Date: Thu, 05 Dec 2002 13:54:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.20-ac1, Debian testing.

While running `updatedb --localuser=nobody 2>/dev/null`, I receive several pages of the following message:

Dec  5 13:43:25 perseus kernel: Directory sread (sector 0x18) failed
Dec  5 13:43:25 perseus kernel: attempt to access beyond end of device
Dec  5 13:43:25 perseus kernel: 02:00: rw=0, want=12, limit=4

Some of the numbers are different sometimes.  I can post my syslog if anyone is interested, but I'm not even sure if this is a kernel issue.

Disk configuration is as follows:

pryzbyj@perseus:~$ mount
/dev/hda1 on / type ext3 (rw,errors=remount-ro)
proc on /proc type proc (rw)
/dev/hda3 on /home type ext3 (rw)
/dev/hda4 on /usr/src type ext3 (rw)

Justin
