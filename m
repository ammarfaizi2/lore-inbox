Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751754AbWHSOlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbWHSOlA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 10:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbWHSOlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 10:41:00 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:21910 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751366AbWHSOk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 10:40:59 -0400
Message-ID: <44E722E9.5090109@garzik.org>
Date: Sat, 19 Aug 2006 10:40:41 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andy Gay <andy@andynet.net>
CC: michael@ellerman.id.au, Thomas Klein <osstklei@de.ibm.com>,
       Alexey Dobriyan <adobriyan@gmail.com>, Thomas Klein <tklein@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>, netdev@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Christoph Raisch <raisch@de.ibm.com>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>
Subject: Re: [2.6.19 PATCH 4/7] ehea: ethtool interface
References: <200608181333.23031.ossthema@de.ibm.com>	<20060818140506.GC5201@martell.zuzino.mipt.ru>	<44E5DFA6.7040707@de.ibm.com>	<1155968305.1388.4.camel@localhost.localdomain> <1155970112.7302.434.camel@tahini.andynet.net>
In-Reply-To: <1155970112.7302.434.camel@tahini.andynet.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Gay wrote:
> fs/bio.c:169: warning: 'idx' may be used uninitialized in this function
> fs/eventpoll.c:500: warning: 'fd' may be used uninitialized in this function
> fs/isofs/namei.c:162: warning: 'offset' may be used uninitialized in this function
> fs/isofs/namei.c:162: warning: 'block' may be used uninitialized in this function
> fs/nfsd/nfsctl.c:292: warning: 'maxsize' may be used uninitialized in this function
> fs/udf/balloc.c:751: warning: 'goal_eloc.logicalBlockNum' may be used uninitialized in this function
> fs/udf/super.c:1358: warning: 'ino.partitionReferenceNum' may be used uninitialized in this function
> fs/xfs/xfs_alloc_btree.c:611: warning: 'nkey.ar_startblock' may be used uninitialized in this function
> fs/xfs/xfs_alloc_btree.c:611: warning: 'nkey.ar_blockcount' may be used uninitialized in this function
> fs/xfs/xfs_bmap.c:2498: warning: 'rtx' is used uninitialized in this function
> fs/xfs/xfs_bmap_btree.c:753: warning: 'nkey.br_startoff' may be used uninitialized in this function
> fs/xfs/xfs_da_btree.c:151: warning: 'action' may be used uninitialized in this function
> fs/xfs/xfs_dir.c:363: warning: 'totallen' may be used uninitialized in this function
> fs/xfs/xfs_dir.c:363: warning: 'count' may be used uninitialized in this function
> fs/xfs/xfs_ialloc_btree.c:545: warning: 'nkey.ir_startino' may be used uninitialized in this function
> fs/xfs/xfs_inode.c:1958: warning: 'last_dip' may be used uninitialized in this function
> fs/xfs/xfs_inode.c:1960: warning: 'last_offset' may be used uninitialized in this function
> fs/xfs/xfs_log.c:1749: warning: 'iclog' may be used uninitialized in this function
> fs/xfs/xfs_log_recover.c:523: warning: 'first_blk' may be used uninitialized in this function
> ipc/msg.c:338: warning: 'setbuf.qbytes' may be used uninitialized in this function
> ipc/msg.c:338: warning: 'setbuf.uid' may be used uninitialized in this function
> ipc/msg.c:338: warning: 'setbuf.gid' may be used uninitialized in this function
> ipc/msg.c:338: warning: 'setbuf.mode' may be used uninitialized in this function
> ipc/sem.c:810: warning: 'setbuf.uid' may be used uninitialized in this function
> ipc/sem.c:810: warning: 'setbuf.gid' may be used uninitialized in this function
> ipc/sem.c:810: warning: 'setbuf.mode' may be used uninitialized in this function
> drivers/md/dm-table.c:431: warning: 'dev' may be used uninitialized in this function
> drivers/md/dm-ioctl.c:1388: warning: 'param' may be used uninitialized in this function
> net/sched/sch_cbq.c:409: warning: 'ret' may be used uninitialized in this function
> lib/zlib_inflate/inftrees.c:121: warning: 'r.base' may be used uninitialized in this function


These are gcc bugs.  We don't patch the kernel for gcc bugs.

	Jeff


