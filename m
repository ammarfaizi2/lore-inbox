Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276682AbRJGUmR>; Sun, 7 Oct 2001 16:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276686AbRJGUmH>; Sun, 7 Oct 2001 16:42:07 -0400
Received: from [194.213.32.141] ([194.213.32.141]:36224 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S276673AbRJGUl5>;
	Sun, 7 Oct 2001 16:41:57 -0400
Message-ID: <20011007092352.A454@bug.ucw.cz>
Date: Sun, 7 Oct 2001 09:23:52 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nicholas Berry <nikberry@med.umich.edu>, root@mauve.demon.co.uk,
        linux-kernel@vger.kernel.org
Subject: Re: Odd keyboard related crashes.
In-Reply-To: <sbbd8e9c.096@mail-02.med.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <sbbd8e9c.096@mail-02.med.umich.edu>; from Nicholas Berry on Fri, Oct 05, 2001 at 10:42:16AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>> Ian Stirling <root@mauve.demon.co.uk> 10/05/01 05:01AM >>>
> >I'm running 2.4.10, and the ps/2 keyboard came out of it's socket.
> 
> >On plugging back in, all worked fine, until 10 seconds later there was a
> >crash. (the keyboard worked after being plugged in)
> >No oops, just a reboot.
> >Thinking this must just have been a wierd coincidence, after the system
> >came back up, I tried it again, and again it crashed a few seconds afterwards.
> 
> >It doesn't seem to want to do this again though.
> 
> When the keyboard is powered up (or plugged in), it goes through a self test, and reports the status back to the PC. Normally, a start up dialogue takes place between the PC and the keyboard at this point.
> That's fine when you boot your PC, but if you unplug then re-plug the keyboard, the PC will be sent data it's really not expecting, and the BIOS will be very confused.
> If you ever want to switch a keyboard between PCs, make sure you leave power supplied to it at all times.

BIOS is not alive enough at the time linux boots. This can't be BIOS
issue.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
