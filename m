Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267898AbTBKRjs>; Tue, 11 Feb 2003 12:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267899AbTBKRjs>; Tue, 11 Feb 2003 12:39:48 -0500
Received: from mailrelay2.lanl.gov ([128.165.4.103]:3271 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S267898AbTBKRjq>; Tue, 11 Feb 2003 12:39:46 -0500
Subject: 2.5.60 oops on boot, EIP at current_kernel_time
From: Steven Cole <elenstev@mesatop.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 11 Feb 2003 10:46:35 -0700
Message-Id: <1044985595.2552.468.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all,

I tried to boot 2.5.60 on a dual P3, SMP and PREEMPT enabled,
and got this oops early in the boot.  The following was hand-copied.

If more information is needed, I can repeat and transcribe more.

The root fs is ext3.

EIP Is at current_kernel_time+0x12/0x50
.
.
Trace
ramfs_get_inode+0x7c/0x120
ramfs_fill_super+0x2e/0x60
get_sb_nodev+0x39/0x70
do_kern_mount+0x42/0xb0
ramfs_fill_super+0x0/0x60
_stext+0x/0x50


Steven




