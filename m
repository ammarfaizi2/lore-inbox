Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTFGNzR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 09:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTFGNzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 09:55:17 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59093 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263199AbTFGNzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 09:55:15 -0400
Date: Sat, 7 Jun 2003 16:08:44 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: lord@sgi.com, linux-xfs@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.70-mm5: XFS compile error if CONFIG_SYSCTL && !CONFIG_PROC_FS
Message-ID: <20030607140844.GM15311@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following compile error in 2.5.70-mm5 if CONFIG_SYSCTL 
&& !CONFIG_PROC_FS:

<--  snip  -->

...
  CC      fs/xfs/linux/xfs_sysctl.o
fs/xfs/linux/xfs_sysctl.c: In function `xfs_stats_clear_proc_handler':
fs/xfs/linux/xfs_sysctl.c:61: `xfsstats' undeclared (first use in this function)
fs/xfs/linux/xfs_sysctl.c:61: (Each undeclared identifier is reported only once
fs/xfs/linux/xfs_sysctl.c:61: for each function it appears in.)
make[2]: *** [fs/xfs/linux/xfs_sysctl.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

