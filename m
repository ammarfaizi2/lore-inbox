Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTFGWrz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 18:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263938AbTFGWrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 18:47:55 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:6274
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263922AbTFGWrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 18:47:55 -0400
Date: Sat, 7 Jun 2003 18:50:08 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Russell King <rmk@arm.linux.org.uk>
cc: Anton Blanchard <anton@samba.org>, "" <linux-kernel@vger.kernel.org>
Subject: Re: irq consolidation
In-Reply-To: <20030607101848.A22665@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.50.0306070539200.8902-100000@montezuma.mastecende.com>
References: <20030607040515.GB28914@krispykreme> <20030607044803.GE28914@krispykreme>
 <20030607101848.A22665@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jun 2003, Russell King wrote:

> On Sat, Jun 07, 2003 at 02:48:03PM +1000, Anton Blanchard wrote:
> > We are hoping to kill irq_desc[NR_IRQS] completely and instead allocate
> > them on demand with some sort of hash to map an interrupt number to an
> > irq_desc.

Anton don't you have an NR_IRQS sized interrupt stub you have to deal 
with on PPC64?

I was considering perhaps only statically allocating the 0-15 on i386 
just to get it booting and then dynamically allocate the rest.

	Zwane
--
function.linuxpower.ca
