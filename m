Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265611AbUBBExP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 23:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265617AbUBBExP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 23:53:15 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:39297 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265611AbUBBExM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 23:53:12 -0500
Date: Sun, 1 Feb 2004 23:37:39 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Amit Gurdasani <amitg@alumni.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EISA ID for PnP modem and resource allocation
Message-ID: <20040201233739.GB3145@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Amit Gurdasani <amitg@alumni.cmu.edu>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0312261610200.1798@athena> <20031229143711.GA3176@neo.rr.com> <Pine.LNX.4.56.0312300338360.1163@athena> <20031229225037.GB3198@neo.rr.com> <20040104162654.A27227@flint.arm.linux.org.uk> <Pine.LNX.4.56.0401051713370.4783@athena.localdomain> <20040126192204.GA7280@neo.rr.com> <Pine.LNX.4.58.0401291043370.1164@athena.localdomain> <20040130002602.GA13308@neo.rr.com> <Pine.LNX.4.58.0401301539410.1201@athena.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401301539410.1201@athena.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 03:55:13PM +0400, Amit Gurdasani wrote:
> :> It doesn't seem that the printk was ever called. Here are dmesg outputs with
> :> and without isapnptools capturing an IRQ for the ISA modem. (I'm using
> :> loadlin from DOS to boot Linux, incidentally. Would that make any
> :> difference?)
> :>
> :
> :Hmm, it looks like something strange is going on.  Perhaps the serial driver
> :isn't matching to the device.
> 
> Well, it's certainly able to identify the device as a serial device. (I've
> sent this message using the modem over a regular PPP link . . .)
> 

Thanks for the information.

I was woried that the pnpbios wasn't reporting the correct resources but
everything looks ok.  I would imagine when that one of the serial ports
is set to irq 0 because the other is set to 4 through isapnp.

Thanks,
Adam
