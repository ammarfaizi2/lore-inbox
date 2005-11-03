Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbVKCAHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbVKCAHO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 19:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbVKCAHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 19:07:14 -0500
Received: from waste.org ([216.27.176.166]:32453 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030191AbVKCAHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 19:07:13 -0500
Date: Wed, 2 Nov 2005 16:02:02 -0800
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ketchup 0.9.6 kernel upgrade tool released
Message-ID: <20051103000202.GJ4367@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ketchup is a tool for updating or switching between versions of the
Linux kernel source. It can:

 - find the latest versions of numerous KernelTrees
 - calculate which patches are needed to move to that version
 - download any patches or tarballs that aren't cached
 - check GPG signatures where available
 - apply and unapply patches to get the desired result
 - call hooks like quilt push/pop before and after

The latest release can be found at:

 http://selenic.com/ketchup/ketchup-0.9.6.tar.bz2

The ketchup wiki is at:

 http://selenic.com/ketchup/wiki

Latest changes include:

 add support for Con Kolivas' -ck and -cks trees
 refactor downloading of alternate URLs
 use tar --strip-path/--strip-components
 add documentation for .ketchuprc files to the man page
 support "default_tree" in .ketchuprc
 read .ketchuprc from the kernel directory if it exists
 print explicitly requested information even in quiet mode.
 stop relying on LATEST-IS for finding current mainline kernel version
 general code tidying

-- 
Mathematics is the supreme nostalgia of our time.
