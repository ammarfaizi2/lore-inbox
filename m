Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSEPQ4q>; Thu, 16 May 2002 12:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314451AbSEPQ4p>; Thu, 16 May 2002 12:56:45 -0400
Received: from pc-62-31-66-178-ed.blueyonder.co.uk ([62.31.66.178]:50051 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S313711AbSEPQ4n>; Thu, 16 May 2002 12:56:43 -0400
Date: Thu, 16 May 2002 17:56:37 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: ext3-users@redhat.com, ext2-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>, Andrew Morton <akpm@zip.com.au>,
        Andreas Dilger <adilger@home.com>
Subject: Ext3-0.9.18 available
Message-ID: <20020516175637.A21624@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ext3-0.9.18 is now available for 2.4.19-pre8.  Some of the fixes in
this release are already in the 2.4.19-pre8, but there are some
important new fixes in the patch and users are encouraged to upgrade.
This release fixes all known outstanding bug reports.

The full patch against linux-2.4.19-pre8, and a tarball of the
individual fixes in this patch set, is now propagating to

	ftp://ftp.*.kernel.org/pub/linux/kernel/people/sct/ext3/v2.4/

The full list of changes is included below.

Cheers,
 Stephen

---
ChangeLog:

* Speed up MS_SYNC writes
* Set up kjournald to be parented under init properly
* config: ext3 is no longer experimental
* fix i_blocks getting inconsistent after disk full
* speed up fsyncs in non-journaled data modes a little
* don't consider ENOSPC a fatal error when allocating an inode
* fix LVM snapshot deadlock
* fix "dump corrupts filesystems" core VFS bug
* fix over-zealous ext3 complaint about locked buffers
* fix very rare buffer leak
* fix O_SYNC
* fix tiny race where a buffer could be written to disk too soon
