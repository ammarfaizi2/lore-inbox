Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284177AbRLWXGP>; Sun, 23 Dec 2001 18:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284147AbRLWXGF>; Sun, 23 Dec 2001 18:06:05 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:58631 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S284171AbRLWXFw>;
	Sun, 23 Dec 2001 18:05:52 -0500
Date: Sun, 23 Dec 2001 01:30:59 +0000
From: Pavel Machek <pavel@suse.cz>
To: Ilguiz Latypov <ilatypov@superbt.com>
Cc: linux-kernel@vger.kernel.org, sjh@wibble.net
Subject: Re: pc speaker cant be accessed with no video card in computer
Message-ID: <20011223013059.A53@toy.ucw.cz>
In-Reply-To: <3C2259E2.4070504@superbt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3C2259E2.4070504@superbt.com>; from ilatypov@superbt.com on Thu, Dec 20, 2001 at 04:36:34PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I guess it is not easy to produce a series of sounds without
> waiting each note to finish.  There is an 8 year old PC speaker
> driver for BSD kernel that performs the BASIC PLAY lines in kernel.
> 
> Rather than porting it to Linux I chose a simple option of copying
> the ioctl PC speaker code into a skeleton misc character device
> driver.  As a result I can issue ioctl "beep" calls against my
> /dev/pcspeaker (character device with major number 10, minor number
> 240).  E.g., replacing "/dev/console" with "/dev/pcspeaker" in
> PCMCIA cardmgr.c will revive its sound effects.

Snip... There's driver enabling you to play mp3-s on pc speaker (etc, it
does full /dev/dsp).... Separate task but maybe you wanted to know...

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

