Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbUL3JJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbUL3JJv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 04:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbUL3JIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 04:08:46 -0500
Received: from wildsau.idv.uni.linz.at ([193.170.194.34]:53903 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S261590AbUL3JDD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 04:03:03 -0500
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200412300858.iBU8wtqa022470@wildsau.enemy.org>
Subject: Re: disabling IRQs cause nobody cares (incl. oops)
In-Reply-To: <200412300019.iBU0JYgr022375@wildsau.enemy.org>
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.enemy.org>
Date: Thu, 30 Dec 2004 09:58:53 +0100 (MET)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Dec 30 01:13:45 burn kernel: irq 19: nobody cared!
> Dec 30 01:13:45 burn kernel: Disabling IRQ #19
> Dec 30 01:13:51 burn kernel: irq 17: nobody cared!
> Dec 30 01:13:51 burn kernel: Disabling IRQ #17

ok, this is definitely related to CONFIG_PREEMPT, on a different
machine, I got the same message with irq10, which is bound to a
pcnet32 card.


