Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266613AbUGUWv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUGUWv2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 18:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266766AbUGUWv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 18:51:28 -0400
Received: from adsl-64-164-133-219.dsl.snfc21.pacbell.net ([64.164.133.219]:29912
	"EHLO gghcwest.com") by vger.kernel.org with ESMTP id S266613AbUGUWv1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 18:51:27 -0400
Subject: init_special_inode: bogus imode (37316) means ?
From: "Jeffrey W. Baker" <jwbaker@acm.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1090450285.21477.4.camel@heat>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 21 Jul 2004 15:51:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This useless error popped up in dmesg today on a 2.4.26 SMP x86 host:

EXT2-fs: corrupt root inode, run e2fsck
init_special_inode: bogus imode (37316)
EXT2-fs: corrupt root inode, run e2fsck
init_special_inode: bogus imode (37316)
EXT2-fs: corrupt root inode, run e2fsck

Well that's great, thanks.  What device are we talking about?  Should I
be worried about my data?  None of the storage devices show any errors,
although the machine has been under extreme I/O load for over a week.

This particular host has one internal PATA disk (WDC WD1200JB) attached
via AMD-8111 IDE (rev 03) with an ext2 fs, and two raids of four SATA
disks each, attached via 3Ware controller.  Each RAID has an ext3 fs.

Any advice about how to proceed would be appreciated.

-jwb

