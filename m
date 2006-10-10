Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751996AbWJJDKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbWJJDKc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbWJJDKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:10:32 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34720 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751996AbWJJDKb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:10:31 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCHSET] nfs endianness annotations
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX80l-00049E-00@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:10:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Series below does endianness annotations of nfs and nfsd; it had been
sitting in my tree for quite a while.  In part it's based on Alexey's
patches.

I thought to hold it back until the next merge window, but since we
do get new breakage that would be instantly caught by endianness checks...
IMO it makes sense to see if that puppy could be merged at this point.
In any case, the first patch in series is absolutely needed - it's
fixing a genuine recently introduced bug.

Comments are welcome.

