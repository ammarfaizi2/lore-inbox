Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUGJEeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUGJEeg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 00:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUGJEeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 00:34:36 -0400
Received: from main.gmane.org ([80.91.224.249]:54402 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266128AbUGJEee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 00:34:34 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: 2.6.7-mm7
Date: Fri, 09 Jul 2004 21:34:31 -0700
Message-ID: <pan.2004.07.10.04.34.31.166265@triplehelix.org>
References: <20040708235025.5f8436b7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-234-108.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jul 2004 23:50:25 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/

I get metric tons of these in my logs:

Debug: sleeping function called from invalid context at fs/proc/base.c:1529
in_atomic():1, irqs_disabled():0
 [<c0105437>] dump_stack+0x17/0x20
 [<c0115744>] __might_sleep+0xb4/0xe0
 [<c0174065>] proc_pid_flush+0x15/0x40
 [<c0118add>] release_task+0x13d/0x1d0
 [<c011986a>] exit_notify+0x34a/0x7b0
 [<c0119ef0>] do_exit+0x220/0x420
 [<c011a125>] sys_exit+0x15/0x20
 [<c0104edf>] syscall_call+0x7/0xb

My syslog was ~2G or so after I booted the kernel, went to sleep, went
to work, came back... ;)

-- 
Joshua Kwan


