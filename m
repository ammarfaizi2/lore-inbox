Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268689AbTBZSv6>; Wed, 26 Feb 2003 13:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268678AbTBZSv6>; Wed, 26 Feb 2003 13:51:58 -0500
Received: from dhcp63.ists.dartmouth.edu ([129.170.249.163]:1410 "EHLO
	uml.karaya.com") by vger.kernel.org with ESMTP id <S268689AbTBZSv6>;
	Wed, 26 Feb 2003 13:51:58 -0500
Message-Id: <200302261905.h1QJ5m221192@uml.karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: uml-patch-2.5.62-1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Feb 2003 14:05:48 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates UML to 2.5.63.  The major change in this patch is the
inclusion of hostfs and hppfs, which were 2.4-only until someone figured
out the 2.5 vfs changes enough to forward port them.  This was done by Petr
Baudis, who ported hostfs.  I used those changes to bring hppfs forward.
hostfs seems to work OK, although there is a loose end or two that needs 
fixing.  hppfs is non-functional now, although it does mount and mirror
procfs.

There were also a bunch of bug fixes:
	some interrupt blocking bugs are fixed
	a ubd driver file locking bug is gone

The 2.5.63-1 UML patch is available at
        http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.5.63-1.bz2
 
For the other UML mirrors and other downloads, see 
        http://user-mode-linux.sourceforge.net/dl-sf.html
 
Other links of interest:
 
        The UML project home page : http://user-mode-linux.sourceforge.net
        The UML Community site : http://usermodelinux.org

    Jeff
