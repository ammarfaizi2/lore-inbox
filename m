Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUL1Rli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUL1Rli (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 12:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbUL1Rli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 12:41:38 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:44958 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261206AbUL1Rlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 12:41:37 -0500
Subject: Re: PATCH: 2.6.10 - Misrouted IRQ recovery for review
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: mingo@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1104253919.4173.11.camel@laptopd505.fenrus.org>
References: <1104249508.22366.101.camel@localhost.localdomain>
	 <1104253919.4173.11.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104251842.20952.106.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Dec 2004 16:37:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> one question; I see you start passing a struct pt_regs around all over
> the place; does *anything* actually use that animal, or should we
> consider just passing a NULL .....
> (and eventually in 2.7 remove the parameter entirely from irq handlers?)

On x86-32 at least it is used because of the IRQ 13 handling for 386
systems on a maths FPU trap.

Alan

