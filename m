Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVAJJ4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVAJJ4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 04:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVAJJ4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 04:56:30 -0500
Received: from gprs215-6.eurotel.cz ([160.218.215.6]:23425 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262024AbVAJJ43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 04:56:29 -0500
Date: Mon, 10 Jan 2005 10:55:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] ACPI using smp_processor_id in preemptible code
Message-ID: <20050110095508.GJ1353@elf.ucw.cz>
References: <16A54BF5D6E14E4D916CE26C9AD30575F05409@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575F05409@pdsmsx402.ccr.corp.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I enabled CPU hotplug and preemptible debugging... now I get...
> >
> >BUG: using smp_processor_id() in preemptible [00000001] code:
> >swapper/0
> >caller is acpi_processor_idle+0xb/0x235
> > [<c020ba28>] smp_processor_id+0xa8/0xc0
> > [<c02338ce>] acpi_processor_idle+0xb/0x235
> > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > [<c02338ce>] acpi_processor_idle+0xb/0x235
> > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > [<c0101115>] cpu_idle+0x75/0x110
> > [<c04f5988>] start_kernel+0x158/0x180
> > [<c04f5390>] unknown_bootoption+0x0/0x1e0
> It doesn't trouble to me. It's in idle thread.

You mean it does not happen to you? On my machine it fills logs very
quickly...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
