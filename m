Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264215AbUEMNl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264215AbUEMNl3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 09:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUEMNl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 09:41:29 -0400
Received: from ns.suse.de ([195.135.220.2]:51126 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264192AbUEMNjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 09:39:32 -0400
Subject: Re: 2.6.6-mm2
From: Chris Mason <mason@suse.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040513131842.GC22202@fs.tum.de>
References: <20040513032736.40651f8e.akpm@osdl.org>
	 <20040513114520.A8442@infradead.org>
	 <20040513035134.2e9013ea.akpm@osdl.org>
	 <20040513121206.A8620@infradead.org>
	 <20040513042540.073478ea.akpm@osdl.org>  <20040513131842.GC22202@fs.tum.de>
Content-Type: text/plain
Message-Id: <1084455572.2583.395.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 13 May 2004 09:39:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-13 at 09:18, Adrian Bunk wrote:
> On Thu, May 13, 2004 at 04:25:40AM -0700, Andrew Morton wrote:
> >...
> > Wim explained that any application changes now won't be widely deployed for
> > another year.  During that period the ability to run existing Oracle setups
> > requires that hugepage allocation be available to unprivileged
> > applications.
> >...
> > It means that if people install a kernel.org machine on their database
> > server, the database *just won't work*.  This is not good for those users,
> > for the kernel developers or for Linux's reputation in general.
> >...
> 
> That sounds silly when talking about Oracle.
> 
> Oracle says:
>   Which Kernels are supported?
> 
>   Oracle does not support modified or recompiled kernels. Recompiled 
>   kernels are not supported with or without source modifications.
> 
> 
> I doubt there are many "existing Oracle setups" that will risk to lose 
> all Oracle support by installing a different kernel.
> 
No, I doubt so as well.  Then again, why force them into a vendor
kernel?  At the very least, it would be nice to be able to benchmark
vanilla against the vendors.

> And AFAIK Oracle currently supports not a single distribution that ships
> with kernel 2.6.

Keep in mind that just because oracle isn't certified on a kernel today,
that doesn't make Andrew's statements wrong.

-chris


