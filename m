Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVA1OcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVA1OcD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 09:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVA1OcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 09:32:03 -0500
Received: from news.suse.de ([195.135.220.2]:35752 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261408AbVA1OaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 09:30:11 -0500
Date: Fri, 28 Jan 2005 15:30:10 +0100
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH] Add CONFIG_X86_APIC_OFF for i386/UP
Message-ID: <20050128143010.GE6703@wotan.suse.de>
References: <20050128133927.GC6703@wotan.suse.de> <Pine.LNX.4.61.0501281421410.7109@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501281421410.7109@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm confused!  Why do we need X86_APIC_OFF config option (but code
> compiled in), with boot options "apic" or "lapic" to enable it,
> when we already have the code compiled in, with boot options
> "noapic" or "nolapic" to disable it?

As you said. The distribution wants a kernel that has it disabled
by default, but allows to enable it with an option without 
recompiling the kernel.

None of the defaults allow this and my patch adds that with
an option.

-Andi
