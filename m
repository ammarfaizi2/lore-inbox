Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbVJEQZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbVJEQZB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbVJEQZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:25:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:785 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030220AbVJEQZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:25:00 -0400
Date: Wed, 5 Oct 2005 17:24:53 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Brownell <david-b@pacbell.net>
Cc: vwool@ru.mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC 0/2] simple SPI framework, refresh + ads7864 driver
Message-ID: <20051005162453.GD7761@flint.arm.linux.org.uk>
Mail-Followup-To: David Brownell <david-b@pacbell.net>, vwool@ru.mvista.com,
	linux-kernel@vger.kernel.org
References: <20051005162117.24DDBEE95B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051005162117.24DDBEE95B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 09:21:17AM -0700, David Brownell wrote:
> In my investigations of SPI, I don't happen to have come across any
> SPI slave device that would naturally be handled as a block device.
> There's lots of flash (and dataflash); that's MTD, not block.

In two words, MMC cards.

They can be used in MMC mode or SPI mode.  There have been some queries
about using them in SPI mode, but I don't think anyone's written such
a driver (yet).

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
