Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTJFS4f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbTJFS4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:56:35 -0400
Received: from mail0-96.ewetel.de ([212.6.122.96]:23028 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S262074AbTJFS4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:56:34 -0400
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
In-Reply-To: <DIAQ.2Hh.5@gated-at.bofh.it>
References: <DIre.Cy.15@gated-at.bofh.it> <DIre.Cy.17@gated-at.bofh.it> <DIre.Cy.19@gated-at.bofh.it> <DIre.Cy.13@gated-at.bofh.it> <DIAQ.2Hh.5@gated-at.bofh.it>
Date: Mon, 6 Oct 2003 20:56:25 +0200
Message-Id: <E1A6aWv-0000rJ-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Oct 2003 20:50:12 +0200, you wrote in linux.kernel:

> That has no bearing on the legalities.  A version of the kernel can't
> force the GPL on a driver that works with that version of the kernel
> because you can pull that driver out and drop in another.

Okay, I can see the boundary. We still have the problem that drivers
writers have to be very careful to not copy kernel code by accident
because the kernel changes often, which creates a temptation to look
closely at in-tree drivers to see how they do things. And if a
drivers writer then produces code that is essentialy the same as is
found in the kernel, only with changed indentation and variable names,
I think we both a agree that such a driver would be a derived work.

Another problem is the fact that Linux kernel headers can contain code
in the form of macros. If a driver uses such a header, it links kernel
code with itself which can easily make it a derived work.

-- 
Ciao,
Pascal
