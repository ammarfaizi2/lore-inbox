Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbTIYI2B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 04:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTIYI1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 04:27:25 -0400
Received: from dp.samba.org ([66.70.73.150]:9112 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261773AbTIYI1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 04:27:21 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: akpm@zip.com.au, neilb@cse.unsw.edu.au, braam@clusterfs.com,
       davem@redhat.com, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>, tridge@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl-controlled number of groups. 
In-reply-to: Your message of "Thu, 25 Sep 2003 00:25:02 MST."
             <20030925072502.GL4306@holomorphy.com> 
Date: Thu, 25 Sep 2003 18:23:15 +1000
Message-Id: <20030925082720.94F422C35A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030925072502.GL4306@holomorphy.com> you write:
> On Thu, Sep 25, 2003 at 01:21:01PM +1000, Rusty Russell wrote:
> > We have a client (using SAMBA) who has people in 190 groups.  Since NT
> > has hierarchical groups, this is not all that rare.
> > What do people think of this patch?
> 
> I like the idea of raising the microscopic limit. BTW, was the Author:
> supposed to be Tim Hockin? ISTR his writing this or something almost
> identical to it. Also, I'm not sure if the sysctl is worth anything.

Nope, it's mine.  Tim's is v. similar, and I think a merge of the two
would produce something fine.  But as he says, it's fairly simple...

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
