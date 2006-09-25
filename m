Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWIYMBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWIYMBm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 08:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWIYMBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 08:01:41 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:36559 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932092AbWIYMBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 08:01:41 -0400
Date: Mon, 25 Sep 2006 14:01:23 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Victor <andrew@sanpeople.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] at91_serial: Introduction
Message-ID: <20060925140123.12bf8cd5@cad-250-152.norway.atmel.com>
In-Reply-To: <20060923211417.GB4363@flint.arm.linux.org.uk>
References: <11545303083273-git-send-email-hskinnemoen@atmel.com>
	<20060923211417.GB4363@flint.arm.linux.org.uk>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2006 22:14:17 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Wed, Aug 02, 2006 at 04:51:45PM +0200, Haavard Skinnemoen wrote:
> > Another thing: Andrew, are you the official maintainer of this
> > driver? If not, who is?
> 
> I've not heard from Andrew, so I'm not sure what to do about this.  I
> think these changes need validating by someone with the existing
> driver's hardware (iow, AT91RM9200 and/or AT91SAM9261) so we can be
> sure we don't break that support.

I really want at least the first one to go in, as the new AVR32 port
would soon find itself without a serial driver otherwise. And it
doesn't make any actual changes for the CONFIG_ARM case, so it should
be quite safe. The last two are bugfixes which I believe make sense on
ARM as well, but that's also a reason why they should be more thoroughly
tested.

I can resend them as individual patches if it helps make it more clear
that they don't really depend on each other.

I have a AT91RM9200-EK board lying around, so I might be able to test
the patches on that as soon as I get the necessary cross compilers and
other tools set up.

Haavard
