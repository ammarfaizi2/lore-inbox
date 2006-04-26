Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWDZJPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWDZJPz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 05:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWDZJPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 05:15:55 -0400
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:5074 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751219AbWDZJPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 05:15:54 -0400
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [git patch] fuse fixes
Message-Id: <E1FYg7Q-00013Z-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 26 Apr 2006 11:15:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I've addressed the comments from the previous submission:

  - Added proper commit message to revert
  - Fixed typo in sysfs.txt

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
      [fuse] fix deadlock between fuse_put_super() and request_end(), try #2
      [fuse] fix race between checking and setting file->private_data
      [doc] add paragraph about 'fs' subsystem to sysfs.txt

