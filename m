Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVA1PSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVA1PSt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 10:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVA1PSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 10:18:49 -0500
Received: from cantor.suse.de ([195.135.220.2]:35801 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261446AbVA1PSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 10:18:44 -0500
Date: Fri, 28 Jan 2005 16:18:39 +0100
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH] Add CONFIG_X86_APIC_OFF for i386/UP
Message-ID: <20050128151839.GI6703@wotan.suse.de>
References: <20050128133927.GC6703@wotan.suse.de> <Pine.LNX.4.61.0501281421410.7109@goblin.wat.veritas.com> <20050128143010.GE6703@wotan.suse.de> <Pine.LNX.4.61.0501281506100.7207@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501281506100.7207@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Forgive me for not wading through the code, but it really needs to
> be spelt out in the comments: what's wrong with the existing kernel,
> with "noapic nolapic" in the distro's bootstring by default?

It's harder to explain and traditionally in LILO you couldn't remove
any options (in grub you can now). I think it makes much more sense
to have an positive option for this too, not a negative one. 

Also I must add my patch fixes real bugs in the code, not just
adding the new option.

> I'm not going to be the only one confused by this!

I think there is much more confusion in the current way.

-Andi
