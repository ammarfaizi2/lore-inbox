Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWDYIfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWDYIfi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWDYIfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:35:38 -0400
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:129 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751059AbWDYIfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:35:37 -0400
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [git patch] fuse fixes
Message-Id: <E1FYJ0r-0006Tv-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 25 Apr 2006 10:35:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull from 'for-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/mszeredi/fuse.git

to receive the following updates:

 Documentation/filesystems/sysfs.txt |    5 ++++
 fs/fuse/dev.c                       |   35 ++++++++++++++++++-------------
 fs/fuse/fuse_i.h                    |   12 ++++++++--
 fs/fuse/inode.c                     |   40 ++++++++++++++++--------------------
 4 files changed, 52 insertions(+), 40 deletions(-)

Miklos Szeredi:
      Revert "[fuse] fix deadlock between fuse_put_super() and request_end()"
      [fuse] fix deadlock between fuse_put_super() and request_end()
      [fuse] fix race between checking and setting file->private_data
      [doc] add paragraph about 'fs' subsystem to sysfs.txt

I'll also be replying to this mail with the actual patches.

Thanks,
Miklos
