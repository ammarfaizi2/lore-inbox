Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbTITC0M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 22:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTITC0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 22:26:12 -0400
Received: from primary.dns.nitric.com ([64.81.197.236]:21767 "EHLO
	primary.mx.nitric.com") by vger.kernel.org with ESMTP
	id S261304AbTITC0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 22:26:10 -0400
To: Allen Martin <AMartin@nvidia.com>
Cc: linux-kernel@vger.kernel.org
From: Merlin Hughes <lnx@merlin.org>
Subject: Re: [PATCH] 2.4.23-pre4 add support for udma6 to nForce IDE drive r 
In-reply-to: <8F12FC8F99F4404BA86AC90CD0BFB04F039F714A@mail-sc-6.nvidia.com> 
Date: Fri, 19 Sep 2003 22:26:05 -0400
Message-Id: <20030920022607.A6D35338DA@primary.mx.nitric.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r/AMartin@nvidia.com/2003.09.19/16:49:45
>You can try downgrading your drive to udma5 to see if udma6 really does make
>it more stable (hdparm -X udma5 /dev/hdX) but I can't think of any reason
>why it should.

That's it; downgrading to UDMA100 crashes within a few minutes
of heavy I/O. Running at UDMA133 is rock solid.

>> I take it that I should boot with noapic in future to be safe.
>
>I've been telling people to disable APIC / ACPI because of the interrupt
>problem, but your interrupts are fine, so I'd leave it alone.  I'm curious,
>what version BIOS do you have?

Very good, thanks. Shuttle SN45G, FN45 mobo, AwardBIOS v6.00PG.
Is that the info you're looking for?

Thanks, Merlin
