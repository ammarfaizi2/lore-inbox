Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbTEPCmS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 22:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264342AbTEPCmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 22:42:18 -0400
Received: from jdike.stearns.org ([66.59.111.166]:15533 "EHLO
	jdike.wstearns.org") by vger.kernel.org with ESMTP id S264340AbTEPCmR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 22:42:17 -0400
Message-Id: <200305160254.h4G2s48n005118@ccure.karaya.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: uml-patch-2.5.69-1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 15 May 2003 22:54:04 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates UML to 2.5.69.  In addition, I merged in all of the 
outstanding changes from the 2.4 UML tree.  Highlights of these include:

	Added SIGWINCH support to skas mode, eliminating the 
'userspace: child stopped with signal 28' error.
	Fixed the process segfault bug exposed by Kylix.
	Changed the serial line major number from TTYAUX_MAJOR to TTY_MAJOR.
	Changed all stat() calls to stat64().
	Removed hostfs and ubd support for root-hostfs, since booting a hostfs
filesystem is possible without any special support.
	Expanded the information available from /proc/cpuinfo.
	UML should run on RH9 now.
	Sound works in skas mode.
	Multi-line strings are gone, so gcc 3.2 and 3.3 should be happier.
	Fixed a hostfs file creation mode bug.
	Fixed a file access time bug.

The 2.5.69-1 UML patch is available at
	http://www.karaya.com/mirror/uml-patch-2.5.69-1.bz2

For the other UML mirrors and other downloads, see 
        http://user-mode-linux.sourceforge.net/dl-sf.html
 
Other links of interest:
 
        The UML project home page : http://user-mode-linux.sourceforge.net
        The UML Community site : http://usermodelinux.org

				Jeff

