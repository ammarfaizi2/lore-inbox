Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbUJYOVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbUJYOVq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbUJYOVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:21:46 -0400
Received: from ipx20189.ipxserver.de ([80.190.249.56]:48519 "EHLO
	ipx20189.ipxserver.de") by vger.kernel.org with ESMTP
	id S261754AbUJYOOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:14:33 -0400
Date: Mon, 25 Oct 2004 17:13:05 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-mm1: NForce3 problem (IRQ sharing issue?)
In-Reply-To: <200410242308.31968.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.61.0410251709490.3029@musoma.fsmlabs.com>
References: <200410222354.44563.rjw@sisk.pl> <200410231928.43049.rjw@sisk.pl>
 <Pine.LNX.4.61.0410241921461.2982@musoma.fsmlabs.com> <200410242308.31968.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2004, Rafael J. Wysocki wrote:

> > Could you boot 2.6.10-rc1 with the 'noapic' kernel parameter and you may 
> > as well remove that pci=routeirq parameter, then send dmesg. Something 
> > appears hosed with respect to IOAPIC setup and i think ACPI is having 
> > trouble doing the fallback to PIC mode.
> 
> I booted with noapic and without pci=routeirq, although I think it's still 
> necessary for suspend.

I think that was an -mm thing only at some point, but it's not in 
mainline.

> The output of dmesg is attached (well, it's all I can 
> currently produce - I don't know how to get anything better).

So did the system still misbehave? What happened?

	Zwane
