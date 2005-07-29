Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262566AbVG2KcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbVG2KcX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 06:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVG2KcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 06:32:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32784 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262566AbVG2KcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 06:32:17 -0400
Date: Fri, 29 Jul 2005 11:32:05 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-serial@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SERIAL: add MMIO support to 8250_pnp
Message-ID: <20050729113205.D10345@flint.arm.linux.org.uk>
Mail-Followup-To: Bjorn Helgaas <bjorn.helgaas@hp.com>,
	Andrew Morton <akpm@osdl.org>, linux-serial@vger.kernel.org,
	Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org
References: <200507271647.12882.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200507271647.12882.bjorn.helgaas@hp.com>; from bjorn.helgaas@hp.com on Wed, Jul 27, 2005 at 04:47:12PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 04:47:12PM -0600, Bjorn Helgaas wrote:
> Add support for UARTs in MMIO space and clean up a little whitespace.
> 
> HP legacy-free ia64 machines need this.

Due to the restrictions caused by the new new kernel development model,
I'm unable to merge this for 2.6.13.  I already have other stuff already
queued in my serial tree which probably isn't suitable for merging.

If someone else (Andrew or Adam) wishes to merge this then fine - it
looks reasonable.  Let me know what you're doing so I know whether to
add it to my serial tree or not.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
