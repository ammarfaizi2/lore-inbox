Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbTH2RtX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbTH2RtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:49:23 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:30188 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261632AbTH2RtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:49:16 -0400
Date: Fri, 29 Aug 2003 13:39:09 -0400
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Subject: bkcvs2svn rebuilt
Message-ID: <20030829173909.GH8140@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry suggested I rebuild the SVN repo's based on some changes to the
CVS tree. That completed this morning.

You'll need to re-checkout your SVN repo's.

For those that don't know bkcvs2svn is a gateway of sorts. Larry
provides a CVS tree that is built from the BK metadata. I then take that
CVS tree and convert it to an SVN repo. SVN has some advantages over CVS
(see info at the URL in my sig), but in this case it is limited by CVS's
own capabilities, but is still better than CVS in a few respects. Larry
also hosts the bkcvs2svn repo's.

SVN URL's are:

	svn://svn.kernel.org/linux-2.4/trunk

	svn://svn.kernel.org/linux-2.6/trunk

Specific versions can be gotten from:

	svn://svn.kernel.org/linux-2.x/tags/vA.B.C

This corresponds to anything tagged in the BK tree, but since bkcvs
filters out non kernel version tags, bkcvs2svn does aswell.

Note, the 2.6 tree is actually just the linux-2.5 one, but for easier
transition, I am asking people to use that now instead.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
