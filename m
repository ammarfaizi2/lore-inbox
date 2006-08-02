Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWHBQEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWHBQEA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 12:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWHBQEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 12:04:00 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:63761 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932077AbWHBQD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 12:03:59 -0400
Date: Wed, 2 Aug 2006 17:03:53 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Andrew Victor <andrew@sanpeople.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] at91_serial: support AVR32
Message-ID: <20060802160353.GA7173@flint.arm.linux.org.uk>
Mail-Followup-To: Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Andrew Victor <andrew@sanpeople.com>, linux-kernel@vger.kernel.org
References: <11545303083273-git-send-email-hskinnemoen@atmel.com> <11545303082669-git-send-email-hskinnemoen@atmel.com> <20060802151505.GA32102@flint.arm.linux.org.uk> <20060802180023.65fe6434@cad-250-152.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060802180023.65fe6434@cad-250-152.norway.atmel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 06:00:23PM +0200, Haavard Skinnemoen wrote:
> What is the best way to get the serial console up and running early in
> the boot process?

There is no generic solution to this problem other than to put up with
the late initialisation of serial console.

If you want a serial console earlier, have a look at how the 8250_early
stuff works.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
