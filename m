Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293118AbSB1KGE>; Thu, 28 Feb 2002 05:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293236AbSB1KEB>; Thu, 28 Feb 2002 05:04:01 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:23568 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293228AbSB1KCK>; Thu, 28 Feb 2002 05:02:10 -0500
Date: Thu, 28 Feb 2002 10:58:57 +0100
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Ben Clifford <benc@hawaga.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.5-dj1 - problem with /dev/input/mice
Message-ID: <20020228095857.GD774@elf.ucw.cz>
In-Reply-To: <20020222022329.A3533@suse.cz> <Pine.LNX.4.33.0202241249540.11220-100000@barbarella.hawaga.org.uk> <20020224222708.A1814@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020224222708.A1814@ucw.cz>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If I unload psmouse.o and then load it again, I am back to (**1) until I
> > load the Xserver again.
> 
> That's interesting. It almost looks like if the Xserver messed with the
> mouse hardware somehow, which I hope it can't. Does 'dmesg' say anything

Of course it can, it is iopl(3) after all, but it certainly *should*
not and probably does not.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
