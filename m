Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbULMHKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbULMHKI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 02:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbULMHKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 02:10:08 -0500
Received: from fsmlabs.com ([168.103.115.128]:62134 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262242AbULMHKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 02:10:04 -0500
Date: Mon, 13 Dec 2004 00:09:03 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: paulmck@us.ibm.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, shaohua.li@intel.com, len.brown@intel.com
Subject: Re: [PATCH] Remove RCU abuse in cpu_idle()
In-Reply-To: <20041212223249.65635f9a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0412130008070.16940@montezuma.fsmlabs.com>
References: <20041205004557.GA2028@us.ibm.com> <20041206111634.44d6d29c.sfr@canb.auug.org.au>
 <20041205232007.7edc4a78.akpm@osdl.org> <Pine.LNX.4.61.0412060157460.1036@montezuma.fsmlabs.com>
 <20041206160405.GB1271@us.ibm.com> <Pine.LNX.4.61.0412060941560.5219@montezuma.fsmlabs.com>
 <20041206192243.GC1435@us.ibm.com> <Pine.LNX.4.61.0412110804500.5214@montezuma.fsmlabs.com>
 <Pine.LNX.4.61.0412112123490.7847@montezuma.fsmlabs.com>
 <Pine.LNX.4.61.0412112205290.7847@montezuma.fsmlabs.com>
 <Pine.LNX.4.61.0412112244000.7847@montezuma.fsmlabs.com>
 <20041212221327.375fa4d0.akpm@osdl.org> <Pine.LNX.4.61.0412122317380.16940@montezuma.fsmlabs.com>
 <20041212223249.65635f9a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2004, Andrew Morton wrote:

> Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
> >
> > The idle thread is special in the sense that it can't get migrated so the 
> >  cached values of smp_processor_id are fine.
> 
> duh, knew that.
> 
> We can use the cached value throughout, no?

Oh yes, silly me i forgot about those.

Thanks!

