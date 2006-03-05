Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWCEIK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWCEIK7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 03:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWCEIK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 03:10:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60173 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932251AbWCEIK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 03:10:58 -0500
Date: Sun, 5 Mar 2006 08:09:25 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-input@atrey.karlin.mff.cuni.cz,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] zaurus keyboard driver updates
Message-ID: <20060305080924.GA7145@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-input@atrey.karlin.mff.cuni.cz,
	LKML <linux-kernel@vger.kernel.org>
References: <1141517165.10871.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141517165.10871.26.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 12:06:05AM +0000, Richard Purdie wrote:
> + 	request_irq(SPITZ_IRQ_GPIO_AK_INT, spitzkbd_hinge_isr,
> +		    SA_INTERRUPT, | SA_TRIGGER_RISING | SA_TRIGGER_FALLING,

This looks bogus (and unbuildable).

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
