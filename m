Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTI0H2M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 03:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbTI0H2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 03:28:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6404 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262400AbTI0H2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 03:28:11 -0400
Date: Sat, 27 Sep 2003 08:28:06 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Ejecting a CardBus device
Message-ID: <20030927082806.A681@flint.arm.linux.org.uk>
Mail-Followup-To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <1064628015.1393.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1064628015.1393.5.camel@teapot.felipe-alfaro.com>; from felipe_alfaro@linuxmail.org on Sat, Sep 27, 2003 at 04:00:16AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 27, 2003 at 04:00:16AM +0200, Felipe Alfaro Solana wrote:
> How can I tell the CardBus subsystem to eject my CardBus NIC by software
> with 2.6.0 kernels? In 2.4 I could use "cardctl eject", but I don't know
> how to do the same on 2.6.0-test5-mm4.

The same works with 2.6.0-test5.

> I need to eject my CardBus NIC if I want to be able to suspend the
> machine using APM. Resuming from APM when the "yenta_socket" and
> "pcmcia_core" modules are loaded causes a deadlock in the kernel during
> resume, and the machine never comes back completely.

It would be nice to solve this problem.  Since APM suspend with 2.6
kernels seems to be a complete dead loss with my laptop, don't look
to me to diagnose this one.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
