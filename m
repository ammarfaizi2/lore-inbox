Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317806AbSGKJ7N>; Thu, 11 Jul 2002 05:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317812AbSGKJ7M>; Thu, 11 Jul 2002 05:59:12 -0400
Received: from msv02-kent-syd.comindico.com.au ([203.194.29.48]:10925 "EHLO
	msv02-kent-syd.comindico.com.au") by vger.kernel.org with ESMTP
	id <S317806AbSGKJ7L>; Thu, 11 Jul 2002 05:59:11 -0400
Date: Thu, 11 Jul 2002 20:03:39 +1000
From: Peter Zelezny <zed@linux.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-rc1 link failed `init_rootfs'
Message-Id: <20020711200339.2f93f773.zed@linux.com>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.4.19-rc1 fails to link:

fs/fs.o: In function `mnt_init':
fs/fs.o(.text.init+0x8d2): undefined reference to `init_rootfs'

init_rootfs is defined in fs/ramfs/inode.c, but I am compiling
without ramfs support. Has ramfs become mandatory?

-- 
Peter Zelezny.
