Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264426AbUEJAVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbUEJAVJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 20:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264425AbUEJAVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 20:21:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:3541 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264426AbUEJAVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 20:21:03 -0400
Date: Sun, 9 May 2004 17:20:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Un-inline spinlocks on ppc64
Message-Id: <20040509172038.55319fbd.akpm@osdl.org>
In-Reply-To: <16542.51381.215308.485006@cargo.ozlabs.ibm.com>
References: <16542.51381.215308.485006@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> The patch below moves the ppc64 spinlocks and rwlocks out of line and
>  into arch/ppc64/lib/locks.c, and implements _raw_spin_lock_flags for
>  ppc64.
> 

It included a hunk against include/asm-ppc64/offsets.h, which I dropped.

> ...
>  This patch depends on the patch from Keith Owens to add
>  _raw_spin_lock_flags.  If you decide to drop that patch, let me know
>  and I can do a new version without _raw_spin_lock_flags.

Keith's patch and Zwane's x86 implemeentation are queued up and seem to
work OK, so all is well, thanks.
