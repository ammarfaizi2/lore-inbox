Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269084AbUIHUl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269084AbUIHUl4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 16:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269112AbUIHUl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 16:41:56 -0400
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:3852
	"EHLO muru.com") by vger.kernel.org with ESMTP id S269084AbUIHUly
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 16:41:54 -0400
Date: Wed, 8 Sep 2004 13:42:49 -0700
From: Tony Lindgren <tony@atomide.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pavel@suse.cz, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: swsusp on x86-64 w/ nforce3
Message-ID: <20040908204249.GG8142@atomide.com>
References: <200409061836.21505.rjw@sisk.pl> <200409062123.08476.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409062123.08476.rjw@sisk.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rafael J. Wysocki <rjw@sisk.pl> [040906 12:31]:
> On Monday 06 of September 2004 18:36, Rafael J. Wysocki wrote:
> > Pavel,
> > 
> > Can you tell me, please, if swsusp, as in the 2.6.9-rc1-bk12 kernel, is 
> > supposed to work on x86-64-based systems (specifically, with the nforce3 
> > chipset)?
> 
> Anyway, on such a system (.config and the output of dmesg are attached), I get 
> the following:
> 
> Stopping tasks: 
> ==============================================================|
> Freeing 
> memory: ............................................................................................................|
> Suspending devices... /critical section: counting pages to copy..[nosave pfn 
> 0x59b]..................................................)
> Alloc pagedir
> ..[nosave pfn 
> 0x59b]................................................................................critical 
> section/: done (40890 pa)
> APIC error on CPU0: 80(08)
> 

Just FYI, swsusp works nicely here on my m6805 laptop :)

Tony
