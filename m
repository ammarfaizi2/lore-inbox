Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287871AbSABSBJ>; Wed, 2 Jan 2002 13:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287886AbSABSA7>; Wed, 2 Jan 2002 13:00:59 -0500
Received: from femail11.sdc1.sfba.home.com ([24.0.95.107]:9681 "EHLO
	femail11.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S287871AbSABSAv>; Wed, 2 Jan 2002 13:00:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
Date: Tue, 1 Jan 2002 15:36:41 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org,
        linux-fbdev-devel@lists.sourceforge.net (Linux Frame Buffer Device
	Development)
In-Reply-To: <E16LMNj-0008Gz-00@the-village.bc.nu>
In-Reply-To: <E16LMNj-0008Gz-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020102180050.YPL2594.femail11.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 January 2002 05:42 am, Alan Cox wrote:
> > > X11 isn't always an improvement.  I've got an X hang on my laptop
> > > (about once a week) that freezes the keyboard and ignores mouse clicks.
> > >  Numlock doesn't change the keyboard LEDs, CTRL-ALT-BACKSPACE won't do
> > > a thing, and although I can ssh in and run top (and see the CPU-eating
> > > loop), kill won't take X down and kill-9 leaves the video display up so
> > > the console that thinks it's in text mode, but isn't, is still useless.
> > >  (And that's assuming I'm plugged into the network and have another box
> > > around to ssh in from...)
>
> Neomagic Magicgraph 128XD ? If so check man neomagic first 8)

Neomagic 256AV.  I'll feed it the two disables the man page recommends and 
see if that makes the problem go away.  (I can trigger it almost at will by 
playing around with kmail with the threaded view of 2500+ linux-kernel 
messages and paging up and down really fast.  Or by switching the display 
when )

Kmail seems to be the only thing that actually triggers it.  I can't think of 
a lockup where kmail wasn't involved, but killing kmail (or the whole of kde) 
won't unfreeze the display and keyboard once it's borked, and when I ssh in 
and run top it's X that's got the cpu pegged at 99%, not any of the kde 
toys...

Rob

