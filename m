Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318310AbSGXXoH>; Wed, 24 Jul 2002 19:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318309AbSGXXoH>; Wed, 24 Jul 2002 19:44:07 -0400
Received: from pop016pub.verizon.net ([206.46.170.173]:27317 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S318308AbSGXXoF>; Wed, 24 Jul 2002 19:44:05 -0400
Message-Id: <200207242355.g6ONtDQb001653@pool-141-150-241-241.delv.east.verizon.net>
Date: Wed, 24 Jul 2002 19:55:09 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.28
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com> <20020724234344.I25115@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020724234344.I25115@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Jul 24, 2002 at 11:43:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> [snip]
> Any problems relating to the serial changes should be forwarded to me.

I had to export these 2 funcs.

--- linux/drivers/serial/core.c~	Wed Jul 24 19:47:04 2002
+++ linux/drivers/serial/core.c	Wed Jul 24 19:47:06 2002
@@ -2469,6 +2469,8 @@
 EXPORT_SYMBOL(uart_unregister_driver);
 EXPORT_SYMBOL(uart_register_port);
 EXPORT_SYMBOL(uart_unregister_port);
+EXPORT_SYMBOL(uart_add_one_port);
+EXPORT_SYMBOL(uart_remove_one_port);
 
 MODULE_DESCRIPTION("Serial driver core");
 MODULE_LICENSE("GPL");

-- 
Skip
