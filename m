Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269381AbUJFT2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269381AbUJFT2y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 15:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269367AbUJFT2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 15:28:54 -0400
Received: from fmr04.intel.com ([143.183.121.6]:19690 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S269381AbUJFT2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:28:00 -0400
Message-Id: <200410061927.i96JRU607630@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>, "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Default cache_hot_time value back to 10ms
Date: Wed, 6 Oct 2004 12:27:44 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSrYGGe/eUC0tBtSvSByCX71PqbLAAeDhwA
In-Reply-To: <20041005215116.3b0bd028.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Tuesday, October 05, 2004 9:51 PM
> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >  I'd say it is probably too low level to be a useful tunable (although
> >  for testing I guess so... but then you could have *lots* of parameters
> >  tunable).
>
> This tunable caused an 11% performance difference in (I assume) TPCx.
> That's a big deal, and people will want to diddle it.
>
> If one number works optimally for all machines and workloads then fine.
>
> But yes, avoiding a tunable would be nice, but we need a tunable to work
> out whether we can avoid making it tunable ;)
>
> Not that I'm soliciting patches or anything.  I'll duck this one for now.

Andrew, can I safely interpret this response as you are OK with having
cache_hot_time set to 10 ms for now?  And you will merge this change for
2.6.9?  I think Ingo and Nick are both OK with that change as well. Thanks.

- Ken


