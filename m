Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268215AbUHFRkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268215AbUHFRkX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUHFR3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:29:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35593 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268182AbUHFR2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:28:00 -0400
Date: Fri, 6 Aug 2004 18:27:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Emmeran Seehuber <rototor@rototor.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-ck6: Yenta TI: irq 5: nobody cared!
Message-ID: <20040806182756.G13948@flint.arm.linux.org.uk>
Mail-Followup-To: Emmeran Seehuber <rototor@rototor.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200408021527.13902.rototor@rototor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200408021527.13902.rototor@rototor.de>; from rototor@rototor.de on Mon, Aug 02, 2004 at 03:27:13PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 03:27:13PM +0200, Emmeran Seehuber wrote:
> P.S.: CC please, since I'm not subscribed.
> P.P.S.: Yes, the kernel is tainted by the vmware modules. But that should not 
> be related, should it?

No idea - always try running without proprietary modules to check that it
is indeed a stock kernel problem.  I suspect it will be in this case, but
please check anyway.

Also, you may like to consider reporting the problem (without VMware
loaded) to the linux-pcmcia list at lists.infradead.org, where the guys
who developed this probing code hang out.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
