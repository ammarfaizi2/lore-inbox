Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932705AbWJLRPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbWJLRPL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWJLROn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:14:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54400 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751436AbWJLROd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:14:33 -0400
Subject: [GFS2 & DLM] Pull request
From: Steven Whitehouse <swhiteho@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 12 Oct 2006 18:19:52 +0100
Message-Id: <1160673592.11901.830.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please consider pulling the following bug fixes from the GFS2 git tree,

Steve.


The following changes since commit c25d5180441e344a3368d100c57f0a481c6944f7:
  Linus Torvalds:
        Merge branch 'upstream' of git://ftp.linux-mips.org/pub/scm/upstream-linus

are found in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-fixes.git

Adrian Bunk:
      [DLM] Kconfig: don't show an empty DLM menu

Patrick Caulfield:
      [DLM] fix iovec length in recvmsg

Russell Cattelan:
      [GFS2] Fix a size calculation error
      [GFS2] Pass the correct value to kunmap_atomic

Steven Whitehouse:
      [GFS2] Fix uninitialised variable
      [GFS2] Fix bug where lock not held
      [GFS2] Update git tree name/location

 MAINTAINERS           |    6 ++++--
 fs/dlm/Kconfig        |    3 +--
 fs/dlm/lowcomms.c     |    2 +-
 fs/gfs2/log.c         |    5 ++---
 fs/gfs2/lops.c        |    4 ++--
 fs/gfs2/ops_address.c |   13 ++++++++-----
 fs/gfs2/rgrp.h        |    2 +-
 7 files changed, 19 insertions(+), 16 deletions(-)


