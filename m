Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266492AbUGKETU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266492AbUGKETU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 00:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266493AbUGKETU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 00:19:20 -0400
Received: from mail.gurulabs.com ([67.137.148.7]:25021 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S266492AbUGKETS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 00:19:18 -0400
Subject: Re: 2.6.7-mm7
From: Dax Kelson <dax@gurulabs.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040708235025.5f8436b7.akpm@osdl.org>
References: <20040708235025.5f8436b7.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089519553.4153.1.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 10 Jul 2004 22:19:14 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-09 at 00:50, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/

My logs are full of:

Debug: sleeping function called from invalid context at include/asm/uaccess.h:471
in_atomic():1, irqs_disabled():0
 [<c01195cf>] __might_sleep+0x9f/0xb0
 [<c01351a7>] __filemap_copy_from_user_iovec+0x57/0xd0
 [<c013583f>] generic_file_aio_write_nolock+0x61f/0x9e0
 [<c027428e>] sock_recvmsg+0xce/0xd0
 [<c02d3136>] schedule+0x286/0x4f0
 [<c0273f96>] sockfd_lookup+0x16/0x80
 [<c0135c5a>] generic_file_write_nolock+0x5a/0x80
 [<c015f71a>] do_select+0x18a/0x2b0
 [<c0135e64>] generic_file_writev+0x54/0x80
 [<c0135e10>] generic_file_writev+0x0/0x80
 [<c014ed83>] do_readv_writev+0x1e3/0x230
 [<c014e7e0>] do_sync_write+0x0/0xa0
 [<c0275e74>] sys_socketcall+0x154/0x250
 [<c014ee69>] vfs_writev+0x49/0x60
 [<c014ef18>] sys_writev+0x38/0x60
 [<c0105ced>] sysenter_past_esp+0x52/0x71


