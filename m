Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbTLLTgD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 14:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTLLTgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 14:36:03 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36360 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261784AbTLLTgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 14:36:02 -0500
Date: Fri, 12 Dec 2003 19:35:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix a problem with 8250 UARTs on PPC
Message-ID: <20031212193557.A12873@flint.arm.linux.org.uk>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031212190012.GT23731@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031212190012.GT23731@stop.crashing.org>; from trini@kernel.crashing.org on Fri, Dec 12, 2003 at 12:00:12PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 12:00:12PM -0700, Tom Rini wrote:
> Hello.  As part of the patch I sent that went into 2.6.0-test7 (Nat Semi
> SuperI/O chips on PPCs at least have a number of different divisors),
> the following should have been done as well, but wasn't.  If we don't
> change the divisor, we don't want to change what we claim as the uart
> clock either.  Without this I don't get a usable serial console on my
> Motorola Sandpoint.

Thanks, applied.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
