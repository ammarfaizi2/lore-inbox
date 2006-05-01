Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWEAJgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWEAJgO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 05:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWEAJgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 05:36:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51430 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750892AbWEAJgN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 05:36:13 -0400
Date: Mon, 1 May 2006 02:34:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel =?ISO-8859-1?B?QXJhZ29u6XM=?= <danarag@gmail.com>
Cc: penberg@cs.helsinki.fi, arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Requested changelog for minix filesystem update to
 V3
Message-Id: <20060501023411.551525ee.akpm@osdl.org>
In-Reply-To: <4455D3F1.7000102@gmail.com>
References: <4455D3F1.7000102@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Aragonés <danarag@gmail.com> wrote:
>
>  Thank you for your interest. The file attached now has been diffed against last week's 2.6.16.11.
> 

That's not a development kernel.  Please raise patches against the latest
-linus tree, from ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots.

> 
>  In bitmap.c, the access to architecture dependent functions has been kept within the range of 1K blocksize. A loop inside a loop has been introduced to do so.
>  In inode.c, 'sbi->s_ninodes = m3s->s_ninodes' was missing, and variable 'block' is now unsigned.
>  In itree_common.c, function 'nblocks(loff_t size)' has been modified to fix the shift in 'blocks = (size + BLOCK_SIZE - 1) >> BLOCK_SIZE_BITS'.
>  In minix.h, minor and cosmetic corrections.

The bugs which I identified haven't been fixed?
