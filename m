Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267242AbRGKI4g>; Wed, 11 Jul 2001 04:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267238AbRGKI40>; Wed, 11 Jul 2001 04:56:26 -0400
Received: from b0rked.dhs.org ([216.99.196.11]:11912 "HELO b0rked.dhs.org")
	by vger.kernel.org with SMTP id <S267236AbRGKI4K>;
	Wed, 11 Jul 2001 04:56:10 -0400
Date: Wed, 11 Jul 2001 01:56:07 -0700 (PDT)
From: Chris Vandomelen <chrisv@b0rked.dhs.org>
To: Antonio Pagliaro <antoniopagliaro@tin.it>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon Thunderbird, Abit KT7 Raid, Kernel 2.4: DESKTOP FROZEN!
In-Reply-To: <01071023392004.02550@lila.localdomain>
Message-ID: <Pine.LNX.4.31.0107110151280.4986-100000@b0rked.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My box: Athlon Thunderbird 900 MHz, MotherboardAbit KT7 Raid,
> Kernel 2.4 (the one that comes with Red Hat 7.1 no updates)
>
> I get apparently random desktop freezing.

Hmm, I have a similar machine.
	K7-800, KT7 RAID, 2.4.5 kernel (was .0 at install time).

>
> Last time:
>
> I was just doing nothing so the screensaver
> was on when I noticed the screen was frozen. Nor the keyboard
> neither the mouse worked. No combination of CTRL-ALT keys.
> Only choice left: reset. I did it.  When it booted again I got a
>
> Kernel Panic: Attempted to kill the idle task
> In idle: not syncing.

Err.. attempted to kill the idle task? Are you sure you don't have an
overheating processor?

>
> (by the way: what is the SysRq magic or something similar?
> Does it help? Which keys??)
>

SysRq will only help if the machine is responsive; and then even still
it's not going to correct issues like overheating processors and etc.

<snip>
>
> Is this really a KDE problem? I myself doubt...
> It could be a kernel problem or maybe hardware (I checked
> all the ram and removed one, but freezing is still there)
>

Shhouldn't be a problem with KDE. It *could* be with X, since (unless
you're using the framebuffer driver), it's directly accessing the
hardware.

Try starting up to a console and building a kernel with fb support, and
then use X through that and see if that solves any problems. (I haven't
had a single crash since; just that, for some reason, the sysrq key gets
disabled on startup and occasionally a framebuffer program will crash and
take my keyboard along with it. "Oops".)

> Thanks for any help, I am in trouble!!
>
> Antonio
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

