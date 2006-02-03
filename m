Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945922AbWBCTnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945922AbWBCTnt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945923AbWBCTnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:43:49 -0500
Received: from smtp07.web.de ([217.72.192.225]:56263 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S1945922AbWBCTns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:43:48 -0500
From: Gregor Jasny <gjasny@web.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: linux-2.6.16-git2: compile error in reiserfs
Date: Fri, 3 Feb 2006 20:43:45 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602032043.46148.gjasny@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.6.16-git2 does not compile with my config:

  CC [M]  fs/reiserfs/xattr.o
fs/reiserfs/xattr.c: In function 'reiserfs_check_acl':
fs/reiserfs/xattr.c:1330: error: called object '0u' is not a function
make[2]: *** [fs/reiserfs/xattr.o] Error 1
make[1]: *** [fs/reiserfs] Error 2
make: *** [fs] Error 2

Part of my config:
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
# CONFIG_REISERFS_FS_SECURITY is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y

Please contact me if you need more information.

Gregor
