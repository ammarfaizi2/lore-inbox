Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263536AbTICPlp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263710AbTICPlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:41:45 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:32972 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263536AbTICPll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:41:41 -0400
Subject: Re: 2.6.0-test4(-mmX) via-rhine ethernet onboard C3 mini-itx
	doesn't work
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Damian Kolkowski <deimos@deimos.one.pl>,
       Danny ter Haar <dth@ncc1701.cistron.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16214.1666.850426.454153@gargle.gargle.HOWL>
References: <bj447c$el6$1@news.cistron.nl>
	 <20030903074902.GA1786@deimos.one.pl>
	 <16213.46254.376174.466098@gargle.gargle.HOWL>
	 <1062598918.19059.54.camel@dhcp23.swansea.linux.org.uk>
	 <16214.1666.850426.454153@gargle.gargle.HOWL>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062603639.19059.77.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Wed, 03 Sep 2003 16:40:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-03 at 16:19, Mikael Pettersson wrote:
> You mean PCI initialisation (and thus ACPI) can break the I/O-APIC
> even though the kernel never actually accesses the I/O-APIC per se?
> Ok, I see how that could happen.

In paticular onboard VIA stuff uses the upper bits of the
PCI_INTERRUPT_LINE register to do IRQ routing as well as the PIN stuff
that PCI expects

