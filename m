Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265099AbUHNT4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265099AbUHNT4s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 15:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbUHNTyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 15:54:49 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:61188 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265099AbUHNTxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 15:53:14 -0400
Date: Sat, 14 Aug 2004 20:53:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: PATCH [2/7] Fix posix locking code
Message-ID: <20040814205306.A22261@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>
References: <1092511792.4109.22.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1092511792.4109.22.camel@lade.trondhjem.org>; from trond.myklebust@fys.uio.no on Sat, Aug 14, 2004 at 03:29:53PM -0400
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 03:29:53PM -0400, Trond Myklebust wrote:
>  VFS: Enable filesystems and to hook certain functions for copying
>       locks, and freeing locks using the new struct file_lock_operations.
> 
>  VFS: Enable lock managers (i.e. lockd) to hook functions for comparing
>       lock ownership using the new struct lock_manager_operations.

Please document these operations and their locking rules in
Documentation/filesystems/Locking

