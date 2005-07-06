Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbVGFTs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVGFTs0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVGFTpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:45:24 -0400
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:15324 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262123AbVGFOdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 10:33:13 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: rt-preempt build failure
Date: Thu, 7 Jul 2005 00:33:03 +1000
User-Agent: KMail/1.8.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200507052308.43970.kernel@kolivas.org> <200507062304.03944.kernel@kolivas.org> <20050706134950.GC19467@elte.hu>
In-Reply-To: <20050706134950.GC19467@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507070033.03948.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005 23:49, Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> > > thanks, i have fixed this and have uploaded the -51-00 patch.
> >
> > Thanks. boots and runs stable after a swag of these initially
> > (?netconsole related):

> ok, the patch below (or -51-04 and later kernels) should fix this one.
> printk is fully preemptible from now on - lets see how it works out in
> practice. (i kept it under irqs-off to make sure we get all crash
> messages out. Perhaps we could disable irqs/preemption if
> oops_in_progress?) This patch should also fix similar, fbcon related
> messages.

Works fine, thanks!

Con
