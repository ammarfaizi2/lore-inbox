Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266883AbUBRAVz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265908AbUBRATl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:19:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:25306 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265925AbUBRARr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:17:47 -0500
Date: Tue, 17 Feb 2004 16:19:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: paulmck@us.ibm.com
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-Id: <20040217161929.7e6b2a61.akpm@osdl.org>
In-Reply-To: <20040217124001.GA1267@us.ibm.com>
References: <20040216190927.GA2969@us.ibm.com>
	<20040217073522.A25921@infradead.org>
	<20040217124001.GA1267@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@us.ibm.com> wrote:
>
> IBM shipped the promised SAN Filesystem some months ago.

Neat, but it's hard to see the relevance of this to your patch.

I don't see any licensing issues with the patch because the filesystem
which needs it clearly meets Linus's "this is not a derived work" criteria.

And I don't see a technical problem with the export: given that we export
truncate_inode_pages() it makes sense to also export the corresponding
pagetable shootdown function.

Yes, this is a sensitive issue.  Can we please evaluate it strictly
according to technical and licensing considerations?

Having said that, what concerns issues remain with Paul's patch?

Thanks.
