Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWAWEbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWAWEbi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 23:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWAWEbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 23:31:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:20115 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932162AbWAWEbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 23:31:37 -0500
From: Andi Kleen <ak@suse.de>
To: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Fixing make mandocs
Date: Mon, 23 Jan 2006 05:31:27 +0100
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601230531.27609.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here would be a good janitor task for 2.6.16. make mandocs currently
doesn't build because a number of descriptions are missing parameters etc.
It would be good if someone could fix that and submit patches for 2.6.16.

It should be relatively straight forward, if one cannot figure out
what a missing parameter does adding a dummy description ("Undocumented") 
would be also ok.

-Andi

  DOCPROC Documentation/DocBook/kernel-api.xml
Warning(/usr/src/packages/BUILD/linux-2.6.16-rc1-3//mm/slab.c:1505): No descript
ion found for parameter 'cachep'
Warning(/usr/src/packages/BUILD/linux-2.6.16-rc1-3//mm/slab.c:1505): No descript
ion found for parameter 'size'
Warning(/usr/src/packages/BUILD/linux-2.6.16-rc1-3//mm/slab.c:1505): No descript
ion found for parameter 'align'
Warning(/usr/src/packages/BUILD/linux-2.6.16-rc1-3//mm/slab.c:1505): No descript
ion found for parameter 'flags'
Error(/usr/src/packages/BUILD/linux-2.6.16-rc1-3//include/asm-i386/uaccess.h:416
): cannot understand prototype: '__always_inline unsigned long __must_check __co
py_to_user_inatomic(void __user *to, const void *from, unsigned long n) '
Warning(/usr/src/packages/BUILD/linux-2.6.16-rc1-3//fs/inode.c:1189): No descrip
tion found for parameter 'dentry'
Warning(/usr/src/packages/BUILD/linux-2.6.16-rc1-3//fs/bio.c:427): No descriptio
n found for parameter 'q'
Warning(/usr/src/packages/BUILD/linux-2.6.16-rc1-3//include/linux/skbuff.h:308):
 No description found for parameter 'copied_early'
Warning(/usr/src/packages/BUILD/linux-2.6.16-rc1-3//include/linux/skbuff.h:308):
 No description found for parameter 'dma_cookie'
Warning(/usr/src/packages/BUILD/linux-2.6.16-rc1-3//net/core/skbuff.c:211): No d
escription found for parameter 'fclone'
Warning(/usr/src/packages/BUILD/linux-2.6.16-rc1-3//net/sunrpc/sched.c:920): No 
description found for parameter 'clnt'
Warning(/usr/src/packages/BUILD/linux-2.6.16-rc1-3//net/sunrpc/sched.c:920): No 
description found for parameter 'flags'
Warning(/usr/src/packages/BUILD/linux-2.6.16-rc1-3//net/sunrpc/sched.c:920): No 
description found for parameter 'ops'
Warning(/usr/src/packages/BUILD/linux-2.6.16-rc1-3//net/sunrpc/sched.c:920): No 
description found for parameter 'data'
Warning(/usr/src/packages/BUILD/linux-2.6.16-rc1-3//net/sunrpc/sched.c:942): No 
description found for parameter 'parent'
Warning(/usr/src/packages/BUILD/linux-2.6.16-rc1-3//net/core/dev.c:3317): No des
cription found for parameter 'chan'
Warning(/usr/src/packages/BUILD/linux-2.6.16-rc1-3//net/core/dev.c:3317): No des
cription found for parameter 'event'
Warning(/usr/src/packages/BUILD/linux-2.6.16-rc1-3//kernel/irq/manage.c:177): No
 description found for parameter 'new'
Warning(/usr/src/packages/BUILD/linux-2.6.16-rc1-3//block/ll_rw_blk.c:317): No d
escription found for parameter 'prepare_flush_fn'
Warning(/usr/src/packages/BUILD/linux-2.6.16-rc1-3//block/ll_rw_blk.c:2637): No 
description found for parameter 'error'
make[1]: *** [Documentation/DocBook/kernel-api.xml] Error 1
