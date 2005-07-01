Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263234AbVGAKxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263234AbVGAKxg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 06:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263305AbVGAKxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 06:53:35 -0400
Received: from mx1.suse.de ([195.135.220.2]:20444 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S263234AbVGAKxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 06:53:32 -0400
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ISA DMA suspend for x86_64
References: <42987450.9000601@drzeus.cx.suse.lists.linux.kernel>
	<1117288285.2685.10.camel@localhost.localdomain.suse.lists.linux.kernel>
	<42A2B610.1020408@drzeus.cx.suse.lists.linux.kernel>
	<42A3061C.7010604@drzeus.cx.suse.lists.linux.kernel>
	<42B1A08B.8080601@drzeus.cx.suse.lists.linux.kernel>
	<20050616170622.A1712@flint.arm.linux.org.uk.suse.lists.linux.kernel>
	<42C3A698.9020404@drzeus.cx.suse.lists.linux.kernel>
	<1120130926.6482.83.camel@localhost.localdomain.suse.lists.linux.kernel>
	<42C3E3A4.3090305@drzeus.cx.suse.lists.linux.kernel>
	<42C432BB.407@drzeus.cx.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 01 Jul 2005 12:53:31 +0200
In-Reply-To: <42C432BB.407@drzeus.cx.suse.lists.linux.kernel>
Message-ID: <p73u0jeg5lg.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman <drzeus-list@drzeus.cx> writes:

> Reset the ISA DMA controller into a known state after a suspend. Primary
> concern was reenabling the cascading DMA channel (4).
> 
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> 
> Word of warning, I haven't tested this platform since I don't have any
> x86_64 hardware. But it shouldn't differ from i386.

This is identical to the i386 version isn't it? 
Please just reuse the i386 version then in the Makefile.

And the whole thing should be probably dependent on CONFIG_SOFTWARE_SUSPEND

-Andi
