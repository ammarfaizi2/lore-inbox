Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTJTS7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 14:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbTJTS7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 14:59:16 -0400
Received: from [65.172.181.6] ([65.172.181.6]:36246 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262765AbTJTS7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 14:59:14 -0400
Date: Mon, 20 Oct 2003 12:08:19 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Daniele Venzano <webvenza@libero.it>
cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ollie Lho <ollie@sis.com.tw>
Subject: Re: Linux 2.6.0-test7 - Suspend to Disk success
In-Reply-To: <20031019073845.GA820@picchio.gall.it>
Message-ID: <Pine.LNX.4.44.0310201207510.13116-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For the bash problem, there is something different between test7 and test8, 
> with test7 I get on resume:
> 
> Unable to handle kernel paging request at virtual address 401289b8
>  printing eip:
> 401289b8
> *pde = 0155d067
> *pte = 00000000
> Oops: 0004 [#1]
> CPU:    0
> EIP:    0073:[<401289b8>]    Not tainted
> EFLAGS: 00010246
> EIP is at 0x401289b8
> eax: 00000004   ebx: 00000001   ecx: 080f8c08   edx: 00000004
> esi: 00000004   edi: 080f8c08   ebp: bffff868   esp: bffff838
> ds: 007b   es: 007b   ss: 007b
> Process bash (pid: 1037, threadinfo=dafec000 task=db29a140)
>  <6>note: bash[1037] exited with preempt_count 1
> 
> And then bash dies. With test8, bash dies the same, but there is no such
> message on resume...

Could you please run the entire Oops through ksymoops? 

Thanks,


	Pat

