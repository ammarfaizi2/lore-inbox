Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSILVyD>; Thu, 12 Sep 2002 17:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315717AbSILVyD>; Thu, 12 Sep 2002 17:54:03 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:31709 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S315200AbSILVyD>; Thu, 12 Sep 2002 17:54:03 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200209122158.g8CLwim12943@devserv.devel.redhat.com>
Subject: Re: [PATCH] 2.4-ac task->cpu abstraction and optimization
To: ak@suse.de (Andi Kleen)
Date: Thu, 12 Sep 2002 17:58:44 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), rml@tech9.net (Robert Love), mingo@elte.hu,
       linux-kernel@vger.kernel.org
In-Reply-To: <p73bs73udvr.fsf@oldwotan.suse.de> from "Andi Kleen" at Sep 12, 2002 10:55:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One imho major problem with the new scheduler is that its new
> sched_yield breaks programs like OpenOffice, who rely on the old
> sched_yield behaviour. With new scheduler and 2.5 yield  OpenOffice
> can be completely starved just by a kernel compile because sched_yield
> kills all its time slices.

Ingo already fixed that
