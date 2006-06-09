Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWFIQ4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWFIQ4c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWFIQ4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:56:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51678 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030300AbWFIQ4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:56:31 -0400
Date: Fri, 9 Jun 2006 09:56:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: hch@infradead.org, cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
Message-Id: <20060609095620.22326f9d.akpm@osdl.org>
In-Reply-To: <44899653.1020007@garzik.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<20060609091327.GA3679@infradead.org>
	<20060609030759.48cd17a0.akpm@osdl.org>
	<44899653.1020007@garzik.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2006 11:40:03 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Users are now forced to remember that, if they write to their filesystem 
> after using either $mmver or $korgver kernels, they are locked out of 
> using older kernels.

The same happens if we create ext4 - earlier kernels don't support that,
either.

I suppose we could call it ext4, although that wouldn't make much
difference operationally.  The developers would probably choose to generate
ext4 from the same codebase as ext3 for maintainability reasons, rather
than choosing to copy-n-modify.  We'd need to see the patches to be able to
finally make that judgement.

> 
> And as features continue to be added in this manner, this problem gets 
> _exponentially_ worse.

"continue to be added"?  afaik this is the first time this has happened,
and there's no plan to do it again.

