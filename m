Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbUDDLaH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 07:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbUDDLaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 07:30:07 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10500 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262293AbUDDLaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 07:30:02 -0400
Date: Sun, 4 Apr 2004 12:29:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: Re: drivers/char/dz.[ch]: reason for keeping?
Message-ID: <20040404122958.A14991@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>
References: <20040404101241.A10158@flint.arm.linux.org.uk> <20040404111712.GE27362@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040404111712.GE27362@lug-owl.de>; from jbglaw@lug-owl.de on Sun, Apr 04, 2004 at 01:17:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2004 at 01:17:12PM +0200, Jan-Benedict Glaw wrote:
> The VAX port also (still) uses a modified version of the d/c/dz.[ch]
> driver. Also, the MIPS guys may have some outstanding patches...

It is my understanding that the MIPS people are happy with the new
dz.c, since I passed it to them to test and submit.  Since they
submitted it, I think we can assume that they're happy.

So we just need the VAX people to confirm that the new driver works
for them, and then for _someone_ to remove the old driver (either
the MIPS or the VAX people.)

> While at it, I've already implemented some SERIO changes. That'll allow
> the dz.c driver to announce that it waits for LK-style keyboard on one
> port and VSXXX-style mouse/digitizer on the 2nd port...

Which dz.c ? 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
