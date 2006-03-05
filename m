Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752167AbWCEJ7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbWCEJ7H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 04:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbWCEJ7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 04:59:07 -0500
Received: from tim.rpsys.net ([194.106.48.114]:10191 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1752167AbWCEJ7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 04:59:06 -0500
Subject: Re: [patch] zaurus keyboard driver updates
From: Richard Purdie <rpurdie@rpsys.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-input@atrey.karlin.mff.cuni.cz,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060305080924.GA7145@flint.arm.linux.org.uk>
References: <1141517165.10871.26.camel@localhost.localdomain>
	 <20060305080924.GA7145@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sun, 05 Mar 2006 09:47:55 +0000
Message-Id: <1141552075.6521.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-05 at 08:09 +0000, Russell King wrote:
> On Sun, Mar 05, 2006 at 12:06:05AM +0000, Richard Purdie wrote:
> > + 	request_irq(SPITZ_IRQ_GPIO_AK_INT, spitzkbd_hinge_isr,
> > +		    SA_INTERRUPT, | SA_TRIGGER_RISING | SA_TRIGGER_FALLING,
> 
> This looks bogus (and unbuildable).

Thanks for spotting. The changes have been tested against older kernels
(2.6.15) and the corgi changes against current git but I messed up when
updating the spitz changes.

Richard

