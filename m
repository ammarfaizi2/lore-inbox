Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265816AbSLNS7Q>; Sat, 14 Dec 2002 13:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265819AbSLNS7Q>; Sat, 14 Dec 2002 13:59:16 -0500
Received: from bgp996345bgs.nanarb01.mi.comcast.net ([68.40.49.89]:6016 "EHLO
	syKr0n.mine.nu") by vger.kernel.org with ESMTP id <S265816AbSLNS7P>;
	Sat, 14 Dec 2002 13:59:15 -0500
Subject: Re: [2.5.51] Failure to mount ext3 root when ext2 compiled in
From: Mohamed El Ayouty <melayout@umich.edu>
To: Andrew Morton <akpm@digeo.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3DFB7D14.149B2B80@digeo.com>
References: <3DFB03E8.C7AB1271@digeo.com>
	<1039875751.10805.3.camel@syKr0n.mine.nu>  <3DFB7D14.149B2B80@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 14 Dec 2002 14:06:13 -0500
Message-Id: <1039892773.1496.1.camel@syKr0n.mine.nu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried your suggestion to replace CONFIG_DEVFS_FS with 

CONFIG_DEVFS_MOUNT in the code snippet:

#ifdef CONFIG_DEVFS_FS
        sys_mount("devfs", "/dev", "devfs", 0, NULL);
        do_devfs = 1;
#endif

But it gave me the same panic on boot.

Mohamed
