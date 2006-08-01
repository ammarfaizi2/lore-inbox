Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWHAIm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWHAIm1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 04:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWHAIm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 04:42:27 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:47375 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750834AbWHAIm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 04:42:26 -0400
Date: Tue, 1 Aug 2006 09:42:09 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hans Eklund <hans@rubico.se>, David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Block request processing for MMC/SD over SPI bus
Message-ID: <20060801084209.GB9556@flint.arm.linux.org.uk>
Mail-Followup-To: Hans Eklund <hans@rubico.se>,
	David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
References: <200608011037.27721.hans@rubico.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608011037.27721.hans@rubico.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 10:37:27AM +0200, Hans Eklund wrote:
> The driver is also independent of any previous MMC related work at this point 
> since MMC over SPI mode differs somewhat from the MMC mode.

You may be interested to know that David Brownell (I believe) has a
driver which connects the SPI framework to the MMC subsystem, allowing
the MMC subsystem to talk to cards in SPI mode.

Maybe David can help, or point you in the direction of someone who
can in the case that I'm misremembering.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
