Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVCEJ4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVCEJ4B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 04:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVCEJ4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 04:56:01 -0500
Received: from mx1.mail.ru ([194.67.23.121]:10114 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261930AbVCEJz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 04:55:57 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-mm1 (xen-vmm-4-split-free_irq-into-teardown_irq.patch)
Date: Sat, 5 Mar 2005 12:56:06 +0200
User-Agent: KMail/1.6.2
Cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200503051256.06724.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- 25/kernel/irq/manage.c~xen-vmm-4-split-free_irq-into-teardown_irq
> +++ 25-akpm/kernel/irq/manage.c

> +/**
> + *	setup_irq - register an irqaction structure
> + *	@irq: Interrupt to register
> + *	@irqaction: The irqaction structure to be registered
	^^^^^^^^^^^

> + *
> + *	Normally called by request_irq, this function can be used
> + *	directly to allocate special interrupts that are part of the
> + *	architecture.
>   */
>  int setup_irq(unsigned int irq, struct irqaction * new)
						     ^^^^^

Comment doesn't match declaration.

	Alexey
