Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262784AbVDASva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbVDASva (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbVDAStT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:49:19 -0500
Received: from fmr23.intel.com ([143.183.121.15]:27568 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262856AbVDASpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:45:09 -0500
Message-Id: <200504011844.j31IiNg01909@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>
Cc: <oleg@tv-sign.ru>, <linux-kernel@vger.kernel.org>, <mingo@elte.hu>,
       <christoph@lameter.com>
Subject: RE: [RFC][PATCH] timers fixes/improvements
Date: Fri, 1 Apr 2005 10:44:23 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU26TfIV2xSWrNQRxyjKxy7untfrwAAVSnw
In-Reply-To: <20050401103235.1fcea9f0.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> On Fri, 1 Apr 2005, Oleg Nesterov wrote:
> >
> > This patch replaces and updates 6 timer patches which are currently
> > in -mm tree. This version does not play games with __TIMER_PENDING
> > bit, so incremental patch is not suitable. It is against 2.6.12-rc1.
> > Please comment. I am sending pseudo code in a separate message for
> > easier review.
>
> Looks ok by me. Andrew, should we let it cook in -mm, or what?
>

Andrew Morton wrote on Friday, April 01, 2005 10:33 AM
> Sure.  Christoph and (I think) Ken have been seeing mysterious misbehaviour
> which _might_ be due to Oleg's first round of timer patches.  I assume C&K
> will test this new patch?

Yes, we saw kernel hang with previous timer patches.  I will give this one
a try.


