Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129110AbRBCJnO>; Sat, 3 Feb 2001 04:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129163AbRBCJnF>; Sat, 3 Feb 2001 04:43:05 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:45415 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129110AbRBCJmw>; Sat, 3 Feb 2001 04:42:52 -0500
Date: Sat, 3 Feb 2001 03:42:48 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Darren Tucker <dtucker@zip.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Etherworks3 driver now obsolete?
In-Reply-To: <200102010822.f118Mlu02001@gate.dodgy.net.au>
Message-ID: <Pine.LNX.3.96.1010203034048.26992C-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, Darren Tucker wrote:
> I decided to try a shiny new 2.4.0 kernel but I couldn't configure the driver
> for my etherworks3 ISA ethernet card (AMD K6III PC hardware).
> 
> A bit of grepping showed that it only appears if CONFIG_OBSOLETE is defined
> but nothing in the configuration tools seems to set it (at least for i386).

If you are willing to be a target^H^H^Htester, then I can probably whip
up a patch to fix it.


> CONFIG_OBSOLETE is checked for by Config.in for a couple of drivers (net and
> char), but the only place it seems to be defined is for the ARM architecture. 
> 
> Is this deliberate? Are some of the older drivers to be phased out?
> Should there be a "bool 'Prompt for obsolete code/drivers' CONFIG_OBSOLETE"
> in the config.in for other architectures, too?

CONFIG_OBSOLETE really means "this driver is broken, don't EVER show it
in the kernel config."

	Jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
