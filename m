Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135914AbRDTRQW>; Fri, 20 Apr 2001 13:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135906AbRDTRQM>; Fri, 20 Apr 2001 13:16:12 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:8709 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S135898AbRDTRP7>;
	Fri, 20 Apr 2001 13:15:59 -0400
Message-ID: <20010420190128.A905@bug.ucw.cz>
Date: Fri, 20 Apr 2001 19:01:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: John Fremlin <chief@bandits.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        "'Pavel Machek'" <pavel@suse.cz>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <E14pgBe-0003gg-00@the-village.bc.nu> <m2k84jkm1j.fsf@boreas.yi.org.>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <m2k84jkm1j.fsf@boreas.yi.org.>; from John Fremlin on Wed, Apr 18, 2001 at 02:56:56AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> [...]
> 
> > I would tend to agree here. If you want to wire it to init the fine
> > but pm is basically message passing kernel->user and possibly
> > message reply to allow veto/approve. APM provides a good API for
> > this and there is a definite incentive to make ACPI use the same
> > messages, behaviour and extend it.
> 
> I'm wondering if that veto business is really needed. Why not reject
> *all* APM rejectable events, and then let the userspace event handler
> send the system to sleep or turn it off? Anybody au fait with the APM
> spec?

My thinkpad actually started blinking with some LED when you pressed
the button. LED went off when you rejected or when sleep was
completed. So you would loose visual indication of "system is now
going to sleep". But I guess that is very little loose for the loose
of complexity.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
