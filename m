Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVBPXUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVBPXUm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 18:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVBPXUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 18:20:41 -0500
Received: from gprs214-36.eurotel.cz ([160.218.214.36]:59799 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262122AbVBPXU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 18:20:28 -0500
Date: Thu, 17 Feb 2005 00:20:10 +0100
From: Pavel Machek <pavel@suse.cz>
To: John M Flinchbaugh <john@hjsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4: oops in swsusp
Message-ID: <20050216232010.GB3865@elf.ucw.cz>
References: <20050214161944.GA24147@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214161944.GA24147@butterfly.hjsoft.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> i saw the following oops when trying to swsusp (echo disk >
> /sys/power/state) my thinkpad r40.  everything worked fine, except for
> this debug message:
> Stopping tasks:
> =================================================================================================================================================================|
> Freeing memory... done (101637 pages freed)
> swsusp: Need to copy 13308 pages
> Debug: sleeping function called from invalid context at mm/slab.c:2082
> in_atomic():0, irqs_disabled():1
>  [<c01035a7>] dump_stack+0x17/0x20
>  [<c0113f3c>] __might_sleep+0xac/0xc0
>  [<c013c66e>] kmem_cache_alloc+0x5e/0x60
>  [<c0201899>] acpi_pci_link_set+0x44/0x1a1
>  [<c0201d38>] irqrouter_resume+0x1f/0x34

ACPI problem, ask on ACPI lists.. Oh and do it without your .config.
									Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
