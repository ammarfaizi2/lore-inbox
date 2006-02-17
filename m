Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751661AbWBQUIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbWBQUIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 15:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbWBQUIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 15:08:17 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54283 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751653AbWBQUIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 15:08:16 -0500
Date: Fri, 17 Feb 2006 20:08:06 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Tony Lindgren <tony@atomide.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/5] MMC OMAP driver
Message-ID: <20060217200805.GB13502@flint.arm.linux.org.uk>
Mail-Followup-To: Carlos Aguiar <carlos.aguiar@indt.org.br>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
References: <43DF6750.1060505@indt.org.br> <20060201124434.GC3072@flint.arm.linux.org.uk> <20060201194724.GD15939@atomide.com> <20060202104022.GF5034@flint.arm.linux.org.uk> <43E1F0F3.3020801@drzeus.cx> <20060202122410.GA12508@flint.arm.linux.org.uk> <43F629AF.5050309@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F629AF.5050309@indt.org.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 03:53:19PM -0400, Carlos Aguiar wrote:
> >+#define mmc_cmd_type(cmd)	((cmd)->flags & MMC_CMD_TYPE)
> > 
> >
> The change above is needed because MMC_CMD_TYPE is used here but not 
> defined.

I'd rather keep it as "MASK" because that's what it is.  Thanks
for pointing this out - the fix should hit Linus' tree sometime
in the near future.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
