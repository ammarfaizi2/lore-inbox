Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135850AbRDYMYk>; Wed, 25 Apr 2001 08:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135849AbRDYMYb>; Wed, 25 Apr 2001 08:24:31 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:4612 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S135846AbRDYMYN>;
	Wed, 25 Apr 2001 08:24:13 -0400
Message-ID: <20010421095456.A527@bug.ucw.cz>
Date: Sat, 21 Apr 2001 09:54:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: John Fremlin <chief@bandits.org>
Cc: "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <E14pgBe-0003gg-00@the-village.bc.nu> <m2k84jkm1j.fsf@boreas.yi.org.> <20010420190128.A905@bug.ucw.cz> <m2snj3xhod.fsf@bandits.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <m2snj3xhod.fsf@bandits.org>; from John Fremlin on Sat, Apr 21, 2001 at 12:41:54AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I'm wondering if that veto business is really needed. Why not reject
> > > *all* APM rejectable events, and then let the userspace event handler
> > > send the system to sleep or turn it off? Anybody au fait with the APM
> > > spec?
> > 
> > My thinkpad actually started blinking with some LED when you pressed
> > the button. LED went off when you rejected or when sleep was
> > completed.
> 
> Does the led start blinking when the system sends an apm suspend? In
> that case I don't think you'd notice the brief period between the
> REJECT and the following suspend from userspace ;-)

Not so brief -- suspend to disk takes quite a lot of time. However, it
is probably not too important if user can see blinking led or not.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
