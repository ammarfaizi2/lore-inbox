Return-Path: <linux-kernel-owner+w=401wt.eu-S1751771AbXAOBCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbXAOBCn (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 20:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbXAOBCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 20:02:43 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:50599 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbXAOBCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 20:02:42 -0500
Date: Sun, 14 Jan 2007 20:02:39 -0500
From: Josef Sipek <jsipek@cs.sunysb.edu>
To: git@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Guilt v0.18
Message-ID: <20070115010239.GB9484@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guilt v0.18 is available for download.

Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
queues-like functionality and interface to git.

Tarballs:
http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/

Git repo:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git


The majority of changes is in greater sanity checking - before a patch is
pushed/popped/refreshed, we check the HEAD hash with that in the status file.
guilt-pop now does only one git-reset instead of n (n == number of patches
to pop). This should greatly increase the speed of popping patches.

Josef "Jeff" Sipek.

----------

Josef 'Jeff' Sipek (10):
      push_patch should be more careful when applying patches
      pop_patch should be quieter
      Removed debug line out of push_patch
      guilt-pop is now less brain damaged
      Add -m & -s args to guilt-new
      push_patch: look at diff stats instead of number of lines in patch
      Check HEAD hash against what we expect before push/pop/refresh
      Small cleanup in push_patch
      TODO moved to a separate branch
      Guilt v0.18

-- 
All science is either physics or stamp collecting.
		- Ernest Rutherford
