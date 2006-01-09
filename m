Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWAIR4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWAIR4Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWAIR4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:56:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10119 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030221AbWAIR4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:56:25 -0500
Date: Mon, 9 Jan 2006 12:56:07 -0500
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: PATCH: Fix typos, exclamation mark frenzy and missing device id on messages
Message-ID: <20060109175607.GC25102@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <1136826079.6659.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136826079.6659.36.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 05:01:19PM +0000, Alan Cox wrote:
 > I sent this out a couple of months ago and the driver author said it
 > he'd merge it. Nothing has happened since so I'm submitting it directly.
 > 
 > No functionality changes just texts.


 > +++ linux-2.6.15-mm2/drivers/char/tlclk.c	2006-01-09 14:40:29.000000000 +0000
 > @@ -211,7 +211,7 @@
 >  	result = request_irq(telclk_interrupt, &tlclk_interrupt,
 >  			     SA_INTERRUPT, "telco_clock", tlclk_interrupt);
 >  	if (result == -EBUSY) {
 > -		printk(KERN_ERR "telco_clock: Interrupt can't be reserved!\n");
 > +		printk(KERN_ERR "telco_clock: Interrupt can't be reserved.\n");

You changed all the other telco_clock's to tlclk's but this one.

		Dave
