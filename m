Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267022AbSLKFRw>; Wed, 11 Dec 2002 00:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267024AbSLKFRw>; Wed, 11 Dec 2002 00:17:52 -0500
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:57298 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267022AbSLKFRw>; Wed, 11 Dec 2002 00:17:52 -0500
Date: Tue, 10 Dec 2002 22:18:31 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: atyfb in 2.5.51
In-Reply-To: <1039561870.538.28.camel@zion>
Message-ID: <Pine.LNX.4.33.0212102215450.2617-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> AFAIK, the X "mach64" driver in XF 4.* doesn't care about UseFBDev.
> Marc Aurele La France (maintainer of this driver) is basically allergic
> to kernel fbdev support.

:-(

> I don't know if happened with earlier fbdev versions for you, but one
> possibility is that X reconfigures the display base, and possibly more
> bits of the card's internal memory map. Either fbdev should restore
> that, or adapt to what X set. On R128's and radeon's, this is things
> like DISPLAY_BASE_ADDR.

I will have to go threw the X code to fix that :-(

> > I have also tried aty128fb with some local patches to get it to
> > compile for my G4 powerbook.  It also doesn't draw the penguin, and it
> > oopses when X starts, for some reason.
>
> Hrm... I'll have to test radeonfb... It worked yesteday in console (I
> don't remember about the penguin) but I didn't try X.

No penguin. That is weird. I get the penguin on my ix86 box.


