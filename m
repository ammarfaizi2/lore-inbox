Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268196AbUIGQEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268196AbUIGQEV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268314AbUIGQBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:01:36 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:12029 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268196AbUIGP6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:58:12 -0400
Date: Tue, 7 Sep 2004 12:02:38 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       len.brown@intel.com
Subject: Re: [PATCH] Oops and panic while unloading holder of pm_idle
In-Reply-To: <200409051802.03976.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.53.0409071200480.14053@montezuma.fsmlabs.com>
References: <200408171728.06262.blaisorblade_spam@yahoo.it>
 <200408301309.54465.blaisorblade_spam@yahoo.it>
 <Pine.LNX.4.58.0408301743190.21529@montezuma.fsmlabs.com>
 <200409051802.03976.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Sep 2004, BlaisorBlade wrote:

> > There aren't many users of pm_idle 
> > outside of arch/*/kernel/process.c
> Both APM and ACPI set pm_idle, and both can be modular. It seems, however, 
> they are the only such ones. And since they APM and ACPI refuse to be both 
> loaded, we cannot have (actually) two modules which override pm_idle. So 
> you're right.

There are a few other issues with pm_idle, preempt and modular drivers 
which someone else is looking at, we'll see how things go from there.

Thanks,
	Zwane

