Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbTKNQEJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 11:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTKNQEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 11:04:09 -0500
Received: from dsl093-039-041.pdx1.dsl.speakeasy.net ([66.93.39.41]:60636 "EHLO
	raven.beattie-home.net") by vger.kernel.org with ESMTP
	id S262760AbTKNQEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 11:04:07 -0500
Subject: Re: serverworks usb under 2.4.22
From: Brian Beattie <beattie@beattie-home.net>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200311140851.09228.ioe-lkml@rameria.de>
References: <1068769021.884.4.camel@kokopelli>
	 <200311140851.09228.ioe-lkml@rameria.de>
Content-Type: text/plain
Message-Id: <1068825844.832.8.camel@kokopelli>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 14 Nov 2003 11:04:04 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-11-14 at 02:51, Ingo Oeser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Brian,
> hi lkml,
> 
> On Friday 14 November 2003 01:17, Brian Beattie wrote:
> > I've got a system with a Super Micro P3 dual processor board.  This
> > board uses the Serverworks chipset and the 2.4.22 kernel is unable to
> > allocate an IRQ when initializing the USB (usb-ohic) interface.  This
> > board works fine under 2.4.20 and 2.4.21.
> 
> Which Serverworks chipset? There are various.

I posted that info ealier today.
> 
> I for one need to pass "noapic" on the kernel command line. Otherwise
> the IRQ routing is broken, I can't get the USB IRQ and the kernel complains.
> a lot about a broken APIC IRQ routing.

nopic did not seem to help

-- 
Brian Beattie            | Experienced kernel hacker/embedded systems
beattie@beattie-home.net | programmer, direct or contract, short or
www.beattie-home.net     | long term, available immediately.

"Honor isn't about making the right choices.
It's about dealing with the consequences." -- Midori Koto


