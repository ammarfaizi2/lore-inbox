Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbTLSUWY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 15:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbTLSUWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 15:22:24 -0500
Received: from legolas.restena.lu ([158.64.1.34]:48287 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263598AbTLSUWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 15:22:22 -0500
Subject: Re: [2.4] Nforce2 oops and occasional hang (tried the lockups
	patch, no difference)
From: Craig Bradney <cbradney@zip.com.au>
To: Disconnect <lkml@sigkill.net>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1071854664.6110.21.camel@slappy>
References: <200312131225.34937.ross@datscreative.com.au>
	 <1071506410.2030.35.camel@slappy>  <1071773523.1282.6.camel@slappy>
	 <1071854664.6110.21.camel@slappy>
Content-Type: text/plain
Message-Id: <1071865339.9969.3.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 19 Dec 2003 21:22:19 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-19 at 18:24, Disconnect wrote:
> On Thu, 2003-12-18 at 13:52, Disconnect wrote:
> > memory/cpu timings.  (Even underclocked it to 133 and 1G with no
> > change.)  So its unfortunately back on a stock 2.4.23-pre9 with
> > noapic/noacpi. (It disables one of the sets of usb ports, as I recall,
> > but it mostly works...)
> 
> Update: Underclocked from 1.8G to 1.2G (whups, meant to go down only
> 2-300mhz) and its been vaguely stable for about 1.5 days.  I don't have
> another week (yet..) to run it under its normal load and wait for a
> crash, so what I'm going to do is:
>  - Move the workload (web/mail/..) to a different machine so this one
> can be down for an extended period
>  - Replace the ram with new sticks (they arrived this morning)
>  - Reclock everything to stock (1.83G cpu, 200mhz ram and verify the
> timings from kingston)
>  - Replace the video card
>  - Memtest86 until it cries
>  - If it passes, bonnie++ on the new drives
>  - If that passes, usb/acpi/apic testing with the associated patches
> 
> Anyone still watching this?  Tips and suggestions on what else might be
> useful/informative are more than welcome.  The tests above mostly
> replicate what I did when building this box, and it passed them then..
> 
> Recap:
>  Epox 8rda+ nforce2 mobo
>  AMD Athlon XP 2500+ (Barton) 1.83G
>  Kingston HyperX PC3200
>  WD Caviar WD1200JB 8M/UDMA100
>  Antec case w/ 350W AMD-certified PSU
> 
> Oopses and occasional hangs, usually in do_generic_file_read, using
> stock kernel.org 2.4.2x kernels.  Hardware passed testing (memtest86,
> bonnie++) before I put Linux on it.

Does this not relate directly to the APIC/IOAPIC issues with 2.6 kernel
and nforce chipset motherboards? 

Craig

