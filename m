Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRCLFzV>; Mon, 12 Mar 2001 00:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129517AbRCLFzL>; Mon, 12 Mar 2001 00:55:11 -0500
Received: from [195.63.194.11] ([195.63.194.11]:54789 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S129511AbRCLFzD>; Mon, 12 Mar 2001 00:55:03 -0500
Message-ID: <3AAC7009.BFA260CD@evision-ventures.com>
Date: Mon, 12 Mar 2001 07:43:21 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
CC: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Penguin logos
In-Reply-To: <200103120112.f2C1Csj165543@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:
> 
> Geert Uytterhoeven writes:
> 
> >   - The colors for the 16 color logo are wrong. We used a hack to
> >     give the logo its own color palette, but this no longer works
> >     as a side effect of a console color map bug being fixed a while
> >     ago. The solution is to replace the logo with a new one that
> >     uses the standard VGA console palette.
> 
> Good idea, but the feet don't look too good. Either dither a bit,
> or pick a single color for the feet. Maybe a checkerboard-dither
> would get close to the right color without looking grainy.
> 
> >   - There are still some politically-incorrect (PI) logos of a penguin
> >     holding a glass of beer or wine (or perhaps even worse? :-).
> 
> Those also just look bad. The drink sort of floats above the penguin's
> foot. It really looks like it was just pasted onto the image.
> 
> The arch-specific logos look bad in general, and the swirly gray
> background isn't so great either. Why not use the original image?

I agree fully about the swirly gray - it's just looks ugly chlidish,
dilletantic
and very tasteless... plain color or some gui alike border would look
much better.

> 
> > Changes:
> >  1. Update the frame buffer console code to no longer change the
> >     palette when displaying the 16 color logo. Remove the tricks
> >     to load the logo palette in unused palette entries on displays
> >     with >= 32 colors.
> 
> I used to have only 256 colors on my display. I upgraded because
> there still isn't a global system palette. I'd have been happy
> enough with 256 colors allocated in a sane way, for kernel & X:
> 
> 1. the 16 VGA colors and extra 4 Windows colors (so Wine can work)
> 2. the 216 Netscape colors
> 3. gray: 0x00, 0x11, 0x22... 0xff, plus both 0x7f and 0x80
> 4. everything else reserved for future global allocation
> 
> The current situation is way too painful to use.
