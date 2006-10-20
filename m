Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992583AbWJTJQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992583AbWJTJQL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 05:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWJTJQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 05:16:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56721 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932236AbWJTJQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 05:16:09 -0400
Subject: [GFS2 & DLM] Pull request
From: Steven Whitehouse <swhiteho@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 20 Oct 2006 10:24:18 +0100
Message-Id: <1161336258.27980.201.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please consider pulling the following changes from the GFS2 -fixes git tree,

Steve.

-----------------------------------------------------------------------------------------
The following changes since commit ce9e3d9953c8cb67001719b5516da2928e956be4:
  Linus Torvalds:
        Merge branch 'ubuntu-updates' of master.kernel.org:/.../bcollins/ubuntu-2.6

are found in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-fixes.git

Adrian Bunk:
      [GFS2] fs/gfs2/dir.c:gfs2_dir_write_data(): remove dead code
      [GFS2] fs/gfs2/ops_fstype.c:gfs2_get_sb_meta(): remove unused variable
      [GFS2] fs/gfs2/dir.c:gfs2_dir_write_data(): don't use an uninitialized variable
      [GFS2] fs/gfs2/ops_fstype.c:fill_super_meta(): fix NULL dereference
      [GFS2] gfs2_dir_read_data(): fix uninitialized variable usage

Al Viro:
      [GFS2] gfs2 endianness bug: be16 assigned to be32 field

Patrick Caulfield:
      [DLM] fix iovec length in recvmsg

Steven Whitehouse:
      [GFS2] Fix bmap to map extents properly

 fs/dlm/lowcomms.c     |    1 +
 fs/gfs2/bmap.c        |   13 +++++++------
 fs/gfs2/bmap.h        |    2 +-
 fs/gfs2/dir.c         |   10 +++-------
 fs/gfs2/log.c         |    6 ++++--
 fs/gfs2/ops_address.c |    6 +++---
 fs/gfs2/ops_fstype.c  |    7 ++-----
 fs/gfs2/quota.c       |    5 +++--
 fs/gfs2/recovery.c    |    5 +++--
 9 files changed, 27 insertions(+), 28 deletions(-)


