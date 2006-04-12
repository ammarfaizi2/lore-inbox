Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWDLRtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWDLRtP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWDLRtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:49:14 -0400
Received: from pat.uio.no ([129.240.10.6]:9895 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932277AbWDLRtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:49:12 -0400
Subject: Re: [PATCH] Use atomic ops for file_nr accounting, not spinlock+irq
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <17771.1144839377@warthog.cambridge.redhat.com>
References: <20060411150512.5dd6e83d.akpm@osdl.org>
	 <16476.1144773375@warthog.cambridge.redhat.com>
	 <17771.1144839377@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 13:48:48 -0400
Message-Id: <1144864128.8056.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.829, required 12,
	autolearn=disabled, AWL 1.17, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-12 at 11:56 +0100, David Howells wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > > Make the kernel use atomic operations for files_stat.nr_files accounting
> > > rather than using a spinlocked and interrupt-disabled critical section.
> > 
> > This code has all been redone in current kernels.
> 
> Hmmm... So it has. Trond's tree hasn't caught up yet, which is a bit of a
> problem:-/

I've been updating the NFS git tree on a daily basis. I'm not going to
begin pulling from the -mm tree, though.

Cheers,
  Trond

