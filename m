Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264857AbUHNTyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264857AbUHNTyh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 15:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbUHNTxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 15:53:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7092 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265051AbUHNThh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 15:37:37 -0400
Date: Sat, 14 Aug 2004 20:37:34 +0100
From: Matthew Wilcox <willy@debian.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: PATCH [1/7] Fix posix locking code
Message-ID: <20040814193734.GU12936@parcelfarce.linux.theplanet.co.uk>
References: <1092511742.4109.18.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092511742.4109.18.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 03:29:02PM -0400, Trond Myklebust wrote:
>  VFS: Fix up posix_same_owner() so that it only uses the
>       file_lock->fl_owner field when determining lock equality.
> 
>  VFS: Fix up posix locking routines to use posix_same_owner() instead
>       of rolling their own checks.
> 
>     Signed-off-by: Trond Myklebust <trond.myklebust@fys.uio.no>

I like this patch.  Please apply.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
