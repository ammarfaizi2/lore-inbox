Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267452AbUIFUca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267452AbUIFUca (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 16:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267542AbUIFUca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 16:32:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10382 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267452AbUIFUc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 16:32:29 -0400
Date: Mon, 6 Sep 2004 22:32:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: swsusp on x86-64 w/ nforce3
Message-ID: <20040906203228.GA18105@atrey.karlin.mff.cuni.cz>
References: <200409061836.21505.rjw@sisk.pl> <200409062123.08476.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409062123.08476.rjw@sisk.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

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

Try noapic?
										Pavel
