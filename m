Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131488AbRCSPPU>; Mon, 19 Mar 2001 10:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131490AbRCSPPL>; Mon, 19 Mar 2001 10:15:11 -0500
Received: from usw-sf-sshgate.sourceforge.net ([216.136.171.253]:26876 "EHLO
	usw-sf-netmisc.sourceforge.net") by vger.kernel.org with ESMTP
	id <S131488AbRCSPPB>; Mon, 19 Mar 2001 10:15:01 -0500
To: linux-kernel@vger.kernel.org
Subject: Per user private directories - trfs
Message-Id: <E14f1MP-0004HZ-00@usw-pr-shell1.sourceforge.net>
From: "Amit S. Kale" <akale@users.sourceforge.net>
Date: Mon, 19 Mar 2001 07:14:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Translators for providing per user private directories and restricting
visibility of files and directories using the translation filesystem are
available now at
http://trfs.sourceforge.net/

Per user private directories:
Files created in a per user private directory are not visible to users
other than the owner of the files. Per user view enables users to use shared
directories as if they were private. Using a peruser view for a shared
directory like /tmp allows users to have their own copy of the directory.
It also helps reduce contention for directories like /var/spool/mail that
undergo a large number of file creations and removals.

Restricted visibility of files and directories:
Owner of a file can make it invisible to group (of the file) or others by
restricting its visibility. A directory listing by a user shows only those
files which are visibile to the user. Invisible files cannot be accessed
even by using a stat system call.
--
Amit S. Kale
<akale@users.sourceforge.net>

Linux kernel source level debugger    http://kgdb.sourceforge.net/
Translation filesystem                http://trfs.sourceforge.net/
