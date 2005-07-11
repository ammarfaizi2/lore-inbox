Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262751AbVGKVT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262751AbVGKVT1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 17:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVGKVRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 17:17:07 -0400
Received: from cpe-24-93-204-161.neo.res.rr.com ([24.93.204.161]:22404 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262693AbVGKVP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 17:15:56 -0400
Date: Mon, 11 Jul 2005 17:08:34 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in pcmcia-core
Message-ID: <20050711210834.GA4898@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	James Courtier-Dutton <James@superbug.demon.co.uk>,
	linux-kernel@vger.kernel.org
References: <42B1FF2A.2080608@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B1FF2A.2080608@superbug.demon.co.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 11:37:30PM +0100, James Courtier-Dutton wrote:
> Hi,
> 
> I have tried conacting the mailing list for the PCMCIA subsystem in
> Linux, but no-one seems to respond.
> 
> PCMCIA SUBSYSTEM
> L:      http://lists.infradead.org/mailman/listinfo/linux-pcmcia
> S:      Unmaintained
> 
> I am trying to write a Linux ALSA driver for the Creative Audigy 2 NX
> Notebook PCMCIA card.
> This is a cardbus card, that uses ioports.
> When it is inserted into the laptop, the entry appears in "lspci -vv "
> showing ioports used by the card.
> As soon as my driver uses "outb()" to anything in the address range
> shown in "lspci -vv" , the PC hangs.
> 
> I can only conclude from this that ioport resources are not being
> allocated correctly to the PCMCIA card.

It's possible.

> 
> Can anybody help me track this down. If someone could tell me which
> PCMCIA and PCI registers should be set for it to work, I could then find
> out which pcmcia registers have not been set correctly, and fix the bug.
> 
> It seems that the PCMCIA specification is not open and free, so I cannot
> refer to it in order to fix this myself.
> 
> Can anybody help me?
> 
> James

Please provide more information.  /proc/ioports, lspci -vv, the ranges
assigned to your driver, and your driver code if it's available.  I'll try
to look into the problem.

Thanks,
Adam
