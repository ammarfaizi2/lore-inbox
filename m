Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269059AbUJERPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269059AbUJERPx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 13:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269057AbUJERPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 13:15:53 -0400
Received: from fmr03.intel.com ([143.183.121.5]:24258 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S269059AbUJERPv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 13:15:51 -0400
Message-Id: <200410051715.i95HFh627747@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: bug in sched.c:task_hot()
Date: Tue, 5 Oct 2004 10:15:49 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSqifJd1E6Een1oTDWBf7POckp3BQAdHcdg
In-Reply-To: <41621263.2000404@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Monday, October 04, 2004 8:18 PM
> >This bug causes large amount of incorrect process migration across
> >cpus (at stunning 10,000 per second) and we lost cache affinity very
> >quickly and almost took double digit performance regression on a db
> >transaction processing workload.  Patch to fix the bug.  Diff'ed against
> >2.6.9-rc3.
> >
>
> This one looks OK (the other may need a bit of rethinking).
> What kernel is the regression in relation to, out of interest?

Performance regression was initially seen on 2.6.8 relative to 2.6.6.
We subsequently narrowed down to these set of bugs.

- Ken


