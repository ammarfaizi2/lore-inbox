Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVA1PLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVA1PLW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 10:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVA1PLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 10:11:22 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:19689 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261434AbVA1PKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 10:10:03 -0500
Date: Fri, 28 Jan 2005 15:09:32 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH] Add CONFIG_X86_APIC_OFF for i386/UP
In-Reply-To: <20050128143010.GE6703@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0501281506100.7207@goblin.wat.veritas.com>
References: <20050128133927.GC6703@wotan.suse.de> 
    <Pine.LNX.4.61.0501281421410.7109@goblin.wat.veritas.com> 
    <20050128143010.GE6703@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005, Andi Kleen wrote:
> > I'm confused!  Why do we need X86_APIC_OFF config option (but code
> > compiled in), with boot options "apic" or "lapic" to enable it,
> > when we already have the code compiled in, with boot options
> > "noapic" or "nolapic" to disable it?
> 
> As you said. The distribution wants a kernel that has it disabled
> by default, but allows to enable it with an option without 
> recompiling the kernel.
> 
> None of the defaults allow this and my patch adds that with
> an option.

Forgive me for not wading through the code, but it really needs to
be spelt out in the comments: what's wrong with the existing kernel,
with "noapic nolapic" in the distro's bootstring by default?

I'm not going to be the only one confused by this!

Hugh
