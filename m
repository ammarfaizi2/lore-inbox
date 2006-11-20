Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966245AbWKTR1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966245AbWKTR1k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966246AbWKTR1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:27:40 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:42761 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S966245AbWKTR1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:27:39 -0500
Date: Mon, 20 Nov 2006 17:27:31 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Linux kernel development <linux-kernel@vger.kernel.org>,
       PCMCIA Maintainence <linux-pcmcia@lists.infradead.org>,
       David Hinds <dahinds@users.sourceforge.net>,
       Jaroslav Kysela <perex@suse.cz>,
       Bart Prescott <bart.prescott@elandigitalsystems.com>
Subject: Re: [PATCH] PCMCIA identification strings for cards manufactured by Elan
Message-ID: <20061120172731.GC26791@flint.arm.linux.org.uk>
Mail-Followup-To: Tony Olech <tony.olech@elandigitalsystems.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Linux kernel development <linux-kernel@vger.kernel.org>,
	PCMCIA Maintainence <linux-pcmcia@lists.infradead.org>,
	David Hinds <dahinds@users.sourceforge.net>,
	Jaroslav Kysela <perex@suse.cz>,
	Bart Prescott <bart.prescott@elandigitalsystems.com>
References: <200611201214.kAKCErcU005240@imap.elan.private> <20061120130237.GA22330@flint.arm.linux.org.uk> <1164032582.30853.36.camel@n04-143.elan.private> <20061120152927.GA26791@flint.arm.linux.org.uk> <1164041509.30853.48.camel@n04-143.elan.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164041509.30853.48.camel@n04-143.elan.private>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 04:51:48PM +0000, Tony Olech wrote:
> Hi Russell,
> if I take out the patches to parport_cs and serial_cs,
> leaving in only the patch to "pdaudiocf" our SP230 card
> no longer works - it does not lock up the kernel, admittedly,
> and the serial only card does works, but we would like
> all are cards to just work.

Sounds like function ID matching is broken.  Dominik?

> ALSO, I have found no way to force a particular 16-bit
> pcmcia card to be handled by a particular module in a
> similar way to the USB generic serial driver module
> parameter. Have I misssed the obvious? Or is that a
> desirable feature that have been taken out of the David
> Hinds original implementation?

Again, Dominik's area of expertise.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
