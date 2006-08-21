Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751835AbWHUKS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbWHUKS5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 06:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbWHUKS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 06:18:57 -0400
Received: from mail-a01.ithnet.com ([217.64.83.96]:55950 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S1751835AbWHUKS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 06:18:56 -0400
X-Sender-Authentication: net64
Date: Mon, 21 Aug 2006 12:09:18 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug Report 2.6.17.8
Message-Id: <20060821120918.8fa676d3.skraw@ithnet.com>
In-Reply-To: <20060820170717.e6f98f23.akpm@osdl.org>
References: <20060820134022.c1d676d6.skraw@ithnet.com>
	<20060820170717.e6f98f23.akpm@osdl.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2006 17:07:17 -0700
Andrew Morton <akpm@osdl.org> wrote:

> > Aug 20 03:43:11 a01 kernel: BUG: unable to handle kernel paging request at virtual address 02000044
> > Aug 20 03:43:11 a01 kernel:  printing eip:
> > Aug 20 03:43:11 a01 kernel: c0176356
> > Aug 20 03:43:11 a01 kernel: *pde = 00000000
> > Aug 20 03:43:11 a01 kernel: Oops: 0000 [#1]
> > Aug 20 03:43:11 a01 kernel: Modules linked in: speedstep_lib freq_table ipv6 intel_agp agpgart hw_random nfs lockd sunrpc e100 mii e1000
> > Aug 20 03:43:11 a01 kernel: CPU:    0
> > Aug 20 03:43:11 a01 kernel: EIP:    0060:[dqput+14/338]    Not tainted VLI
> > Aug 20 03:43:11 a01 kernel: EIP:    0060:[<c0176356>]    Not tainted VLI
> > Aug 20 03:43:11 a01 kernel: EFLAGS: 00010206   (2.6.17.8 #1)
> > Aug 20 03:43:11 a01 kernel: EIP is at dqput+0xe/0x152
> > Aug 20 03:43:11 a01 kernel: eax: 02000000   ebx: 02000000   ecx: f5fd0c00   edx: 00000000
> 
> Looks like a single-bit error.  Try running memtest86 for 24 hours?

Hi Andrew,

I have done that some weeks ago. What bothers me is that I have about 20 of these boxes and all run smoothly with kernel 2.4. Only the two running kernel 2.6 crash every now and then, mostly without usable output. This time I was lucky ...

-- 
Regards,
Stephan
