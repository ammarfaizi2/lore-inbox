Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261562AbRFQQqd>; Sun, 17 Jun 2001 12:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbRFQQqX>; Sun, 17 Jun 2001 12:46:23 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:5380 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S261562AbRFQQqN>;
	Sun, 17 Jun 2001 12:46:13 -0400
Message-ID: <20010617183421.B121@bug.ucw.cz>
Date: Sun, 17 Jun 2001 18:34:21 +0200
From: Pavel Machek <pavel@suse.cz>
To: Leon Breedt <ljb@devco.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch] nonblinking VGA block cursor
In-Reply-To: <20010615162249.A1328@rinoa.rinoa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010615162249.A1328@rinoa.rinoa>; from Leon Breedt on Fri, Jun 15, 2001 at 04:22:49PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Attached is a patch to enforce a non-blinking, FreeBSD-syscons like
> block cursor in console mode.
> 
> This is useful for laptop types, or people like me who really really
> detest a blinking cursor.
> 
> NOTE: It disables the softcursor escape codes 
>       (/usr/src/linux/Documentation/VGA-softcursor.txt), since I don't 
>       ever want anything to change my cursor shape/style :)
> 
> It applies cleanly against 2.4.5, to use, select: 
> 
> 'VGA block cursor (non-blinking) support' in the 'Console drivers'
> section of menuconfig.

You want softcursor to be used after console reset. Ok. I want
non-standard pallete after console reset. Should I also add an option?

What could make sense would be "Escape sequence to do after console
reset". You could type there softcursor sequence to make it solid, and
I could type there sequence to change my pallete. Seems less ugly than 
special config option for each such feature.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
