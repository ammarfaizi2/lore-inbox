Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVA1Rx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVA1Rx3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 12:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVA1Rwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 12:52:49 -0500
Received: from fsmlabs.com ([168.103.115.128]:33474 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261503AbVA1Rnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 12:43:46 -0500
Date: Fri, 28 Jan 2005 10:43:42 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH] Add CONFIG_X86_APIC_OFF for i386/UP
In-Reply-To: <20050128151839.GI6703@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0501281038480.22906@montezuma.fsmlabs.com>
References: <20050128133927.GC6703@wotan.suse.de>
 <Pine.LNX.4.61.0501281421410.7109@goblin.wat.veritas.com>
 <20050128143010.GE6703@wotan.suse.de> <Pine.LNX.4.61.0501281506100.7207@goblin.wat.veritas.com>
 <20050128151839.GI6703@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005, Andi Kleen wrote:

> > Forgive me for not wading through the code, but it really needs to
> > be spelt out in the comments: what's wrong with the existing kernel,
> > with "noapic nolapic" in the distro's bootstring by default?
> 
> It's harder to explain and traditionally in LILO you couldn't remove
> any options (in grub you can now). I think it makes much more sense
> to have an positive option for this too, not a negative one. 

Well new distributions with 2.6 most probably aren't using LILO and if 
you're running 2.6 with some ancient distro you can add commandline 
options yourself.

> Also I must add my patch fixes real bugs in the code, not just
> adding the new option.

Please seperate them then.

> > I'm not going to be the only one confused by this!
> 
> I think there is much more confusion in the current way.

I'm going to claim confusion over this one too.

Thanks,
	Zwane

