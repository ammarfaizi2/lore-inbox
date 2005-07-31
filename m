Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVGaHJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVGaHJH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 03:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVGaHJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 03:09:07 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21772 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261742AbVGaHJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 03:09:05 -0400
Date: Sun, 31 Jul 2005 08:08:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dave Airlie <airlied@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: S3 resume and PNP (was: Re: S3 resume and serial console..)
Message-ID: <20050731080859.A5580@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Airlie <airlied@gmail.com>,
	Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0507300301370.13092@skynet> <20050730085558.A7770@flint.arm.linux.org.uk> <21d7e99705073017295ed29c64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <21d7e99705073017295ed29c64@mail.gmail.com>; from airlied@gmail.com on Sun, Jul 31, 2005 at 10:29:58AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2005 at 10:29:58AM +1000, Dave Airlie wrote:
> latest Linus git tree, and it just does the usual entering suspend and
> then when I resume I get crap out of the serial port, nothing at all
> intelliigble...
> 
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> 
> And as I said its an i865 based motherboard from Intel... nothing
> special on it, do you need to know the super-io chip, i.e. I 'll have
> to open the case to find out...

The above two messages tells me you're probably using plug'n'play.
Unfortunately, for some unknown reason, the Linux plug'n'play
subsystem does not support suspend/resume.  This is not a serial
problem.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
