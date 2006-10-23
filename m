Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752005AbWJWQme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbWJWQme (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 12:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbWJWQme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 12:42:34 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4370 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1752005AbWJWQmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 12:42:33 -0400
Date: Mon, 23 Oct 2006 17:42:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Mundt <lethal@linux-sh.org>, Jeff Garzik <jgarzik@pobox.com>,
       Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: Generic platform_device libata driver, take 2.
Message-ID: <20061023164220.GA24471@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20061023065907.GA22029@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023065907.GA22029@linux-sh.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 03:59:07PM +0900, Paul Mundt wrote:
> This is the second attempt at a generic platform_device libata driver,
> attempting to take in to account issues raised by Matthias Fuchs and rmk.
> 
> Changes in this version include adding a small pata_platform.h header for
> the private data (which at the moment is limited to a register shift
> that's needed by ARM), though other things can be added in here if
> platforms start having other needs.

Thanks, this will enable me to use this code on ARM.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
