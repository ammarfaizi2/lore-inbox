Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWEOW5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWEOW5e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWEOW5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:57:34 -0400
Received: from animx.eu.org ([216.98.75.249]:7903 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1750721AbWEOW5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:57:33 -0400
Date: Mon, 15 May 2006 19:02:56 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFT] major libata update
Message-ID: <20060515230256.GB4699@animx.eu.org>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060515170006.GA29555@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515170006.GA29555@havoc.gtf.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> After much development and review, I merged a massive pile of libata
> patches from Tejun Heo and Albert Lee.  This update contains the
> following major libata
> 
> CHANGES:
> * Rewritten error handling. This is a major piece of work, even
>   though it will be rarely seen.  The new libata EH provides the
>   foundation for not only improved error handling, but also new features
>   such as device hotplug or command queueing. (Tejun Heo)
> 
> * PIO-based I/O is now IRQ-driven by default, rather than polled
>   in a kernel thread.  The polling path will continue to exist for
>   controllers that need it, and other special cases. (Albert Lee)
> 
> * Core support for command queueing (Jens Axboe, Tejun Heo)
> 
> * Support for NCQ-style command queueing (Jens Axboe, Tejun Heo)
> 
> * Increase max-sectors dramatically, for LBA48 devices (Tejun Heo?)
> 
> * Other minor changes, from myself and others.

How about PATA?  Specifically intel's IDE chip.  I have a machine that I can
blow the hard drive away if I want to.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
