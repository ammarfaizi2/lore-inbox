Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262984AbVG3Pvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbVG3Pvq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 11:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbVG3Pvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 11:51:46 -0400
Received: from fsmlabs.com ([168.103.115.128]:2020 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262984AbVG3Pvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 11:51:44 -0400
Date: Sat, 30 Jul 2005 09:57:24 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Brian Schau <brian@schau.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wireless Security Lock driver.
In-Reply-To: <42EB99D6.1020907@schau.com>
Message-ID: <Pine.LNX.4.61.0507300956340.29844@montezuma.fsmlabs.com>
References: <42EB940E.5000008@schau.com> <42EB9650.8010305@m1k.net>
 <42EB99D6.1020907@schau.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jul 2005, Brian Schau wrote:

> Hi Michael (and others),
> 
> 
> Thanks for the info.   Well, the reason why I didn't inline the patch
> was due to the size of it - in terms of lines.   However, here it is:

> +static void wsl_irq_in(struct urb *urb, struct pt_regs *regs)
> +{
> +	struct usb_wsl *wsl=urb->context;
> +	int id=0, retval;
> +	+	switch (urb->status) { <==========
> +	case -ECONNRESET:

There is something wrong with your patch or mailer.
