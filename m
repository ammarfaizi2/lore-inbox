Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbTJTO46 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 10:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbTJTO46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 10:56:58 -0400
Received: from svxf1a001p.gps.infracom.it ([217.12.180.1]:20464 "EHLO
	smtp1.infracom.it") by vger.kernel.org with ESMTP id S262592AbTJTO44
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 10:56:56 -0400
Date: Mon, 20 Oct 2003 17:00:29 +0200
From: Antonio Dolcetta <adolcetta@infracom.it>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8-mm1
Message-Id: <20031020170029.578b1b7a.adolcetta@infracom.it>
In-Reply-To: <1066656160.4180.3.camel@localhost>
References: <20031020020558.16d2a776.akpm@osdl.org>
	<1066656160.4180.3.camel@localhost>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Oct 2003 14:22:40 +0100
Jonathan Brown <jbrown@emergence.uk.net> wrote:

> On Mon, 2003-10-20 at 10:05, Andrew Morton wrote: 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test8/2.6.0-test8-mm1
> > 
> > 
> > . Included a much updated fbdev patch.  Anyone who is using framebuffers,
> >   please test this.
> 
> radeon fb is completely broken. Previously I would get multicoloured
> garbled text under the penguin over all characters that were visible
> before radeon fb loaded, but this would scroll away. Now i still get the
> garbled screen, but every character on the screen has an extra white
> pixel on producing a grid effect. The kernel then oppses.
> 
> This is with a Radeon Mobility M6 LY.
> 
>

Working perfectly here with radeon 9000

I start it without passing any option to the kernel and it guesses the
correct resolution from BIOS (laptop)

radeonfb_pci_register BEGIN
radeonfb: probed DDR SGRAM 65536k videoram
radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: ref_clk=2700, ref_div=67, xclk=16600 defaults
Starting monitor auto detection...
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: Asssuming panel size 1400x1050
radeonfb: ATI Radeon Lf Mobility M9 DDR SGRAM 64 MB
radeonfb_pci_register END


this is actually the first time the radeon framebuffer has worked for me
that's great!

-- 
	Antonio Dolcetta
