Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUCLAgP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 19:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbUCLAgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 19:36:15 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:51140 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261865AbUCLAgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 19:36:14 -0500
Date: Thu, 11 Mar 2004 19:36:12 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Richard Browning <richard@redline.org.uk>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: SMP + Hyperthreading / Asus PCDL Deluxe / Kernel 2.4.x 2.6.x /
 Crash/Freeze
In-Reply-To: <200403120022.13534.richard@redline.org.uk>
Message-ID: <Pine.LNX.4.58.0403111932400.29087@montezuma.fsmlabs.com>
References: <A6974D8E5F98D511BB910002A50A6647615F4B99@hdsmsx402.hd.intel.com>
 <200403111819.25819.richard@redline.org.uk> <Pine.LNX.4.58.0403111715560.29087@montezuma.fsmlabs.com>
 <200403120022.13534.richard@redline.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004, Richard Browning wrote:

> > For my own curiosity, does switching the processors around do anything?
> > Those MCEs look confined to the non bootstrap processor package.
>
> Switched CPUs. This time I get the following:
>
> CPU3: Machine Check Exception: 000.0004
> CPU2: Machine Check Exception: 000.0004
> Bank 0: a20000008c010400
> Kernel Panic: CPU context corrupt
> In idle task - not syncing
>
> Note that the CPU# designations are swapped and that there's only one Bank 0:
> message. Is this significant?

Ok, but that's still on the same package so it's not moving with the
processor, thanks. Could you also supply processor info from
/proc/cpuinfo.
