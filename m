Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVDLSfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVDLSfQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVDLSex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:34:53 -0400
Received: from fmr23.intel.com ([143.183.121.15]:35279 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262309AbVDLR6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 13:58:33 -0400
Message-Id: <200504121758.j3CHwQg11702@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Jens Axboe'" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [patch] new fifo I/O elevator that really does nothing at all
Date: Tue, 12 Apr 2005 10:58:23 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU571mGRcgbG9LKQt2yFEe1HLL0ZQATcqowAVKg+JA=
In-Reply-To: <7A4826DE8867D411BAB8009027AE9EB91DB47626@scsmsx401.amr.corp.intel.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote on Tuesday, April 05, 2005 5:13 PM
> Jens Axboe wrote on Tuesday, April 05, 2005 7:54 AM
> > On Tue, Mar 29 2005, Chen, Kenneth W wrote:
> > > Jens Axboe wrote on Tuesday, March 29, 2005 12:04 PM
> > > > No such promise was ever made, noop just means it does 'basically
> > > > nothing'. It never meant FIFO in anyway, we cannot break the semantics
> > > > of block layer commands just for the hell of it.
> > >
> > > Acknowledged and understood, will try your patch shortly.
> >
> > Did you test it?
>
> Experiment is in the queue, should have a result in a day or two.


Jens, your patch works!  We are seeing a little bit increase in indirect
branch calls with your patch where our patch tries to remove elevator_merge_fn()
completely.  But the difference is all within noise range.

If there is no other issues (I don't see any), we would like to see this patch
merged upstream.  Thanks.

- Ken


