Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264155AbUFFVor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbUFFVor (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 17:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264164AbUFFVor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 17:44:47 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:61903 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264155AbUFFVoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 17:44:46 -0400
Date: Sun, 6 Jun 2004 17:46:20 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Disable scheduler debugging
In-Reply-To: <40C3452B.5010500@pobox.com>
Message-ID: <Pine.LNX.4.58.0406061742100.1838@montezuma.fsmlabs.com>
References: <20040606033238.4e7d72fc.ak@suse.de> <20040606055336.GA15350@elte.hu>
 <40C3452B.5010500@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jun 2004, Jeff Garzik wrote:

> Unfortunately there are just, flat-out, way too many kernel messages at
> boot-up.  Making them KERN_DEBUG doesn't solve the fact that SMP boxes
> often overflow the printk buffer before you boot up to a useful userland
> that can record the dmesg.
>
> The IO-APIC code is a _major_ offender in this area, but the CPU code is
> right up there as well.

How about the configurable log buffer size patch? I think Andrew still has
that amongst his wares.
