Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRBLKPv>; Mon, 12 Feb 2001 05:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129146AbRBLKPd>; Mon, 12 Feb 2001 05:15:33 -0500
Received: from [194.213.32.137] ([194.213.32.137]:3588 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129282AbRBLKPM>;
	Mon, 12 Feb 2001 05:15:12 -0500
Message-ID: <20010211210219.F3748@bug.ucw.cz>
Date: Sun, 11 Feb 2001 21:02:19 +0100
From: Pavel Machek <pavel@suse.cz>
To: Ivan Borissov Ganev <ganev@cc.gatech.edu>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4.[01] lockups
In-Reply-To: <Pine.LNX.4.20.0102070207300.1226-500000@gamspc7.ihep.su> <Pine.SOL.4.21.0102061907230.7348-100000@tuomotu.cc.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.SOL.4.21.0102061907230.7348-100000@tuomotu.cc.gatech.edu>; from Ivan Borissov Ganev on Tue, Feb 06, 2001 at 07:41:51PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I am experiencing a problem with both 2.4.0 and 2.4.1. The problem is that
> at seemingly random times the console locks up. After the lockup I can no
> longer type and the mouse is frozen. As far as I can tell, other systems
> services are not affected, i.e. programs continue to run, music is being
> played, I/O is fine. It looks like _only_ the console devices are locked
> up.

Login via network or serial cable, and see if /proc/interrupts entry
for keyboard/mouse changes as you type. Attempt to blink keyboard leds
with setleds.
								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
