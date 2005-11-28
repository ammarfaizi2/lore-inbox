Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbVK1WRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVK1WRg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 17:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVK1WRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 17:17:36 -0500
Received: from gate.crashing.org ([63.228.1.57]:30114 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751278AbVK1WRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 17:17:35 -0500
Subject: Re: [PATCH] serial: Fix matching of MMIO ports
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051128221229.GF14557@flint.arm.linux.org.uk>
References: <1133212269.7768.220.camel@gaston>
	 <20051128221229.GF14557@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 09:11:36 +1100
Message-Id: <1133215896.7768.225.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-28 at 22:12 +0000, Russell King wrote:
> On Tue, Nov 29, 2005 at 08:11:08AM +1100, Benjamin Herrenschmidt wrote:
> > The function uart_match_port() incorrectly compares the ioremap'd
> > virtual addresses of ports instead of the physical address to find
> > duplicate ports for MMIO based UARTs. This fixes it.
> 
> I'd like this to go in -mm for a bit before we put it into mainline,
> just in case there's any undesirable side effects.

Fine with me.

Ben.


