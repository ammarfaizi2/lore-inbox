Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbULMRYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbULMRYa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 12:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbULMRVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 12:21:00 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:55712 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261289AbULMRRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 12:17:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=HNS+Z4vujkd3pq9naGoQgStx06gB5wdxzj6zwLyXU0l5TJgUTyd66VQPNSw1PlNBb4zYRQug2QkXUvq7qmX46KaN0oDGVCWTMEpuDhIK1cH+SnV6prAq88DT/HW3+dycQ19fAnO+nUapIw/6apNDlHRLR485/quWhaR8Gcc6YFM=
Message-ID: <3fff1a7104121309177a52f33d@mail.gmail.com>
Date: Mon, 13 Dec 2004 19:17:18 +0200
From: Patrick <nawtyness@gmail.com>
Reply-To: Patrick <nawtyness@gmail.com>
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
Subject: Re: Unknown Issue.
Cc: Eric Sandeen <sandeen@sgi.com>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com, Andrew Morton <akpm@osdl.org>,
       "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>,
       Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <2E314DE03538984BA5634F12115B3A4E01BC4179@email1.mitretek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2E314DE03538984BA5634F12115B3A4E01BC4179@email1.mitretek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

> Yes, there was nothing relevant on either machine.

Same here.

> Dec  5 08:23:53 jpiszcz kernel: XFS internal error
> XFS_WANT_CORRUPTED_GOTO at line 1583 of file fs/xfs/xfs_alloc.c.  Caller
> 0xc021de57
> Dec  5 08:23:53 jpiszcz kernel:  [xfs_free_ag_extent+1237/2065]
> xfs_free_ag_extent+0x4d5/0x811
> Dec  5 08:23:53 jpiszcz kernel:  [xfs_free_extent+207/242]
> xfs_free_extent+0xcf/0xf2
> Dec  5 08:23:53 jpiszcz kernel:  [xlog_grant_push_ail+279/400]
> xlog_grant_push_ail+0x117/0x190
> Dec  5 08:23:53 jpiszcz kernel:  [xfs_free_extent+207/242]
> xfs_free_extent+0xcf/0xf2
> Dec  5 08:23:53 jpiszcz kernel:  [xfs_trans_get_efd+56/70]
> xfs_trans_get_efd+0x38/0x46
> Dec  5 08:23:53 jpiszcz kernel:  [xlog_recover_process_efi+402/508]
> xlog_recover_process_efi+0x192/0x1fc
> Dec  5 08:23:53 jpiszcz kernel:  [xlog_recover_process_efis+77/129]
> xlog_recover_process_efis+0x4d/0x81
> Dec  5 08:23:53 jpiszcz kernel:  [xlog_recover_finish+26/194]
> xlog_recover_finish+0x1a/0xc2
> Dec  5 08:23:53 jpiszcz kernel:  [xfs_rtmount_inodes+193/230]
> xfs_rtmount_inodes+0xc1/0xe6
> Dec  5 08:23:53 jpiszcz kernel:  [xfs_log_mount_finish+44/48]
> xfs_log_mount_finish+0x2c/0x30
> Dec  5 08:23:53 jpiszcz kernel:  [xfs_mountfs+2459/3995]
> xfs_mountfs+0x99b/0xf9b
> Dec  5 08:23:53 jpiszcz kernel:  [pagebuf_iostart+143/159]
> pagebuf_iostart+0x8f/0x9f
> Dec  5 08:23:53 jpiszcz kernel:  [atomic_dec_and_lock+39/68]
> atomic_dec_and_lock+0x27/0x44
> Dec  5 08:23:53 jpiszcz kernel:  [xfs_readsb+417/559]
> xfs_readsb+0x1a1/0x22f
> Dec  5 08:23:53 jpiszcz kernel:  [xfs_ioinit+27/46] xfs_ioinit+0x1b/0x2e
> Dec  5 08:23:53 jpiszcz kernel:  [xfs_mount+934/1646]
> xfs_mount+0x3a6/0x66e
> Dec  5 08:23:53 jpiszcz kernel:  [linvfs_fill_super+155/486]
> linvfs_fill_super+0x9b/0x1e6
> Dec  5 08:23:53 jpiszcz kernel:  [snprintf+39/43] snprintf+0x27/0x2b
> Dec  5 08:23:53 jpiszcz kernel:  [disk_name+98/191] disk_name+0x62/0xbf
> Dec  5 08:23:53 jpiszcz kernel:  [sb_set_blocksize+46/94]
> sb_set_blocksize+0x2e/0x5e
> Dec  5 08:23:53 jpiszcz kernel:  [get_sb_bdev+258/342]
> get_sb_bdev+0x102/0x156
> Dec  5 08:23:53 jpiszcz kernel:  [alloc_vfsmnt+156/215]
> alloc_vfsmnt+0x9c/0xd7
> Dec  5 08:23:53 jpiszcz kernel:  [linvfs_get_sb+47/51]
> linvfs_get_sb+0x2f/0x33
> Dec  5 08:23:53 jpiszcz kernel:  [linvfs_fill_super+0/486]
> linvfs_fill_super+0x0/0x1e6
> Dec  5 08:23:53 jpiszcz kernel:  [do_kern_mount+99/235]
> do_kern_mount+0x63/0xeb
> Dec  5 08:23:53 jpiszcz kernel:  [do_new_mount+158/247]
> do_new_mount+0x9e/0xf7
> Dec  5 08:23:53 jpiszcz kernel:  [do_mount+413/443] do_mount+0x19d/0x1bb
> Dec  5 08:23:53 jpiszcz kernel:  [copy_mount_options+96/183]
> copy_mount_options+0x60/0xb7
> Dec  5 08:23:53 jpiszcz kernel:  [sys_mount+191/291]
> sys_mount+0xbf/0x123
> Dec  5 08:23:53 jpiszcz kernel:  [do_mount_root+47/158]
> do_mount_root+0x2f/0x9e
> Dec  5 08:23:53 jpiszcz kernel:  [mount_block_root+96/305]
> mount_block_root+0x60/0x131
> Dec  5 08:23:53 jpiszcz kernel:  [mount_root+101/135]
> mount_root+0x65/0x87
> Dec  5 08:23:53 jpiszcz kernel:  [prepare_namespace+25/178]
> prepare_namespace+0x19/0xb2
> Dec  5 08:23:53 jpiszcz kernel:  [flush_workqueue+136/180]
> flush_workqueue+0x88/0xb4
> Dec  5 08:23:53 jpiszcz kernel:  [init+427/475] init+0x1ab/0x1db
> Dec  5 08:23:53 jpiszcz kernel:  [init+0/475] init+0x0/0x1db
> Dec  5 08:23:53 jpiszcz kernel:  [kernel_thread_helper+5/11]
> kernel_thread_helper+0x5/0xb
> Dec  5 08:23:53 jpiszcz kernel: VFS: Mounted root (xfs filesystem)
> readonly.

Ok, well i couldn't pinpoint it at FS and looked like hardware to me,
i suppose i could redo the box with 2.6.10 and XFS again to see if i
can redo the problem, although i'm partially leaning towards hardware,
but that's the easiest thing to blame :)

I figure i'm going to try out another FS, maby reiser, that should
either do the same, or not, if not, then we know where to start ?

P
