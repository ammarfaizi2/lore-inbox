Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268310AbRGWRbo>; Mon, 23 Jul 2001 13:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268309AbRGWRbe>; Mon, 23 Jul 2001 13:31:34 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9999 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268308AbRGWRbV>; Mon, 23 Jul 2001 13:31:21 -0400
Date: Mon, 23 Jul 2001 18:32:04 +0100
From: Alan Cox <laughing@shared-source.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Athlon/MSI mobo combo broken?
Message-ID: <20010723183204.B27310@lightning.swansea.linux.org.uk>
Mail-Followup-To: Alan Cox <laughing@shared-source.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010723180201.A10557@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010723180201.A10557@convergence.de>; from leitner@convergence.de on Mon, Jul 23, 2001 at 06:02:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 23, 2001 at 06:02:01PM +0200, Felix von Leitner wrote:
> I have now had two MSI mainboards and two Athlons with 1330 MHz, and
> none of them works as advertised.  When I compile an Athlon kernel (I

VIA chipset..

> When I compile the same kernel for Pentium Pro, it works.  How can this
> be?

Theory right now: Because the Athlon kernel does streaming memory copies at
full bus performance. Not all VIA chipset boards seem to cope.

I'd be interested to know if 2.4.6-ac5 Athlon optimised works on your board.
The reason for this is that it contains the official VIA fixes for their IDE
corruption problem rather than our own.


