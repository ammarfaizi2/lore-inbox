Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbWEaVcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbWEaVcv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWEaVcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:32:51 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:22930 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965170AbWEaVcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:32:50 -0400
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 3c59x.c
	disable_irq()
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060531203609.GA882@elte.hu>
References: <20060531200900.GA32482@elte.hu>
	 <1149107540.9978.5.camel@localhost.localdomain>
	 <20060531203609.GA882@elte.hu>
Content-Type: text/plain
Date: Wed, 31 May 2006 17:32:35 -0400
Message-Id: <1149111155.9978.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 22:36 +0200, Ingo Molnar wrote:
> *
> 
> i've updated it now, please check it out. (i sent the generic 
> disable_irq_lockdep() bits to lkml separately but forgot to Cc: you)
> 

I've just booted it on my i386 SMP (with the vortex card) and it hasn't
reported anything yet.

Looks good, I'll let you know if I find anything else.

-- Steve


