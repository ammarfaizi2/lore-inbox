Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318468AbSH1BIF>; Tue, 27 Aug 2002 21:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318488AbSH1BIF>; Tue, 27 Aug 2002 21:08:05 -0400
Received: from verein.lst.de ([212.34.181.86]:35089 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S318468AbSH1BID>;
	Tue, 27 Aug 2002 21:08:03 -0400
Date: Wed, 28 Aug 2002 03:12:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: linux-xfs@oss.sgi.com
Subject: [PATCH] XFS core for 2.5.32
Message-ID: <20020828031222.A29229@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes only the core functionality of the SGI XFS
filesystem for Linux 2.5.32.  It does NOT include changes for Posix
ACLs, dmapi, kdb or other code included in the XFS CVS tree.

The patch adds the self-contained XFS code and makes almost no modifications
to existing kernel code.  Diffstat output with new files stripped:

 Documentation/Changes              |   16
 Documentation/filesystems/00-INDEX |    2
 MAINTAINERS                        |    8
 fs/Config.help                     |   66
 fs/Config.in                       |    9
 fs/Makefile                        |    1
 include/linux/sched.h              |    1
 include/linux/sysctl.h             |    2
 kernel/ksyms.c                     |    1

Please send any comments to the patch or xfs code to linux-xfs@oss.sgi.com.
We know that there are still issues left that need addressing, but feel
free to add your items.

The patches can be found at:

	ftp://ftp.kernel.org/pub/linux/kernel/people/hch/patches/v2.5/2.5.32/linux-2.5.32-xfs.patch.gz
	ftp://ftp.kernel.org/pub/linux/kernel/people/hch/patches/v2.5/2.5.32/linux-2.5.32-xfs.patch.bz2

