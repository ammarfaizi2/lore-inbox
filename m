Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbUCKWRS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 17:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUCKWRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 17:17:17 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:9415 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261785AbUCKWRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 17:17:10 -0500
Date: Thu, 11 Mar 2004 17:17:08 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Richard Browning <richard@redline.org.uk>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: SMP + Hyperthreading / Asus PCDL Deluxe / Kernel 2.4.x 2.6.x /
 Crash/Freeze
In-Reply-To: <200403111819.25819.richard@redline.org.uk>
Message-ID: <Pine.LNX.4.58.0403111715560.29087@montezuma.fsmlabs.com>
References: <A6974D8E5F98D511BB910002A50A6647615F4B99@hdsmsx402.hd.intel.com>
 <1078987834.2556.84.camel@dhcppc4> <200403111819.25819.richard@redline.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2004, Richard Browning wrote:

> I've now updated the BIOS to the latest version available on Asus' site. The
> crash occurs even earlier - during bootup this time. Exactly:
>
> CPU2: Machine Check Exception: 000.0004
> CPU3: Machine Check Exception: 000.0004
> Bank 0: a20000008c010400Bank0: a20000008c010400
> Kernel Panic: CPU context corrupt
> In idle task - not syncing
>
> Again, disabling hyperthreading allows the system to operate normally.

For my own curiosity, does switching the processors around do anything?
Those MCEs look confined to the non bootstrap processor package.
