Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTJQJTW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 05:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbTJQJTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 05:19:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57872 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263357AbTJQJTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 05:19:21 -0400
Date: Fri, 17 Oct 2003 10:19:16 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
Message-ID: <20031017101916.B24238@flint.arm.linux.org.uk>
Mail-Followup-To: Anton Blanchard <anton@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org
References: <20031009174604.GC7665@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0310091049150.22318-100000@home.osdl.org> <20031015171411.GH610@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031015171411.GH610@krispykreme>; from anton@samba.org on Thu, Oct 16, 2003 at 03:14:11AM +1000
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 03:14:11AM +1000, Anton Blanchard wrote:
> >From memory at least x86, alpha, ppc32 and ppc64 worked with Andrey's
> irq consolidation patches. I'll be pushing for it in 2.7 together with
> some macros to abstract away irq_desc[NR_IRQS] completely. (it will
> make it easier to support 24 bit irqs on ppc64 and should allow sparc64
> to use the consolidated irq code).

(CC list snipped)

>From what I heard, benh was seriously considering changing ppc64 IRQ
stuff in 2.7 to use something like the system we have in ARM.

benh?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
