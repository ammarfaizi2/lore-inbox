Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbUDPF5b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 01:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbUDPF5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 01:57:31 -0400
Received: from fmr04.intel.com ([143.183.121.6]:28640 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262454AbUDPF51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 01:57:27 -0400
Message-Id: <200404160556.i3G5uFF14323@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>, <raybry@sgi.com>,
       "'Andy Whitcroft'" <apw@shadowen.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: RE: hugetlb demand paging patch part [2/3]
Date: Thu, 15 Apr 2004 22:56:14 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQjbnfbrDshKMvbTImhdoLJO7wfOgACGaTw
In-Reply-To: <20040416044917.GB26707@zax>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Thursday, April 15, 2004 9:49 PM
> > > If we could get rid of follow_hugetlb_pages() it would remove an ugly
> > > function from every arch, which would be nice.
> >
> > I hope the goal here is not to trim code for existing prefaulting scheme.
> > That function has to go for demand paging, and demand paging comes with
> > a performance price most people don't realize.  If the goal here is to
> > make the code prettier, I vote against that.
>
> Well, I'm attempting to understand the hugepage code across all the
> archs, so that I can try to implement copy-on-write with a minimum of
> arch specific gunk.  Simplifying and consolidating the existing code
> across archs would be a helpful first step, if possible.

Looks like everyone has their own agenda, COW is related to demand paging,
and has it's own set of characteristics to deal with.  I would hope do one
thing at a time.

- Ken


