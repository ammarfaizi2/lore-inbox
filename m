Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268739AbUIXNgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268739AbUIXNgK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 09:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268745AbUIXNgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 09:36:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61708 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268739AbUIXNgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 09:36:07 -0400
Date: Fri, 24 Sep 2004 14:36:02 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Vrabel <dvrabel@arcom.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: New 8250 device -- XR16550.
Message-ID: <20040924143602.A11325@flint.arm.linux.org.uk>
Mail-Followup-To: David Vrabel <dvrabel@arcom.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <4153DBA3.5080507@arcom.com> <4153E20B.3020406@arcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4153E20B.3020406@arcom.com>; from dvrabel@arcom.com on Fri, Sep 24, 2004 at 09:59:55AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 09:59:55AM +0100, David Vrabel wrote:
> David Vrabel wrote:
> > 
> > This adds support for the two 16550 compatible UARTs in an Exar 
> > XR16L2551 chip to the 8250 driver.
> 
> Oops.  Meant to send this to the linux-serial list instead.

I'm glad you didn't because I wouldn't have seen it.  The patch looks
good as it stands.

I'm trying to move the 8250 driver away from "port types" and more
towards port capabilities, and this seems to fit nicely into that
model.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
