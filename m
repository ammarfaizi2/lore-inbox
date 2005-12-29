Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbVL2IDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbVL2IDW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 03:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVL2IDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 03:03:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56497 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932588AbVL2IDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 03:03:21 -0500
Date: Thu, 29 Dec 2005 03:02:42 -0500
From: Dave Jones <davej@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051229080242.GD3652@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ingo Molnar <mingo@elte.hu>, Krzysztof Halasa <khc@pm.waw.pl>,
	Linus Torvalds <torvalds@osdl.org>,
	Arjan van de Ven <arjan@infradead.org>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
	Matt Mackall <mpm@selenic.com>
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <m3fyoc4vye.fsf@defiant.localdomain> <20051229074107.GB20177@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229074107.GB20177@elte.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 08:41:07AM +0100, Ingo Molnar wrote:
 > 
 > * Krzysztof Halasa <khc@pm.waw.pl> wrote:
 > 
 > > Ingo Molnar <mingo@elte.hu> writes:
 > > 
 > > >>    gcc version 4.0.2 20051109 (Red Hat 4.0.2-6)
 > > 
 > > > another thing: i wanted to decrease the size of -Os 
 > > > (CONFIG_CC_OPTIMIZE_FOR_SIZE) kernels, which e.g. Fedora uses too (to 
 > > > keep the icache footprint down).
 > > 
 > > Remember the above gcc miscompiles the x86-32 kernel with -Os:
 > > 
 > > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=173764
 > 
 > i'm not sure what the point is. There was no sudden rush of -Os related 
 > bugs when Fedora switched to it for the kernel, and the 35% code-size 
 > savings were certainly worth it in terms of icache footprint. Yes, -Os 
 > is a major change for how the compiler works, and the kernel is a major 
 > piece of software.

The bug referenced is also fixed in gcc 4.1

		Dave

