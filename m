Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267436AbUHJFst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267436AbUHJFst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 01:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267439AbUHJFss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 01:48:48 -0400
Received: from mail2.uklinux.net ([80.84.72.32]:17054 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S267436AbUHJFsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 01:48:42 -0400
Date: Tue, 10 Aug 2004 06:48:37 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: Oops while idle: 2.6.7
Message-ID: <20040810054837.GA1458@titan.home.hindley.uklinux.net>
References: <20040809121454.GA1024@titan.home.hindley.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809121454.GA1024@titan.home.hindley.uklinux.net>
User-Agent: Mutt/1.3.28i
From: Mark Hindley <mark@hindley.uklinux.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And another overnight:

Aug 10 02:43:22 titan kernel: PREEMPT 
Aug 10 02:43:22 titan kernel: Modules linked in: ipv6 nfsd exportfs lockd sunrpc snd_als100 snd_opl3_lib snd_hwdep snd_sb16_dsp snd_sb_common snd_pcm snd_page_alloc snd_
timer snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 3c59x dummy 8250_pnp 8250 serial_core
Aug 10 02:43:22 titan kernel: CPU:    0
Aug 10 02:43:22 titan kernel: EIP:    0060:[copy_process+1349/2756]    Not tainted
Aug 10 02:43:22 titan kernel: EFLAGS: 00010246   (2.6.7-b) 
Aug 10 02:43:22 titan kernel: EIP is at copy_process+0x545/0xac4
Aug 10 02:43:22 titan kernel: eax: c0b22190   ebx: c3fa74e0   ecx: 00000000   edx: c2a9aa60
Aug 10 02:43:22 titan kernel: esi: c087e524   edi: c2a9af64   ebp: c0320d10   esp: c0871f40
Aug 10 02:43:22 titan kernel: ds: 007b   es: 007b   ss: 0068
Aug 10 02:43:22 titan kernel: Process apache (pid: 857, threadinfo=c0870000 task=c0b22190)
Aug 10 02:43:22 titan kernel: Stack: 00000000 01200011 00000000 c0871fbc 00000000 c0320db0 00000000 c01185ac 
Aug 10 02:43:22 titan kernel:        01200011 bfffe85c c0871fc4 00000000 00000000 402202e8 00000000 00000000 
Aug 10 02:43:22 titan kernel:        402202e8 c0871fbc c019ab97 bfffe8e8 c0871fb8 00000008 00000000 c01039bd 
Aug 10 02:43:22 titan kernel: Call Trace:
Aug 10 02:43:22 titan kernel:  [isapnp_init+472/644] isapnp_init+0x1d8/0x284
Aug 10 02:43:22 titan kernel:  [do_fork+140/435] do_fork+0x8c/0x1b3
Aug 10 02:43:22 titan kernel:  [copy_to_user+47/64] copy_to_user+0x2f/0x40
Aug 10 02:43:22 titan kernel:  [sys_clone+41/52] sys_clone+0x29/0x34
Aug 10 02:43:22 titan kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 10 02:43:22 titan kernel: 
Aug 10 02:43:22 titan kernel: Code: 24 20 81 e6 00 00 01 00 74 16 b8 00 e0 ff ff 21 e0 8b 00 8b 

Mark
