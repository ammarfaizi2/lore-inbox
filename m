Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRBVM7l>; Thu, 22 Feb 2001 07:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129279AbRBVM7a>; Thu, 22 Feb 2001 07:59:30 -0500
Received: from 24.68.117.103.on.wave.home.com ([24.68.117.103]:60076 "EHLO
	cs865114-a.amp.dhs.org") by vger.kernel.org with ESMTP
	id <S129134AbRBVM70>; Thu, 22 Feb 2001 07:59:26 -0500
Date: Thu, 22 Feb 2001 07:59:10 -0500 (EST)
From: Arthur Pedyczak <arthur-p@home.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Oopses in 2.4.1  (lots of them)
In-Reply-To: <E14QQkR-0008B6-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0102220752030.12840-100000@cs865114-a.amp.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2001, Alan Cox wrote:

> > report got ignored). After running for 4 days I got many, many oopses.
> > They were trigerred by xscreensaver, and some other X-related apps.
> > After dopping to runlevel 3, the system seemed O.K. Nothing unusual in
> > graphics: Riva TNT2
>
> That makes it harder to say 'Use a 3.3.6 X server'. If you are using the
> nvidia binary/obfuscated modules for their 3d and stuff try running without
> them.
>
Alan,
Looks like you were 100% right about nvidia kernel module. After I
eliminated it and reverted to the driver coming with XFree-4.0.1, my
system seems stable again. It's been up for 7 days (with NVdriver from
nvidia I couldn't get past 72 hrs mark).
Thanks for your help!

A.

