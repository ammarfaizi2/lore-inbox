Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbTDDXYM (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 18:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbTDDXYM (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 18:24:12 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:31412 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261454AbTDDXYL (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 18:24:11 -0500
Date: Fri, 04 Apr 2003 15:25:38 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@digeo.com>
Subject: Error whilst running "tune2fs -j"
Message-ID: <5880000.1049498738@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone see this before? This was 2.5.65-mjb2 running on my laptop,
at the start of a "tune2fs -j" ....

buffer layer error at fs/buffer.c:395
Pass this trace through ksymoops for reporting
Call Trace: [__buffer_error+51/56]  [__find_get_block_slow+126/176]  [unmap_underlying_metadata+18/72]  [__block_prepare_write+374/
1056]  [__block_commit_write+114/156]  [block_prepare_write+33/56]  [ext2_get_bl
ock+0/744]  [ext2_prepare_write+25/32]  [ext2_get_block+0/744]  [generic_file_ai
o_write_nolock+1527/2536]  [generic_commit_write+51/92]  [unlock_page+10/60]  [g
eneric_file_write_nolock+111/140]  [do_lookup+24/148]  [link_path_walk+1499/1884
]  [permission+43/56]  [may_open+99/376]  [open_namei+672/944]  [generic_file_wr
ite+72/96]  [vfs_write+165/268]  [sys_write+42/60]  [syscall_call+7/11] 


