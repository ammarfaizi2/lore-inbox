Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262849AbVCMGAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbVCMGAn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 01:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbVCMGAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 01:00:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:24032 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263482AbVCMF75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 00:59:57 -0500
Date: Sat, 12 Mar 2005 21:59:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, adaplas@pol.net
Subject: Re: nvidia fb licensing issue.
Message-Id: <20050312215936.513039a6.akpm@osdl.org>
In-Reply-To: <20050313042459.GF32494@redhat.com>
References: <20050313042459.GF32494@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> The nvidia framebuffer code added recently is marked as
>  MODULE_LICENSE(GPL), but some things seem a little odd to me..
> 
>  1. The boilerplate at the top of drivers/video/nvidia/nv_dma.h,
>     drivers/video/nvidia/nv_local.h, and drivers/video/nvidia/nv_hw.c
>     doesn't seem to be a GPL-compatible license. It seems to be an nvidia
>     specific license with an advertising clause, and something that
>     adds restrictions on rights of U.S. Govt end users.
> 
>  2. Some of these files clearly came from XFree86 judging from
>     the CVS idents in the source.  Was this XFree86 code
>     dual-licensed by its original authors ? If so, it isn't clear.

Does

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm3/broken-out/fbdev-nvidia-licensing-clarification.patch

clear things up?
