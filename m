Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbUDMTzq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 15:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263722AbUDMTzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 15:55:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:22469 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263718AbUDMTzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 15:55:42 -0400
Date: Tue, 13 Apr 2004 12:54:36 -0700
From: cliff white <cliffw@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFT] please test the big post-2.6.5 merge
Message-Id: <20040413125436.007cbcfe.cliffw@osdl.org>
In-Reply-To: <407C1DD8.5060909@pobox.com>
References: <407C1DD8.5060909@pobox.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2004 13:05:28 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> 
> The snapshot 2.6.5-bk1 is out, and has a _ton_ of changes in it that 
> have been waiting to go upstream for several weeks.  This snapshot 
> includes many more _major_ changes than most snapshots, so I wanted to 
> call special attention to it, and request testing and feedback from 
> linux-kernel denizens.
> 
> Changelog describing the 457 changes in this snapshot:
> http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.5-bk1.log
> 
> Patch:
> http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.5-bk1.bz2
> 
> Short, jgarzik-generated list of major changes that probably want testing:
> * non-exec stack support
> * much better block I/O unplugging (I/O scalability)
> * laptop mode
> * lots of VM work (often related to I/O or Hugh's rmap/anonvma stuff)
> * 4K stacks
> * updated software suspend
> * early x86 boot changes
> * several ext2/ext3/jbd improvements
> * new "CFQ" I/O scheduler
> * queue congestion hooks
> * DM, MD fixes (some related to the queue congestion/unplugging changes)
> * posix message queue work from Manfred
> * lightweight auditing framework
> * reiserfs fixes and features
> * readahead tweaks and fixes
> * writeback tweaks
> * direct-IO and AIO fixes and speed-ups
> * shrinkage from Matt Mackall's -tiny tree
> * /dev/urandom scalability
> * update slab for per-arch alignments
> * initramfs fix
> * knfsd fixes and updates
> * nfs client fixes/updates
> * pcmcia update
> * SATA update
> * selinux update
> * v4l update
> * various arch updates: H8300, s/390, ppc32, ppc64, x86-64, nommu, arm, ...
> 
> 

We've added a bunch more STP runs against this kernel. Results should be coming out
this evening...
cliffw
OSDL

> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
