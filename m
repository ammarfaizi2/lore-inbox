Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752254AbWKFLLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbWKFLLJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 06:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752274AbWKFLLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 06:11:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8403 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752254AbWKFLLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 06:11:06 -0500
Subject: [GFS2 & DLM] Pull request
From: Steven Whitehouse <swhiteho@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 06 Nov 2006 11:13:14 +0000
Message-Id: <1162811594.18219.38.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please consider pulling the following GFS2 & DLM bug fixes,

Steve.

The following changes since commit d1ed6a3ea10aa7b199c434f6ffd1b6761896567a:
  Linus Torvalds:
        Merge master.kernel.org:/.../davem/net-2.6

are found in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-fixes.git

Alexey Dobriyan:
      [GFS2] don't panic needlessly

Patrick Caulfield:
      [DLM] Fix kref_put oops
      [DLM] fix oops in kref_put when removing a lockspace

Steven Whitehouse:
      [GFS2] Fix incorrect fs sync behaviour.
      [GFS2] Fix OOM error handling

 fs/dlm/lockspace.c  |   14 +++++++++++++-
 fs/gfs2/inode.c     |    3 +++
 fs/gfs2/main.c      |    4 ++--
 fs/gfs2/ops_super.c |   44 ++++++++++++++++++++++++++++----------------
 4 files changed, 46 insertions(+), 19 deletions(-)


