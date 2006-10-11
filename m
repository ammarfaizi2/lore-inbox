Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWJKMYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWJKMYQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 08:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWJKMYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 08:24:15 -0400
Received: from khc.piap.pl ([195.187.100.11]:29402 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932406AbWJKMYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 08:24:15 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] WAN/pc300: handle, propagate minor errors
References: <20061010233637.GA20090@havoc.gtf.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 11 Oct 2006 14:24:12 +0200
In-Reply-To: <20061010233637.GA20090@havoc.gtf.org> (Jeff Garzik's message of "Tue, 10 Oct 2006 19:36:37 -0400")
Message-ID: <m3irirvy4z.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jeff Garzik <jeff@garzik.org> writes:

> - move definition of 'tmc' and 'br' locals closer to usage
>
> - handle clock_rate_calc() error
>
> - propagate errors back to upper level open routine

>  drivers/net/wan/pc300_drv.c |   24 +++++++++++++++++++-----

Looks good (not sure if my ACK counts, I'm not the maintainer).


FYI: I think the pc300 driver would benefit from, I'd say, a bit
of maintenance. Cyclades don't sell PC300 anymore (at least their
WWW doesn't list them) and I don't know if they're going to touch
the driver.

I have a much simpler driver for PC300 X.21 and V.24/V.35 models
(could be included in the official kernel), but it lacks support
for T1/E1 cards.

I could look at their driver and try to incorporate T1/E1 support
into my driver, but without access to the hardware it would be
tricky at best.

Not sure what should we do. Perhaps waiting for Cyclades is the
only option.

PC300 are nice cards, it would be sad if the driver support
deteriorated.
-- 
Krzysztof Halasa
