Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbTLRDWR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 22:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264920AbTLRDWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 22:22:17 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:23772 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264919AbTLRDWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 22:22:16 -0500
Subject: Re: Double Interrupt with HT
From: john stultz <johnstul@us.ibm.com>
To: Miroslaw KLABA <totoro@totoro.be>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1071630228.3fdfc794eb353@ssl0.ovh.net>
References: <20031215155843.210107b6.totoro@totoro.be>
	 <1071603069.991.194.camel@cog.beaverton.ibm.com>
	 <1071615336.3fdf8d6840208@ssl0.ovh.net>
	 <1071618630.1013.11.camel@cog.beaverton.ibm.com>
	 <1071630228.3fdfc794eb353@ssl0.ovh.net>
Content-Type: text/plain
Message-Id: <1071717730.1117.26.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 17 Dec 2003 19:22:10 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-16 at 19:03, Miroslaw KLABA wrote:

> > Further I can't see how it fixes the problem, but it may just be working
> > around the issue. I'd be interested in what the patch author thinks. 
> > 
> > > I think it is a bug with the via chipset, but I'm not able to get deeper in
> > the
> > > kernel code.
> > 
> > Could be, but I suspect interrupt routing isn't happening properly at
> > boot time. The irqbalance code just forces it to be readjusted correctly
> > once your up and running. 
> > 
> 
> With SMP disabled, I have no problem with any kernel. So it must be in the APIC
> init, I think.

Does booting w/ "noapic" help?

thanks
-john


