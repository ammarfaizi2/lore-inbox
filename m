Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbQLKWKO>; Mon, 11 Dec 2000 17:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130512AbQLKWKF>; Mon, 11 Dec 2000 17:10:05 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1028 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129387AbQLKWJs>;
	Mon, 11 Dec 2000 17:09:48 -0500
Message-ID: <20001210231255.A2332@bug.ucw.cz>
Date: Sun, 10 Dec 2000 23:12:55 +0100
From: Pavel Machek <pavel@suse.cz>
To: Janne Pänkälä <epankala@cc.hut.fi>,
        linux-kernel@vger.kernel.org
Subject: Re: K6-2+ and MSR registers (PowerNOW)
In-Reply-To: <Pine.OSF.4.10.10012081613060.10426-100000@alpha.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.OSF.4.10.10012081613060.10426-100000@
 alpha.hut.fi>; from Janne Pänkälä on Fri,
  Dec 08, 2000 at 04:34:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Bought myself this new CPU that is mainly available for laptops.
> 
> I have Tyan S1590 board which BIOS won't POST if I set cpu speed (it's
> 500Mhz chip) >300Mhz. This won't matter much in windows since I can there
> use graphical utility which allows one to set whe CPU clock multiplier in
> flight as 2.0 - 6.0. But since my machine is Linux like 98% of the time
> I'd like to do same in linux.
> 
> Things I have considered are. Do I need to recalculate BoGos? Do I need to
> reserve the IO space to access it from user space.

You should recalculate bogomips. Hell _may_ break loose if you don't,
but it probably will not.

> In the end it would be nice to do proc entry or user space program that
> allows one to [sg]et cpu speed and other PowerNOW properties.

Hmm, it would be nice if generic interface existed: my philips velo 1
can set cpu speed in range 2MHz .. 40MHz.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
