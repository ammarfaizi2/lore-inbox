Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbSLOUUg>; Sun, 15 Dec 2002 15:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbSLOUUg>; Sun, 15 Dec 2002 15:20:36 -0500
Received: from packet.digeo.com ([12.110.80.53]:21192 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262528AbSLOUUf>;
	Sun, 15 Dec 2002 15:20:35 -0500
Message-ID: <3DFCE5E7.A8BE82B4@digeo.com>
Date: Sun, 15 Dec 2002 12:28:23 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: ext3 updates for 2.4.20
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Dec 2002 20:28:23.0672 (UTC) FILETIME=[83F55780:01C2A478]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There are three patches at

	http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.20/

sync_fs.patch:
	Fix the ext3 data=journal data-loss-on-unmount bug

sync_fs-fix.patch:
	Fix sync_fs.patch to not deadlock the fs when running
	`mount -o remount' against a heavily loaded filesystem.

ext3-use-after-free.patch
	Fix a use-after-free bug which can cause memory corruption
	if the filesystem runs out of space, or runs out of free
	inodes.


Instructions for downloading and applying these patches are at

	http://www.zip.com.au/~akpm/linux/ext3/
