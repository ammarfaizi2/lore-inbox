Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268263AbUJTSBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268263AbUJTSBZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 14:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268916AbUJTRzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:55:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:16785 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268915AbUJTRwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:52:36 -0400
Date: Wed, 20 Oct 2004 10:50:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: dhowells@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, sparclinux@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-m68k@vger.kernel.org,
       linux-sh@m17n.org, linux-arm-kernel@lists.arm.linux.org.uk,
       parisc-linux@parisc-linux.org, linux-ia64@vger.kernel.org,
       linux-390@vm.marist.edu, linux-mips@linux-mips.org
Subject: Re: [PATCH] Add key management syscalls to non-i386 archs
Message-Id: <20041020105027.54bf9e89.akpm@osdl.org>
In-Reply-To: <20041020152957.GA21774@infradead.org>
References: <3506.1098283455@redhat.com>
	<20041020152957.GA21774@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> > Hi Linus, Andrew,
>  > 
>  > The attached patch adds syscalls for almost all archs (everything barring
>  > m68knommu which is in a real mess, and i386 which already has it).
>  > 
>  > It also adds 32->64 compatibility where appropriate.
> 
>  Umm, that patch added the damn multiplexer that had been vetoed multiple
>  times.  Why did this happen?

Fifteen new syscalls was judged excessive and the keyfs interface was
judged slow and bloaty.

