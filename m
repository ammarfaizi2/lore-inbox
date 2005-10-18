Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVJRIGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVJRIGf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 04:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbVJRIGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 04:06:35 -0400
Received: from waste.org ([216.27.176.166]:42372 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750822AbVJRIGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 04:06:34 -0400
Date: Tue, 18 Oct 2005 01:05:31 -0700
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Ketchup 0.9.5 kernel patching tool
Message-ID: <20051018080530.GB26205@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've finally kicked out a new release of my ketchup kernel patching
tool. Ketchup is a tool for updating or switching between versions of
the Linux kernel source. It can:

 * find the latest versions of numerous kernel trees
 * calculate which patches are needed to move to that version
 * download any patches or tarballs that aren't cached
 * check GPG signatures where available
 * apply and unapply patches to get the desired result

So for instance, I can painlessly switch a tree from 2.6.12-rc2-mm1 to the
latest -rt patch from Ingo by typing:

$ ketchup 2.6-rt

The latest version can be found at:

 http://www.selenic.com/ketchup/ketchup-0.9.5.tar.bz2

More information at:

 http://www.selenic.com/ketchup/wiki/

New Features
 add manpage
 add support for 2.6-git trees for the git snapshots
 add support for Ingo's -rt realtime preempt support tree
 add support for ~/.ketchuprc
 add support for local trees
 add generic pre/post command support (such as quilt push/pop)

Bug fixes
 use --dry-run
 fix handling of uncompressed patches and errors
 fix parsing of prenum
 make rename_dir() idempotent

-- 
Mathematics is the supreme nostalgia of our time.
