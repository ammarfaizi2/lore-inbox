Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbTEHXbm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 19:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbTEHXbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 19:31:42 -0400
Received: from zok.SGI.COM ([204.94.215.101]:13762 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262261AbTEHXbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 19:31:41 -0400
Date: Thu, 8 May 2003 16:44:06 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove devfs_register
Message-ID: <20030508234406.GA23975@sgi.com>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
References: <20030508223449.A29413@lst.de> <20030508144808.745328f5.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508144808.745328f5.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's only because I haven't sent out another SN update yet.  I'll
try to put that together next week against 2.5.69.

Jesse

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
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
