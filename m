Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbULAWvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbULAWvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 17:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbULAWvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 17:51:15 -0500
Received: from havoc.gtf.org ([69.28.190.101]:49284 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261480AbULAWvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 17:51:03 -0500
Date: Wed, 1 Dec 2004 17:45:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: K G <gege86hu@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "irq 16: nobody cared!" -errors after motherboard-switch (ABIT IS7-E2 motherboard)
Message-ID: <20041201224535.GA13815@havoc.gtf.org>
References: <20041201174010.95519.qmail@web60505.mail.yahoo.com> <1101936835.30819.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101936835.30819.69.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 09:33:57PM +0000, Alan Cox wrote:
> On Mer, 2004-12-01 at 17:40, K G wrote:
> > I've recently switched from an "ASUS P4T533-C"
> > motherboard to an "ABIT IS7-E2", and got the errors
> > mentioned above after boot. Only the motherboard and
> > the ram was changed (rambus -> INFINEON 400Mhz DDR).
> 
> Those generally indicate bad interrupt routing but could given the other
> information you provide just indicate a dud board.

Agreed, though it's also on occasion drivers that need to ack/silence
interrupts during initialization.

	Jeff



