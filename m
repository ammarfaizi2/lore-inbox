Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTFPPHx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 11:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbTFPPHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 11:07:53 -0400
Received: from ns.suse.de ([213.95.15.193]:55565 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263945AbTFPPHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 11:07:52 -0400
Date: Mon, 16 Jun 2003 17:21:45 +0200
From: Andi Kleen <ak@suse.de>
To: mikpe@csd.uu.se
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.71] fix x86-64 nmi.c oops on Simics
Message-ID: <20030616152145.GF26583@wotan.suse.de>
References: <16109.56898.422086.822671@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16109.56898.422086.822671@gargle.gargle.HOWL>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 05:12:02PM +0200, mikpe@csd.uu.se wrote:
> Andi,
> 
> In 2.5, x86-64's nmi.c will semi-enable the local APIC NMI watchdog
> on Simics, which leads to a kernel oops if disable_lapic_nmi_watchdog()
> is called. The reason is:

Thanks. I used to test for Simics explicitely by checking the cpuid
name for "ScrewDriver" in other places. I think I will do this here too.

-Andi
