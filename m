Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTICPTi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTICPTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:19:38 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:17405 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263129AbTICPTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:19:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16214.1666.850426.454153@gargle.gargle.HOWL>
Date: Wed, 3 Sep 2003 17:19:30 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Damian Kolkowski <deimos@deimos.one.pl>,
       Danny ter Haar <dth@ncc1701.cistron.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test4(-mmX) via-rhine ethernet onboard C3 mini-itx
	doesn't work
In-Reply-To: <1062598918.19059.54.camel@dhcp23.swansea.linux.org.uk>
References: <bj447c$el6$1@news.cistron.nl>
	<20030903074902.GA1786@deimos.one.pl>
	<16213.46254.376174.466098@gargle.gargle.HOWL>
	<1062598918.19059.54.camel@dhcp23.swansea.linux.org.uk>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 > On Mer, 2003-09-03 at 10:30, Mikael Pettersson wrote:
 > > It's impossible to have an APIC bug on a C3 board, because the processor
 > > simply doesn't have one!
 > 
 > The chipset does and not writing PCI_INTERRUPT_LINE and other things
 > properly can cause problems if its directing interrupts to the chipset
 > I/O APIC wrongly not the PIC and thus the CPU

You mean PCI initialisation (and thus ACPI) can break the I/O-APIC
even though the kernel never actually accesses the I/O-APIC per se?
Ok, I see how that could happen.

/Mikael
