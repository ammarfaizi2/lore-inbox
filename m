Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBIHDh>; Fri, 9 Feb 2001 02:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129030AbRBIHD1>; Fri, 9 Feb 2001 02:03:27 -0500
Received: from www.wen-online.de ([212.223.88.39]:48652 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129026AbRBIHDS>;
	Fri, 9 Feb 2001 02:03:18 -0500
Date: Fri, 9 Feb 2001 08:03:14 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: christophe barbe <christophe.barbe@inup.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Animated framebuffer logo for 2.4.1
In-Reply-To: <20010208150859.A19950@pc8.inup.com>
Message-ID: <Pine.Linu.4.10.10102090732320.1612-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, christophe barbe wrote:

> Ok it seems not important to have a nice boot process but each time you show a linux machine to a M$ normal user (normal = not a programmer) his first reaction is something like ""what are all these strange output lines?". And it's the first thing that keep Windows user in the dark side. 
> Windows hides (or try to do) all messages by a blue screen (light blue, when you are lucky). 
> 
> For these reason, I use LPP (linux patch progress). It's a little patch. The main idea is : redirect all boot messages on the second console, display on the first one a bigger framebuffer logo (screen size) and draw on it the progress bar, progress text and warning messages. A proc interface is provided for the second part of the boot process (echo "starting X Font Server" > /proc/progress).
> 
> The boot is not significantly longer (and with a well fitted kernel, is really faster than M$ Wx) and suddendly the first linux impression is really good.
> 
> I hope this kind of patch can be integrated in the kernel.

I hope that nothing like this is _ever_ integrated (and doubt I need
be concerned;).  IMHO, hiding output from users arrogantly assumes
that they are too stupid/ignorant to have any use for such information.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
