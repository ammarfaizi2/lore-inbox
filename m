Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTEVSWe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 14:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTEVSWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 14:22:34 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:14340
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263025AbTEVSWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 14:22:21 -0400
Date: Thu, 22 May 2003 11:35:26 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: jjs <jjs@tmsusa.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.69-mm8 improvements and one oops
Message-ID: <20030522183526.GC30353@matchmail.com>
Mail-Followup-To: jjs <jjs@tmsusa.com>,
	linux kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@digeo.com>
References: <3ECD13A1.9060103@tmsusa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ECD13A1.9060103@tmsusa.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 11:14:57AM -0700, jjs wrote:
> ------------[ cut here ]------------
> kernel BUG at kernel/sched.c:614!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c011d762>]    Not tainted VLI
> EFLAGS: 00010246
> EIP is at schedule_tail+0xe2/0x140
> eax: 00000008   ebx: 00000000   ecx: d65d4e40   edx: d563c000
> esi: d8fa0120   edi: d953a31c   ebp: d563dfb8   esp: d563df9c
> ds: 007b   es: 007b   ss: 0068
> Process bonobo-activati (pid: 1275, threadinfo=d563c000 task=d65d54c0)
> Stack: 43297d43 7d43297d 297d4329 43297d43 7d43297d d8fa0120 d65d54c0 
> d564ffbc
>       c010a362 d8fa0120 01200011 00000000 00000000 00000000 40018da8 
> bfffe148
>       00000000 0000007b 0000007b 00000078 ffffe410 00000073 00000202 
> bfffe0ec
> Call Trace:
> [<c010a362>] ret_from_fork+0x6/0x14
> 
> Code: 85 d2 74 16 89 d6 83 c6 04 19 c9 39 70 18 83 d9 00 85 c9 75 05 8b 
> 43 7c 89 02 83 c4 14 5b 5e 5d c3 89 34 24 e8 a0 35 00 00 eb c6 <0f> 0b 
> 66 02 ad 7d 3e c0 eb b2 8d 74 26 00 89 d8 e8 f9 66 00 00

You didn't run this through ksymoops.
