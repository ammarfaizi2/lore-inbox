Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266286AbTBKVel>; Tue, 11 Feb 2003 16:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266292AbTBKVel>; Tue, 11 Feb 2003 16:34:41 -0500
Received: from mailrelay1.lanl.gov ([128.165.4.101]:48572 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S266286AbTBKVel>; Tue, 11 Feb 2003 16:34:41 -0500
Subject: Re: 2.5.60 oops on boot, EIP at current_kernel_time
From: Steven Cole <elenstev@mesatop.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1044985595.2552.468.camel@spc9.esa.lanl.gov>
References: <1044985595.2552.468.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 11 Feb 2003 14:41:28 -0700
Message-Id: <1044999688.2576.480.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-11 at 10:46, Steven Cole wrote:
> Greetings all,
> 
> I tried to boot 2.5.60 on a dual P3, SMP and PREEMPT enabled,
> and got this oops early in the boot.  The following was hand-copied.
> 
> If more information is needed, I can repeat and transcribe more.
> 
> The root fs is ext3.
> 
> EIP Is at current_kernel_time+0x12/0x50
> .
> .
> Trace
> ramfs_get_inode+0x7c/0x120
> ramfs_fill_super+0x2e/0x60
> get_sb_nodev+0x39/0x70
> do_kern_mount+0x42/0xb0
> ramfs_fill_super+0x0/0x60
> _stext+0x/0x50
> 
Somehow my .config had gotten corrupted resulting in an enormous kernel.

1954567 Feb 11 10:13 vmlinuz-2.5.60
1173425 Feb 11 14:01 vmlinuz-2.5.60-bk1

After fixing the .config, all is well with 2.5.60-bk1 and -dj2.

Steven


