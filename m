Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129563AbRCBWFt>; Fri, 2 Mar 2001 17:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbRCBWFl>; Fri, 2 Mar 2001 17:05:41 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:6404 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129552AbRCBWFZ>;
	Fri, 2 Mar 2001 17:05:25 -0500
Date: Thu, 1 Mar 2001 12:41:59 +0000
From: Pavel Machek <pavel@suse.cz>
To: Sébastien HINDERER <jrf3@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Keyboard simulation
Message-ID: <20010301124158.E34@(none)>
In-Reply-To: <3a9cc5953b575371@citronier.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3a9cc5953b575371@citronier.wanadoo.fr>; from jrf3@wanadoo.fr on Wed, Feb 28, 2001 at 10:38:03AM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm writting a driver so that my soft braille display can work with the
> BRLTTY daemon.
> My braille computer contains a braille display, and a braille keyboard
> which I can use to enter characters that are transmitted to the computer.
> When my driver gets "normla" chars, he writes them to /dev/console. So for
> applications, it looks as if they came from the normal keyboard.
> Now, I'd like to be able to change the current virtual console and to view
> previously displayed screens (equivalent to shift+page up) just by pressing
> keys on the braille keyboard.
> So my question is: What should my driver do when it detects that the
> "change tty" key or the "scroll key" was pressed on the braille keyboard?
> Should the driver change the current tty itself (scroll the screen), or is
> it possible to call the kernel exactly like the normal keyboard driver
> would do (transmit keycodes), saying "alt + function key was pressed", or
> "shift + page up/down was pressed".

Transmit keycodes is AFAIK not implemented in official drivers.

Take a look at vojtech's new input suite.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

