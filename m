Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbTDRJmR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 05:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbTDRJmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 05:42:17 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:25493 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262994AbTDRJmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 05:42:15 -0400
Date: Fri, 18 Apr 2003 11:54:08 +0200 (MEST)
Message-Id: <200304180954.h3I9s8qc025926@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: CONFIG_X86_UP_APIC and CONFIG_X86_UP_IOAPIC won't allow me to connect with my ADSL
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Apr 2003 mikpe@csd.uu.se wrote:
> Wed, 16 Apr 2003 21:53:21 -0300 (BRT), 0@pervalidus.tk wrote:
> >I just installed an ECS K7VTA3 5.0 and ADSL. I was using an
> >ASUS A7S333 and cable modem.
> >
> >With a kernel compiled with CONFIG_X86_UP_APIC and
> >CONFIG_X86_UP_IOAPIC adsl-start will timeout. adsl-connect also
> >fails.
..
> First thing to try:
> Keep UP_APIC enabled but disable UP_IOAPIC.

I've received confirmation that disabling IOAPIC support
but keeping local APIC support eliminated the problems
this person had. The chipset was VIA something.

The errors when IOAPIC was enabled included things like
'eth0: transmit timed out' and
'eth0: Interrupt posted but not delivered -- IRQ blocked by another device?'
