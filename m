Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWHQUaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWHQUaH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 16:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWHQUaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 16:30:06 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:50703 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030257AbWHQUaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 16:30:01 -0400
Date: Thu, 17 Aug 2006 21:29:54 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: ip3106_uart oddity
Message-ID: <20060817202954.GC28474@flint.arm.linux.org.uk>
Mail-Followup-To: Vitaly Wool <vitalywool@gmail.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org
References: <20060817182948.0381306c.vitalywool@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060817182948.0381306c.vitalywool@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 06:29:48PM +0400, Vitaly Wool wrote:
> it looks like drivers/serial/ip3106_uart.c was dropped from the
> mainline at some point I couldn't identify. Can you please confirm
> that?

I am not aware of its addition nor removal of this file.  There was
au1x00_uart.c at one time.

> I'd like to take the burden of restoring the UART functionality for
> PNX8550 boards in the mainline. This very UART HW is very weird and
> doesn't fit well into 8250 model, even with fixups like those that
> were introduced for Alchemy. It also differs from the IP_3106-based
> UARTs used on Philips ARM targets in registers layout so I'm not
> sure it's correct to call it ip3106_uart.
> So, given the above, does it make sense to try make it fir into
> standard 8250 driver model or restore/rework the custom driver?

No real clue.  Is it similar to any other drivers?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
