Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWCFWgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWCFWgR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWCFWgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:36:17 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:7068 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932413AbWCFWgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:36:15 -0500
Date: Mon, 6 Mar 2006 14:36:00 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [git patches] ocfs2 updates
Message-ID: <20060306223600.GC27280@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'upstream-linus' branch of
git://oss.oracle.com/home/sourcebo/git/ocfs2.git

to receive the following updates:

 fs/ocfs2/alloc.c             |   88 ++++++++--------
 fs/ocfs2/aops.c              |   18 +--
 fs/ocfs2/buffer_head_io.c    |   11 +-
 fs/ocfs2/cluster/heartbeat.c |   38 +++----
 fs/ocfs2/cluster/masklog.h   |   10 -
 fs/ocfs2/dcache.c            |    9 -
 fs/ocfs2/dir.c               |   42 +++----
 fs/ocfs2/dlm/dlmast.c        |   22 ++--
 fs/ocfs2/dlm/dlmcommon.h     |   21 +++
 fs/ocfs2/dlm/dlmconvert.c    |   11 +-
 fs/ocfs2/dlm/dlmdebug.c      |   18 ++-
 fs/ocfs2/dlm/dlmlock.c       |   14 ++
 fs/ocfs2/dlm/dlmmaster.c     |  227 ++++++++++++++++++++++++++++++++++++-------
 fs/ocfs2/dlm/dlmrecovery.c   |   50 +++++----
 fs/ocfs2/dlm/dlmunlock.c     |   11 +-
 fs/ocfs2/dlmglue.c           |  101 +++++++++----------
 fs/ocfs2/export.c            |   24 ++--
 fs/ocfs2/extent_map.c        |   34 +++---
 fs/ocfs2/file.c              |   42 ++++---
 fs/ocfs2/inode.c             |  116 +++++++++++----------
 fs/ocfs2/journal.c           |   27 ++---
 fs/ocfs2/localalloc.c        |   17 +--
 fs/ocfs2/namei.c             |   79 +++++++-------
 fs/ocfs2/ocfs2.h             |   12 +-
 fs/ocfs2/suballoc.c          |   72 +++++++------
 fs/ocfs2/super.c             |   14 +-
 fs/ocfs2/super.h             |    8 +
 fs/ocfs2/uptodate.c          |   40 ++++---
 fs/ocfs2/vote.c              |   63 ++++++-----
 29 files changed, 749 insertions(+), 490 deletions(-)

Kurt Hackel:
      ocfs2: fix hang in dlm lock resource mastery
      ocfs2: dlm recovery fixes
      ocfs2: don't use MLF* in dlm/ files

Mark Fasheh:
      ocfs2: use __attribute__ format
      ocfs2: don't use MLF* in cluster/ files
      ocfs2: don't use MLF* in the file system
      ocfs2: finally remove MLF* macros

A patch file for the changes can also be found at:

http://oss.oracle.com/~mfasheh/ocfs2-update.patch

It wasn't posted in e-mail because the MLF* updates drove the patch size
past the lkml mail size limit.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
