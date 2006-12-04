Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935999AbWLDLZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935999AbWLDLZb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 06:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936000AbWLDLZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 06:25:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45730 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S935999AbWLDLZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 06:25:31 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061203181642.GA226@oleg> 
References: <20061203181642.GA226@oleg> 
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386/kernel/smp.c: don't use set_irq_regs() 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 04 Dec 2006 11:24:58 +0000
Message-ID: <27132.1165231498@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:

> We don't need to setup _irq_regs in smp_xxx_interrupt (except apic timer).
> These handlers run with irqs disabled and do not call functions which need
> "struct pt_regs".

Acked-By: David Howells <dhowells@redhat.com>
