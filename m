Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283516AbRLCXqW>; Mon, 3 Dec 2001 18:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282147AbRLCXii>; Mon, 3 Dec 2001 18:38:38 -0500
Received: from [213.96.224.204] ([213.96.224.204]:11268 "EHLO manty.net")
	by vger.kernel.org with ESMTP id <S284460AbRLCLjs>;
	Mon, 3 Dec 2001 06:39:48 -0500
Date: Mon, 3 Dec 2001 12:39:44 +0100
From: Santiago Garcia Mantinan <manty@manty.net>
To: linux-kernel@vger.kernel.org
Subject: IDE pnp interface on a SB16 not working
Message-ID: <20011203113944.GA1171@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've been playing around with IDE interfaces for quite some time without
problems, but this last days I have been trying to setup one on a SB16
without any results.

The card is a SB Vibra16 PNP, model number CT2940, I could get it to read
the CD or HD id number and all that, however, when I want to access the
device for other stuff I just get errors saying that the irq is not
responding and things like that. I'm using kernel 2.4.16 with IDE PNP on it,
even though I have tried other hand made configs also. None of them worked

I have tried this on different machines, all of them showed the same
problem, devices are recogniced but when they are accessed for any other
thing I get interrupt errors. The interrupt that the IDE PNP is using is
free and I have set up other devices to use that IRQ and those work ok.

Having seen that I thought of a problem on latest kernels, so I got my old
IDE pnp device wich comes on a OPL3SA2 card that I have on another machine,
and I have plugged it on one of the machines I had been using with the SB,
the IDE port worked ok, so there is no problem with the IDE pnp.

After seeing this I thought that maybe the IDE port of the card was broken,
so as a last resort, I set up a windows 98 on one of the machines I had been
using for the tests, and the interface worked ok, windows was using the same
io ports and irqs that I had chosen under linux and everything looked pretty
much the same as in Linux, but here it worked.

To sum this up, I got a machine with windows an Linux where the OPL3SA2
IDE interface works on both OS, but the SB IDE interface does only work
under windows.

Anybody has any idea of what can be going on here and how to solve this?

Regards...
-- 
Manty/BestiaTester -> http://manty.net
