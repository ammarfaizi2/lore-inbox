Return-Path: <linux-kernel-owner+w=401wt.eu-S965303AbXAHJrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965303AbXAHJrg (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 04:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965302AbXAHJrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 04:47:36 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:58461 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965300AbXAHJrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 04:47:35 -0500
Date: Mon, 8 Jan 2007 04:47:34 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: git@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Guilt 0.17
Message-ID: <20070108094734.GF2329@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guilt v0.17 is available for download.

Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
queues-like functionality and interface to git.

Tarballs:
http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/

Git repo:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git


Overall, a lot of good changes that make the whole porcelain more robust.
The most notable one is the format of the status file (lists pushed patches)
which now also includes the hash of the commit object associated with the
patch.

Go ahead, use it, abuse it, and send patches ;)

Josef "Jeff" Sipek.

----------

Changes since v0.16:

Horst H. von Brand (2):
      Fix up Makefiles
      Run regression on the current version

Josef 'Jeff' Sipek (24):
      A minimalistic makefile
      Contributing doc file
      Added guilt-add
      Added guilt-status
      Expanded the HOWTO
      Added usage strings to all commands
      All arguments to guilt-add are filenames
      More thorough argument checking & display usage string on failure
      Changed status file format to include the hash of the commit
      Fixed guilt-refresh doing an unnecessary and somewhat wrong pop&push
      Fixed up guilt-{delete,pop} not matching the patch name properly
      Fixed guilt-{delete,pop} regexps some more
      Force UTC as timezone for regression tests
      Fixed a bug in guilt-pop introduced by the status file format switch
      Error messages should go to stderr
      Merge branch 'usage'
      Merge branch 'status-file'
      Yet another TODO update
      Added guilt-rm
      Makefile update & cleanup
      pop: Display the name of the patch from the status file, not the series file
      new: Create dir structure for the patch if necessary
      Documentation/TODO: Mark guilt-rm as done
      Guilt v0.17

-- 
NT is to UNIX what a doughnut is to a particle accelerator.
