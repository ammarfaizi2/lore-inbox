Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbTKEJMa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 04:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTKEJMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 04:12:30 -0500
Received: from yate.wa.csiro.au ([130.116.131.40]:13837 "EHLO
	yate.nexus.csiro.au") by vger.kernel.org with ESMTP id S262760AbTKEJM3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 04:12:29 -0500
Subject: Re:RE: interrupts across  PCI bridge(s) not handled
From: Frank Horowitz <frank.horowitz@csiro.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Content-Type: text/plain
Message-Id: <1068023546.13152.9.camel@bonzo.ned.dem.csiro.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 05 Nov 2003 17:12:26 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Nov 2003, Linux Torvalds wrote:

> On Mon, 3 Nov 2003, Charles Martin wrote:
> >
> > I enabled ACPI, and the interrupts are now assigned correctly,
> > and in the range of 48-51:
> 
> Good. 
> 
> > I didn't realize that ACPI is related to interrupt management 
> > as well as power control. Is there any downside to using ACPI?
> 
> The downside to ACPI is that it's a complex standard, and with
> complexity 
> comes the inevitable bugs. As you just found out, it does a lot more
> than 
> just power control (the "C" is for "Configuration").
> 
> On some machines the ACPI support is even more broken than other BIOS 
> tables, but it's getting better.

I infer from this discussion that the old (2.2.x-era) rule-of-thumb
about disabling ACPI for SMP systems is now dangerous advice. True?
(Even for a 2.4.x series kernel?) Any other "gotchas" with ACPI and SMP
systems?

Frank Horowitz


