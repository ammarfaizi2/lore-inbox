Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbTEIFYw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 01:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbTEIFYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 01:24:52 -0400
Received: from verein.lst.de ([212.34.181.86]:53522 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S262300AbTEIFYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 01:24:52 -0400
Date: Fri, 9 May 2003 07:37:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@digeo.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove devfs_register
Message-ID: <20030509073723.A653@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@digeo.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030508223449.A29413@lst.de> <20030508144808.745328f5.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030508144808.745328f5.akpm@digeo.com>; from akpm@digeo.com on Thu, May 08, 2003 at 02:48:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 02:48:08PM -0700, Andrew Morton wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> >
> > Whee! devfs_register isn't used anymore in the whole tree
> 
> devfs_register appears to still be used in
> 
> ./arch/ia64/sn/io/sn2/xbow.c
> ./arch/ia64/sn/io/hcl.c
> ./arch/ia64/sn/io/pciba.c

arch/ia64/sn/io/ doesn't compile in 2.5.  I wrote a hwgfs for SGI
to replace it but it didn't go into 2.5 yet.
