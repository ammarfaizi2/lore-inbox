Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266476AbUHXGTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266476AbUHXGTt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 02:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266568AbUHXGS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 02:18:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:20198 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266511AbUHXGQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 02:16:41 -0400
Date: Mon, 23 Aug 2004 23:14:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: wli@holomorphy.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm4
Message-Id: <20040823231454.62734afb.akpm@osdl.org>
In-Reply-To: <20040823202158.GJ4418@holomorphy.com>
References: <20040822013402.5917b991.akpm@osdl.org>
	<20040823202158.GJ4418@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wli@holomorphy.com wrote:
>
>  On Sun, Aug 22, 2004 at 01:34:02AM -0700, Andrew Morton wrote:
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm4/
>  > - Added the kexec code.  Again.  This was in -mm a year or so ago but didn't
>  >   make it.
>  > - This kernel has an x86 patch which alters the copy_*_user() functions so
>  >   they will return -EFAULT on a fault rather than the number of bytes which
>  >   remain to be copied.  This is a bit of an experiment, because this seems to
>  >   be the preferred API for those functions.   It's a see-what-breaks thing.
>  >   And things will break.  If weird behaviour is observed, please revert
>  >   usercopy-return-EFAULT.patch and send a report.
> 
>  task_vsize() doesn't need mm->mmap_sem for the CONFIG_MMU case;

I'd prefer it if you (and everyone else) could give a meaningful
English-language Subject: to patches, please.

A well-chosen patch Subject: becomes a sort of globally-unique key by which
the patch is tracked - I munge it into a patch filename and it propagates
all the way into bitkeeper.  It can be used for searching email folders,
googling, inter-developer discussion, etc, etc.

Thanks.
