Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264678AbTFWPxf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 11:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264695AbTFWPxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 11:53:34 -0400
Received: from main.gmane.org ([80.91.224.249]:11947 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264449AbTFWPxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 11:53:18 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Orion Poplawski <orion@cora.nwra.com>
Subject: Cannot apply sched-threading-2.4.21-E1 to 2.4.21 kernel
Date: Mon, 23 Jun 2003 10:06:41 -0600
Message-ID: <bd78i4$iom$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I assumed that the scheduler patch sched-threading-2.4.21-E1 at 
http://people.redhat.com/mingo/O(1)-scheduler/ is designed to be applied 
to the 2.4.21 kernel?  I'm not having any luck:

[root@earth linux-2.4.21]# patch -p1 < ../sched-threading-2.4.21-E1.patch
patching file fs/proc/array.c
Hunk #4 FAILED at 343.
Hunk #5 FAILED at 392.
2 out of 5 hunks FAILED -- saving rejects to file fs/proc/array.c.rej
patching file fs/proc/base.c
patching file fs/proc/inode.c
patching file fs/proc/proc_misc.c
Hunk #1 FAILED at 376.
1 out of 1 hunk FAILED -- saving rejects to file fs/proc/proc_misc.c.rej
patching file fs/smbfs/sock.c
patching file fs/ncpfs/sock.c
patching file fs/autofs/waitq.c
patching file fs/lockd/clntlock.c
patching file fs/lockd/clntproc.c
patching file fs/lockd/svc.c
patching file fs/nfsd/export.c
patching file fs/nfsd/nfssvc.c
patching file fs/jffs/intrep.c
patching file fs/autofs4/waitq.c
patching file fs/reiserfs/journal.c
patching file fs/jffs2/background.c
Hunk #1 succeeded at 110 with fuzz 1 (offset 3 lines).
Hunk #3 succeeded at 161 (offset 3 lines).
patching file fs/jfs/jfs_logmgr.c
patching file fs/jfs/jfs_txnmgr.c
patching file fs/jbd/journal.c
patching file fs/binfmt_aout.c
patching file fs/binfmt_elf.c
Hunk #4 succeeded at 602 (offset 3 lines).
Hunk #5 succeeded at 956 (offset -1 lines).
Hunk #6 succeeded at 986 (offset 3 lines).
Hunk #7 succeeded at 1004 (offset -1 lines).
Hunk #8 succeeded at 1175 (offset 3 lines).
Hunk #9 FAILED at 1222.
Hunk #10 succeeded at 1321 (offset -1 lines).
Hunk #11 succeeded at 1358 (offset 3 lines).
Hunk #12 succeeded at 1408 (offset -1 lines).
Hunk #13 succeeded at 1450 (offset 3 lines).
1 out of 13 hunks FAILED -- saving rejects to file fs/binfmt_elf.c.rej
patching file fs/buffer.c
Hunk #1 succeeded at 2920 (offset -41 lines).
Hunk #3 succeeded at 2995 (offset -41 lines).
patching file fs/exec.c
Hunk #2 succeeded at 465 (offset -7 lines).
Hunk #4 succeeded at 716 (offset -7 lines).
Hunk #6 succeeded at 839 (offset -7 lines).
Hunk #8 FAILED at 1247.
Hunk #9 succeeded at 1273 with fuzz 2 (offset -12 lines).
1 out of 9 hunks FAILED -- saving rejects to file fs/exec.c.rej

....and so on.

Was this a mistaken assumption?


