Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbUBXQi0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 11:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbUBXQi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 11:38:26 -0500
Received: from bolt.sonic.net ([208.201.242.18]:4231 "EHLO bolt.sonic.net")
	by vger.kernel.org with ESMTP id S262277AbUBXQiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 11:38:23 -0500
Date: Tue, 24 Feb 2004 08:38:01 -0800
From: David Hinds <dhinds@sonic.net>
To: daniel.ritz@gmx.ch, Pavel Roskin <proski@gnu.org>,
       Andrew Morton <akpm@osdl.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] yenta: irq-routing for TI bridges
Message-ID: <20040224163801.GA3398@sonic.net>
References: <200402240033.31042.daniel.ritz@gmx.ch> <200402240132.31659.daniel.ritz@gmx.ch> <Pine.LNX.4.58.0402231947520.30747@marabou.research.att.com> <200402241259.50046.daniel.ritz@alcatel.ch> <20040224124011.A30975@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040224124011.A30975@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 12:40:11PM +0000, Russell King wrote:
> 
> Not true.  It has parallel ISA interrupts _and_ parallel PCI interrupts.
> It's a TI 1250.  Unfortunately, the 1250 data sheet isn't available,
> however there seems to be some consistency in the device codes to
> features offered.

I have a TI 1250 data sheet (well 1250A, which is what I think you
actually have).

> The 1450 and 1251A (both of which seem similar to 1250) has separate pins
> for PCI parallel interrupts which are outside the control of the "IRQMUX"
> register.  When these pins are not used for parallel PCI interrupts,
> they function as "GPIO3" and "IRQSER" (for PCI serial interrupts)
> respectively.  The function of these pins is controlled by the device
> control register.

The 1250A is the same.

-- Dave
