Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269808AbUICV4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269808AbUICV4C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 17:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269814AbUICV4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 17:56:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:43215 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269812AbUICVzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 17:55:53 -0400
Date: Fri, 3 Sep 2004 14:59:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: torvalds@osdl.org, wli@holomorphy.com, jbarnes@engr.sgi.com,
       colpatch@us.ibm.com, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Re: SMP Panic caused by [PATCH] sched: consolidate sched
 domains]
Message-Id: <20040903145925.1e7aedd3.akpm@osdl.org>
In-Reply-To: <1094246465.1712.12.camel@mulgrave>
References: <1094246465.1712.12.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> Could we get this in please?  The current screw up in the scheduling
> domain patch means that any architecture that actually hotplugs CPUs
> will crash in find_busiest_group() ... and I notice this has just bitten
> the z Series people...

Have we yet seen anything which looks like a completed and tested patch?
