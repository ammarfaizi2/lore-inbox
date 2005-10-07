Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVJGAj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVJGAj1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 20:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbVJGAj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 20:39:27 -0400
Received: from free.hands.com ([83.142.228.128]:57820 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S1751275AbVJGAj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 20:39:26 -0400
Date: Fri, 7 Oct 2005 01:38:41 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Rik van Riel <riel@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051007003841.GK10538@lkcl.net>
References: <54300000.1128297891@[10.10.2.4]> <20051003011041.GN6290@lkcl.net> <200510022028.07930.chase.venters@clientec.com> <20051004125955.GQ10538@lkcl.net> <17218.39427.421249.448094@gargle.gargle.HOWL> <20051004161702.GU10538@lkcl.net> <Pine.LNX.4.63.0510041329140.23708@cuia.boston.redhat.com> <20051006000744.GD10538@lkcl.net> <Pine.LNX.4.63.0510061322050.4686@cuia.boston.redhat.com> <20051006192220.GU10538@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006192220.GU10538@lkcl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.eet.com/in_focus/embedded_systems/OEG20021213S0029

	It was decided at the beginning that we would design
	a system-on-chip (SoC) platform, which yields the
	best unit price when manufactured in high volume. The
	usual approach would be to license all the technology
	from third party suppliers, [...]  [but] we didn't
	want to deal with huge NRE and royalty fees. Also,
	we would not get the necessary know-how that is often
	a determining factor when designing a new product in
	today's ever decreasing time-to-market.

	So, we decided to follow the Linux open source
	philosophy and build our first platform on open
	source technology. We took several open source IPs
	from OpenCores [http://www.opencores.org] and integrate
	them into an underlying hardware SoC platform optimized
	for running Linux.

	[...]

		... As the main processor we chose OpenRISC 1200
	[http://www.opencores.org/pnews.cgi/list/or1k?no_loop=yes],
	a 32-bit RISC processor that comes with a stable GNU
	Toolchain and a port of small footprint Microcontroller
	Linux, the uClinux.

	The next critical part of the whole project was to set up a
	scheme on how to connect all the IPs in a modular way so that
	we could configure the platform for different embedded
	applications.         [...]

	We found out that a central configurable block
	interconnecting the processor and peripheral IPs did
	the trick.  [...]  we created a tool that automatically
	generated this central block  [...] and automatically
	configures Linux kernel and device drivers for that
	particular application.

	As embedded developers often find out, it is difficult
	to start writing and testing software, if hardware
	designers are still designing the hardware. It is
	necessary to parallel these two tasks in order to meet
	             ^^^^^^^^^^^^^^^^^^^^^^^^
	today's critical time-to-market schedules. In addition,
	each group can provide some test cases to the other
	as we found out.

these people designed the _entire_ embedded system - from free software
licensed components.

the processor design.

the software toolchain.

the kernel running on the free software licensed processor design.


it CAN be done.  it HAS been done.

convincing yourselves that you "must have hardware before you will get
off your fat asses" is _so_ self-disempowering.  STOP IT.

you - the linux kernel designers - are an extremely powerful
group who quite literally could hold the technical world to
ransom if you so chose (albeit for a very brief amount of time until
someone considered your actions to be the equivalent of a
"bus-running-over" event).

god help the world when you decide to actually say "thank you
for your hardware.  next time, consult us on what should be
in it _before_ you finalise its design".

l.

