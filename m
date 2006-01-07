Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030503AbWAGQqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbWAGQqq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 11:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbWAGQqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 11:46:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49937 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030503AbWAGQqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 11:46:45 -0500
Date: Sat, 7 Jan 2006 16:46:39 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Xavier Bestel <xavier.bestel@free.fr>,
       Jason Dravet <dravet@hotmail.com>
Subject: Re: wrong number of serial port detected
Message-ID: <20060107164639.GG31384@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, Xavier Bestel <xavier.bestel@free.fr>,
	Jason Dravet <dravet@hotmail.com>
References: <20051207155034.GB6793@flint.arm.linux.org.uk> <BAY103-F32F90C9849D407E9336826DF430@phx.gbl> <20051207211551.GL6793@flint.arm.linux.org.uk> <1133990886.6184.2.camel@bip.parateam.prv> <20051207213128.GM6793@flint.arm.linux.org.uk> <20051207213856.GN6793@flint.arm.linux.org.uk> <20051207230302.GD22690@redhat.com> <20051207234603.GQ6793@flint.arm.linux.org.uk> <20051208005040.GB3664@redhat.com> <20051208030916.GC14569@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208030916.GC14569@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 10:09:16PM -0500, Dave Jones wrote:
> Make the number of UARTs registered configurable.
> Also add a nr_uarts module option to the 8250 code
> to override this, up to a maximum of CONFIG_SERIAL_8250_NR_UARTS
> 
> This should appease people who complain about a proliferation
> of /dev/ttyS & /sysfs nodes whilst at the same time allowing
> a single kernel image to support the rarer occasions of
> lots of devices.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>

Any chance of an updated patch please?  It doesn't appear to be
healthy:

patching file drivers/serial/8250.c
Hunk #1 succeeded at 54 (offset 1 line).
Hunk #2 succeeded at 2119 (offset 70 lines).
Hunk #3 succeeded at 2069 (offset 1 line).
Hunk #4 succeeded at 2160 (offset 70 lines).
Hunk #5 succeeded at 2194 (offset 3 lines).
Hunk #6 succeeded at 2297 with fuzz 2 (offset 70 lines).
Hunk #7 succeeded at 2352 with fuzz 1 (offset 1 line).
misordered hunks! output would be garbled
Hunk #8 FAILED at 2421.
Hunk #9 succeeded at 2381 with fuzz 2 (offset -3 lines).
Hunk #10 succeeded at 2492 (offset 69 lines).
Hunk #11 succeeded at 2429 (offset -3 lines).
Hunk #12 succeeded at 2510 (offset 69 lines).
Hunk #13 succeeded at 2523 (offset -3 lines).
Hunk #14 succeeded at 2659 (offset 69 lines).
1 out of 14 hunks FAILED -- saving rejects to file drivers/serial/8250.c.rej
patching file drivers/serial/Kconfig
patching file Documentation/kernel-parameters.txt

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
