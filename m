Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVECAGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVECAGk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 20:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVECAGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 20:06:40 -0400
Received: from fire.osdl.org ([65.172.181.4]:37274 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261240AbVECAGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 20:06:39 -0400
Date: Mon, 2 May 2005 17:06:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH 1/22] UML - Include the linker script rather than
 symlink it
Message-Id: <20050502170654.248b11ea.akpm@osdl.org>
In-Reply-To: <200505012112.j41LC9fa016385@ccure.user-mode-linux.org>
References: <200505012112.j41LC9fa016385@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> wrote:
>
> >From Al Viro:
> 
> 	Make vmlinux.lds.S include appopriate script instead of playing
> games with symlinks.
> 
> Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
> Signed-off-by: Jeff Dike <jdike@addtoit.com>

Confused.

> Index: linux-2.6.11-mm/arch/um/kernel/vmlinux.lds.S
> ===================================================================
> --- linux-2.6.11-mm.orig/arch/um/kernel/vmlinux.lds.S	2005-04-30 12:56:25.000000000 -0400
> +++ linux-2.6.11-mm/arch/um/kernel/vmlinux.lds.S	2005-04-30 12:58:23.000000000 -0400
> @@ -1,113 +1,6 @@

That file doesn't exist and I think this patch doesn't want to patch it
anyway.

I'll just drop the vmlinux.lds.S chunk...
