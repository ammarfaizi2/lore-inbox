Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWKDOGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWKDOGO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 09:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbWKDOGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 09:06:14 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:56078 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932288AbWKDOGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 09:06:13 -0500
Date: Sat, 4 Nov 2006 14:06:00 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: lib/iomap.c mmio_{in,out}s* vs. __raw_* accessors
Message-ID: <20061104140559.GC19760@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paul Mackerras <paulus@samba.org>
References: <1162626761.28571.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162626761.28571.14.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2006 at 06:52:41PM +1100, Benjamin Herrenschmidt wrote:
> In fact, I would be very very very much in favor of, instead of the
> above, defining a set of:
> 
> readsb, readsw, readsl, readsq
> writesb, writesw, writesl, writesq

ARM already has these.  Sounds like a good idea for everyone else to also
implement them. 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
