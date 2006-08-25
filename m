Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWHYUVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWHYUVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWHYUVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:21:52 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:64191 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932328AbWHYUVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:21:51 -0400
Date: Fri, 25 Aug 2006 16:16:31 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 9/18] 2.6.17.9 perfmon2 patch for review:
  kernel-level interface
To: Christoph Hellwig <hch@infradead.org>
Cc: Stephane Eranian <eranian@hpl.hp.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Message-ID: <200608251618_MC3-1-C958-74D1@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060825134704.GA21398@infradead.org>

On Fri, 25 Aug 2006 14:47:04 +0100, Christoph Hellwig wrote:

> > This interface is for people writing kprobes who want to do performance
> > monitoring within their probe code.  There will probably never be any
> > in-kernel users, just like there are no in-kernel users of kprobes.
>
> Wrong argument.  There is a in-tree user of kprobes and I plan to submit
> a lot more.

OK.  More than two years after kprobes went into the kernel, a single
in-kernel user has now appeared in 2.6.18-rc: /net/ipv4/tcp_probe.c

So by your argument kprobes should not have been merged until now.

> If people want to write kprobes for performance mintoring
> they should submit them for inclusion and we can then find a proper
> API for it - the current one is rather horrible anyway.

How so?  Last time I tried it I had to manually copy parts of headers 
from libpfm to get the fields but that should be easy to fix.  And
some wrappers around the low-level functions might be nice but again
that's easy to add.

-- 
Chuck

