Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317081AbSGXMGh>; Wed, 24 Jul 2002 08:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317083AbSGXMGh>; Wed, 24 Jul 2002 08:06:37 -0400
Received: from mx2.elte.hu ([157.181.151.9]:33159 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317081AbSGXMGg>;
	Wed, 24 Jul 2002 08:06:36 -0400
Date: Wed, 24 Jul 2002 14:08:31 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] irqlock patch 2.5.27-H4
In-Reply-To: <20020724125903.A5961@infradead.org>
Message-ID: <Pine.LNX.4.44.0207241407290.18205-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, Christoph Hellwig wrote:

> >  - move the irqs-off check into preempt_schedule() and remove
> >    CONFIG_DEBUG_IRQ_SCHEDULE.
> 
> the config.in entry is still present..

indeed. Fix is in -H5:

   http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-H5

	Ingo

