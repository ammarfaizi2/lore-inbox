Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261944AbTCQWGN>; Mon, 17 Mar 2003 17:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261962AbTCQWGN>; Mon, 17 Mar 2003 17:06:13 -0500
Received: from ns.suse.de ([213.95.15.193]:46608 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261944AbTCQWGL>;
	Mon, 17 Mar 2003 17:06:11 -0500
Date: Mon, 17 Mar 2003 23:17:05 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: bootup oops with current BK
Message-ID: <20030317231705.A12187@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bk from ~1 hr ago yields this on boot..
<hand-transcribed>

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01907a4
*pde = 00000000
Oops: 0000
EIP: 0060:[<c01907a4>]   Not tainted
EIP is at d_alloc+0x64/0x390
...

Call Trace:
 alloc_inode
 alloc_inode 
 d_alloc_root
 sysfs_new_inode
 sysfs_fill_super
 get_sb_single
 do_kern_mount
 sysfs_fill_super
 _stext
 kern_mount
 _stext


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
