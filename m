Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750909AbWFEKo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWFEKo0 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 06:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWFEKo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 06:44:26 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:30858 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750908AbWFEKo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 06:44:26 -0400
Date: Mon, 5 Jun 2006 12:43:50 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: plougher@users.sourceforge.net
Subject: squashfs size in statfs
Message-ID: <Pine.LNX.4.61.0606051243100.579@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,


# l /mnt
total 36293
drwxr-xr-x   2 root root       20 Jun  5 11:50 .
drwxr-xr-x  31 root root     4096 Jun  5  2006 ..
-rw-r--r--   1 root root 37158912 Jun  5 11:06 mem
# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/shm/sc.sqfs         26688     26688         0 100% /mnt
# l sc.sqfs
-rwx------  1 jengelh users 27279360 Jun  5 11:50 sc.sqfs

I think statfs() should show the uncompressed size, no?



Jan Engelhardt
-- 
