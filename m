Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132224AbRDPVbt>; Mon, 16 Apr 2001 17:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132281AbRDPVbk>; Mon, 16 Apr 2001 17:31:40 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:9732 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132224AbRDPVbZ>;
	Mon, 16 Apr 2001 17:31:25 -0400
Message-ID: <20010416232748.A385@bug.ucw.cz>
Date: Mon, 16 Apr 2001 23:27:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <20010416174945.D29398@kallisto.sind-doof.de> <Pine.LNX.4.31.0104161816470.19209-100000@phobos.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.31.0104161816470.19209-100000@phobos.fachschaften.tu-muenchen.de>; from Simon Richter on Mon, Apr 16, 2001 at 06:25:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > A power failure is a different thing from a power button press.
> 
> > And why not do exactly this with init? Have a look in /etc/inittab:
> 
> > You can shut down your machine there, but you can also have it play a
> > cancan on power failure. It is up to your gusto. And now tell me, why
> > not choose a similar approach, but instead reinvent the wheel and
> > create a completely new mechanism?
> 
> Because we'd be running out of signals soon, when all the other ACPI
> events get available.

There are 32 signals, and signals can carry more information, if
required. I really think doing it way UPS-es are done is right
approach.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
