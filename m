Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVCJCKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVCJCKj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 21:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVCJCJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 21:09:12 -0500
Received: from 70-56-134-246.albq.qwest.net ([70.56.134.246]:9919 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261676AbVCJCIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 21:08:55 -0500
Date: Wed, 9 Mar 2005 19:09:08 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: linux-os <linux-os@analogic.com>
cc: Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       blaisorblade@yahoo.it, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org,
       amitg@calsoftinc.com, gud@eth.net
Subject: Re: [patch 1/1] unified spinlock initialization arch/um/drivers/port_kern.c
In-Reply-To: <Pine.LNX.4.61.0503091840210.22633@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0503091908040.2903@montezuma.fsmlabs.com>
References: <20050309094234.8FC0C6477@zion> <20050309171231.H25398@flint.arm.linux.org.uk>
 <200503092052.24803.blaisorblade@yahoo.it> <20050309224259.J25398@flint.arm.linux.org.uk>
 <20050309145044.764bc056.akpm@osdl.org> <Pine.LNX.4.61.0503091840210.22633@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005, linux-os wrote:

> We need to retain the spin_lock_init(&lock) because not all spin-locks
> are allocated at compile-time. They might be allocated from kmalloc()
> on startup, probably in a structure, along with other so-called
> global data.

Not to worry my good man, it's not going anywhere.
