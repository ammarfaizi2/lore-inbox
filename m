Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262397AbUKRDEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbUKRDEq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 22:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUKRDCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 22:02:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:22751 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262388AbUKRDCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 22:02:21 -0500
Date: Wed, 17 Nov 2004 19:01:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Ian.Pratt@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [patch 4/4] Xen core patch : /dev/mem calls io_remap_page_range
Message-Id: <20041117190158.690fe458.akpm@osdl.org>
In-Reply-To: <E1CUZfD-00059Q-00@mta1.cl.cam.ac.uk>
References: <E1CUZfD-00059Q-00@mta1.cl.cam.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Pratt <Ian.Pratt@cl.cam.ac.uk> wrote:
>
> 
> This patch modifies /dev/mem to call io_remap_page_range rather than
> remap_page_range under CONFIG_XEN.

And this patch has tabs replaced with whitespace and also does not apply.

> diff -Nurp pristine-linux-2.6.9/drivers/char/mem.c linux-2.6.9-xen0/drivers/char/mem.c

linux-2.6.9 is very very old in kernel time.

>         if (remap_page_range(vma, vma->vm_start, offset, vma->vm_end-vma->vm_start,

There is no mention of `remap_page_range' in current kernels.


Please, always generate patches against current kernels.  You can use
Linus's bk tree or the latest snapshot from
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots.

Sort out what's going on with your email client, email the patches to
yourself first, make sure they still apply, then resend.

Thanks.
