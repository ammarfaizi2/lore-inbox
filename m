Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbUDENUG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 09:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUDENUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 09:20:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27408 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262353AbUDENUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 09:20:02 -0400
Date: Mon, 5 Apr 2004 14:19:57 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: Re: drivers/char/dz.[ch]: reason for keeping?
Message-ID: <20040405141957.B31724@flint.arm.linux.org.uk>
Mail-Followup-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>
References: <20040404101241.A10158@flint.arm.linux.org.uk> <Pine.LNX.4.55.0404051504080.31851@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.55.0404051504080.31851@jurand.ds.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Apr 05, 2004 at 03:15:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 03:15:33PM +0200, Maciej W. Rozycki wrote:
> On Sun, 4 Apr 2004, Russell King wrote:
> 
> > Since we have drivers/serial/dz.[ch] now merged, is there a reason to
> > keep drivers/char/dz.[ch] around any more?  I notice people keep doing
> > cleanups, but this is wasted effort if the driver is superseded by the
> > new drivers/serial/dz.[ch] driver.
> 
>  drivers/char/dz.[ch] has been verified to work on real hardware, at least 
> with 2.4.  Can the same be said of drivers/serial/dz.[ch]?  If so, then 
> the former can be removed from the mainline.

Ralf has verified that it works before he submitted it to Linus, so
I guess that means that it does "work on real hardware".

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
