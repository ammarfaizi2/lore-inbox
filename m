Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbWBHPDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbWBHPDG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 10:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbWBHPDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 10:03:06 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:43423 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030411AbWBHPDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 10:03:05 -0500
Date: Wed, 8 Feb 2006 07:03:01 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: How in tarnation do I git v2.6.16-rc2?  hg died and I still don't
 git git
Message-Id: <20060208070301.1162e8c3.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to git a copy of Linus's tree, checked out only up
through revision v2.6.16-rc2, so that I can lay down Andrew's
latest broken-out quilt patch set for 2.6.16-rc2-mm1 on top of it.

I had been using hg (mercurial) to keep a current copy of Linus's
tree, and to make hg clones at each 2.6.*-rc*, to which I would apply
Andrew's various 2.6.*-rc*-mm*.

But the hg tree seems to have died on me, and I still don't git git.

I can do:

    git pull rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

and get Linus's tree as of the latest change, and I can do a "git log",
and see that I want a clone (in the hg sense, not the git sense) of
this tree as of:

    commit 826eeb53a6f264842200d3311d69107d2eb25f5e
    Author: Linus Torvalds <torvalds@g5.osdl.org>
    Date:   Thu Feb 2 22:03:08 2006 -0800

	Linux v2.6.16-rc2

Once I have that clone of Linus's tree at this revision, I am happy
using quilt to push Andrew's 2.6.16-rc2-mm1 that I ftp'd from:

    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc2/2.6.16-rc2-mm1/

on top of this.

But how in tarnation do I git a checked out copy/clone/whatever of
Linus's tree that only has the changes up through revision v2.6.16-rc2
(that doesn't include changes since then)?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
