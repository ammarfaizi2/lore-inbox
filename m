Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271205AbTHHFTU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 01:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271210AbTHHFTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 01:19:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:52122 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271205AbTHHFTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 01:19:19 -0400
Date: Thu, 7 Aug 2003 22:21:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jason Lunz <lunz@falooley.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kswapd oops in 2.4.22-rc1
Message-Id: <20030807222121.7e8a0e19.akpm@osdl.org>
In-Reply-To: <slrnbj6684.jqn.lunz@orr.homenet>
References: <slrnbj6684.jqn.lunz@orr.homenet>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Lunz <lunz@falooley.org> wrote:
>
> I built a raid5 nfs server out of an old pentium 200 mmx
>
> ...
>
>  Unable to handle kernel NULL pointer dereference at virtual address 00000824
>  c0136b56
>  *pde = 00000000
>  Oops: 0002
>  CPU:    0
>  EIP:    0010:[<c0136b56>]    Not tainted
>  Using defaults from ksymoops -t elf32-i386 -a i386
>  EFLAGS: 00010206
>  eax: 00000000   ebx: 00000000   ecx: 00000800   edx: 00000000

                                             ^ single bit error.

It's time to treat yourself to a new computer.


