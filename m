Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265713AbSKFHrh>; Wed, 6 Nov 2002 02:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265995AbSKFHrh>; Wed, 6 Nov 2002 02:47:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5844 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265713AbSKFHrg>;
	Wed, 6 Nov 2002 02:47:36 -0500
Date: Wed, 6 Nov 2002 08:54:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.46 ext3 errors
Message-ID: <20021106075406.GC1137@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Doing a kernel compile, the file system suddenly turned read-only.
Following messages appeared in log:

EXT3-fs error (device ide1(22,1)): ext3_new_inode: Free inodes count corrupted in group 688 Aborting journal on device ide1(22,1).
ext3_new_inode: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device ide1(22,1)) in ext3_new_inode: Journal has aborted
EXT3-fs error (device ide1(22,1)) in ext3_create: Journal has aborted ext3_abort called.
EXT3-fs abort (device ide1(22,1)): ext3_journal_start: Detected aborted journal
Remounting filesystem read-only

-- 
Jens Axboe

