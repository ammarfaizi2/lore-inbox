Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbVI1PUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbVI1PUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 11:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbVI1PUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 11:20:55 -0400
Received: from S01060013109fe3d4.vc.shawcable.net ([24.85.133.133]:969 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S1751067AbVI1PUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 11:20:55 -0400
Date: Wed, 28 Sep 2005 08:27:21 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Clemens Koller <clemens.koller@anagramm.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.2 crash on shutdown on SMP machine
In-Reply-To: <433A747E.3070705@anagramm.de>
Message-ID: <Pine.LNX.4.61.0509280812250.1684@montezuma.fsmlabs.com>
References: <433A747E.3070705@anagramm.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005, Clemens Koller wrote:

> Last night, right before thinking about going to bed, my newly
> installed old SMP machine crashed after a #shutdown -h now
> as shown below:
> 
> linux-2.6.13.2
> old Tyan Tomcat Board, Dual Processor, 2xPentium MMX 200MHz
> SMP enabled, preemption enabled..
> 
> [...]
> Shutdown: hda
> Power down.
> Badness in send_IPI_mask_bitmask at arch/i386/kernel/smp.c:168
> c010fdd5    send_IPI_mask_bitmask+0x65/0x70
> c0110236    smp_send_reschedule+0x16/0x20

We've seen this one before, how reproducible is it for you? Could you also 
please test a 2.6.14-rc -mm kernel?

Thanks,
	Zwane

