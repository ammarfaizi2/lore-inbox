Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUKOVTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUKOVTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 16:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUKOVSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 16:18:18 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:36075 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261333AbUKOVPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 16:15:18 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-Id: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 15 Nov 2004 22:15:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Linus!

Please consider adding the FUSE filesystem to the mainline kernel.

FUSE exports the filesystem functionality to userspace.  The
communication interface is designed to be simple, efficient, secure
and able to support most of the usual filesystem semantics.

Reasons why I think inclusion is a good idea:

  - It is widely used.  There are many filesystems available which use
    FUSE, and there are probably even more in-house applications

  - It's been around for 3 years, it's very stable and both the kernel
    interface and the library API have matured

  - It's non-intrusive, the patch doesn't touch other parts of the
    kernel

Patches for 2.6.10-rc2 and 2.6.10-rc1-mm5 are available from:

  http://fuse.sourceforge.net/kernel_patches/

More information can be found on the homepage at:

  http://fuse.sourceforge.net/

Comments are welcome.

Thanks,
Miklos
