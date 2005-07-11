Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbVGKX6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVGKX6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 19:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVGKUSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 16:18:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45321 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262570AbVGKURK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:17:10 -0400
Date: Mon, 11 Jul 2005 21:17:06 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alex Williamson <alex.williamson@hp.com>
Cc: David Vrabel <dvrabel@arcom.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: serial: 8250 fails to detect Exar XR16L2551 correctly
Message-ID: <20050711211706.E1540@flint.arm.linux.org.uk>
Mail-Followup-To: Alex Williamson <alex.williamson@hp.com>,
	David Vrabel <dvrabel@arcom.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <42CA96FC.9000708@arcom.com> <20050706195740.A28758@flint.arm.linux.org.uk> <42CD2C16.1070308@arcom.com> <1121108408.28557.71.camel@tdi> <20050711204646.D1540@flint.arm.linux.org.uk> <1121112057.28557.91.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1121112057.28557.91.camel@tdi>; from alex.williamson@hp.com on Mon, Jul 11, 2005 at 02:00:57PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 02:00:57PM -0600, Alex Williamson wrote:
> On Mon, 2005-07-11 at 20:46 +0100, Russell King wrote:
> > There was a bug in this area - does it happen with latest and greatest
> > kernels?
> 
>    Yes, I'm using a git pull from ~5hrs ago.  How recent was the bug
> fix?  It worked fine before I applied David's patch, the A2 UART was
> detected as a 16550A.  Thanks,

The fix for this went in on 21st May 2005, so obviously it's not
actually fixed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
