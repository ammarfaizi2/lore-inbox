Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTJSQ77 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 12:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTJSQ77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 12:59:59 -0400
Received: from conure.mail.pas.earthlink.net ([207.217.120.54]:37600 "EHLO
	conure.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261956AbTJSQ76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 12:59:58 -0400
Subject: Mounting /dev/md0 as root in 2.6.0-test7
From: Harold Martin <cocoadev@earthlink.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1066582732.1108.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 19 Oct 2003 09:58:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, is it possible to mount an md device as root (superblock is
present)?
If not then the rest of this doesn't really matter...

If so, I can't get it to work :(
I pass root=/dev/md0 to the kernl, but I get the "Kernel panic: VFS:
Unable to mount root fs on md0" error.
My setup:
kernel 2.6.0-test7
One drive on each of my two IDE channels (i810 chipset)
RAID 0, set up with raidtools
Using devfs
My FS type (ext2 and ext3), partition type (DOS), and RAID-0 support are
all compiled in (not as modules).

What else do I need to do to be able to mount /dev/md0 as root?

Thanks for your help,
Harold

