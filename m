Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRBHOJY>; Thu, 8 Feb 2001 09:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129173AbRBHOJP>; Thu, 8 Feb 2001 09:09:15 -0500
Received: from mail.inup.com ([194.250.46.226]:516 "EHLO www.inup.com")
	by vger.kernel.org with ESMTP id <S129078AbRBHOJE>;
	Thu, 8 Feb 2001 09:09:04 -0500
Date: Thu, 8 Feb 2001 15:08:59 +0100
From: christophe barbe <christophe.barbe@inup.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Animated framebuffer logo for 2.4.1
Message-ID: <20010208150859.A19950@pc8.inup.com>
In-Reply-To: <20010208004021.D189@bug.ucw.cz> <Pine.LNX.4.33.0102080736190.5431-100000@asdf.capslock.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0102080736190.5431-100000@as
 df.capslock.lan>; from mharris@opensourceadvoca
 te.org on jeu, fév 08, 2001 at 13:37:48 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok it seems not important to have a nice boot process but each time you show a linux machine to a M$ normal user (normal = not a programmer) his first reaction is something like ""what are all these strange output lines?". And it's the first thing that keep Windows user in the dark side. 
Windows hides (or try to do) all messages by a blue screen (light blue, when you are lucky). 

For these reason, I use LPP (linux patch progress). It's a little patch. The main idea is : redirect all boot messages on the second console, display on the first one a bigger framebuffer logo (screen size) and draw on it the progress bar, progress text and warning messages. A proc interface is provided for the second part of the boot process (echo "starting X Font Server" > /proc/progress).

The boot is not significantly longer (and with a well fitted kernel, is really faster than M$ Wx) and suddendly the first linux impression is really good.

I hope this kind of patch can be integrated in the kernel.

Christophe Barbé


On jeu, 08 fév 2001 13:37:48 Mike A. Harris wrote:
> On Thu, 8 Feb 2001, Pavel Machek wrote:
> 
> >> I've created a patch for kernel 2.4.1 that adds some fancy options for
> >> the framebuffer console driver concerning the boot logo.
> >> I've added logo animation and logo centering.
> >> People may find this not very useful but nice to look at. :-)
> >
> >Long time ago I joked that win2000 will have 30-minute film at the
> >bootup. [3.1 had picture, 95+ had static logo with moving line...] And
> >now it looks like _linux_ is getting that feature...
> >								Pavel,
> >wondering when linux boot gets so long that mpeg2 player gets
> >integrated into kernel.
> 
> ;o)
> 
> I doubt strongly that that is technically possible. In fact I'm
> sure it is not.
> 
> 
> ----------------------------------------------------------------------
>     Mike A. Harris  -  Linux advocate  -  Free Software advocate
>           This message is copyright 2001, all rights reserved.
>   Views expressed are my own, not necessarily shared by my employer.
> ----------------------------------------------------------------------
> "Facts do not cease to exist because they are ignored."
>                                                - Aldous Huxley
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
-- 
Christophe Barbé
Software Engineer
Lineo High Availability Group
42-46, rue Médéric
92110 Clichy - France
phone (33).1.41.40.02.12
fax (33).1.41.40.02.01
www.lineo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
