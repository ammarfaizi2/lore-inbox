Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261475AbTCQKYn>; Mon, 17 Mar 2003 05:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261477AbTCQKYn>; Mon, 17 Mar 2003 05:24:43 -0500
Received: from anchor-post-39.mail.demon.net ([194.217.242.80]:9131 "EHLO
	anchor-post-39.mail.demon.net") by vger.kernel.org with ESMTP
	id <S261475AbTCQKYm>; Mon, 17 Mar 2003 05:24:42 -0500
Date: Mon, 17 Mar 2003 10:34:35 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE]:Squashfs1.2 released (compressed filesystem)
Message-ID: <20030317103435.A1572@pierrot.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Squashfs1.2 has been released.

Squashfs is a highly compressed read-only filesystem for Linux 2.4.
It uses zlib to compress files, inodes, and directories. All blocks
are packed to minimise the data overhead, and block sizes of between
4K and 32K are supported. It is intended to be used as a filesystem for
archival use and in embedded systems where low overhead is needed.

1.2 has added append capability to Mksquashfs. This means that new files
and directories can be added to pre-existing filesystems without
needing to rewrite the original data. For large filesystems this can be of
major benefit. Because mksquashfs peforms duplicate checking against the
original filesystem, it means that updated directories can be appended over
time, and only the changed files will take extra space. The unchanged files
will be detected as duplicates, and will share data. This exhibits a basic
versioning capability.

Squashfs1.2 is available from http://squashfs.sourceforge.net.

Regards,

Phil Lougher

