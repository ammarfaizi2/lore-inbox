Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265754AbUADQ1E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 11:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265755AbUADQ1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 11:27:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51216 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265754AbUADQ1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 11:27:01 -0500
Date: Sun, 4 Jan 2004 16:26:54 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adam Belay <ambx1@neo.rr.com>, Amit Gurdasani <amitg@alumni.cmu.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: EISA ID for PnP modem and resource allocation
Message-ID: <20040104162654.A27227@flint.arm.linux.org.uk>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Amit Gurdasani <amitg@alumni.cmu.edu>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0312261610200.1798@athena> <20031229143711.GA3176@neo.rr.com> <Pine.LNX.4.56.0312300338360.1163@athena> <20031229225037.GB3198@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031229225037.GB3198@neo.rr.com>; from ambx1@neo.rr.com on Mon, Dec 29, 2003 at 10:50:37PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 10:50:37PM +0000, Adam Belay wrote:
> > ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
> > ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> > ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
> > parport0: irq 7 detected
> 
> Hmm, it shouldn't be reporting irq 0.  The probbing code may be confused.
> I would guess it is on irq 4.

irq0 on x86 means "I'll use polled mode".

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
