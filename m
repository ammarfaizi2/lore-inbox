Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282654AbRLWN2F>; Sun, 23 Dec 2001 08:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286884AbRLWN1z>; Sun, 23 Dec 2001 08:27:55 -0500
Received: from p0173.as-l043.contactel.cz ([194.108.242.173]:1284 "EHLO devix")
	by vger.kernel.org with ESMTP id <S282654AbRLWN1s>;
	Sun, 23 Dec 2001 08:27:48 -0500
Date: Sun, 23 Dec 2001 00:35:00 +0100 (CET)
From: devik <devik@cdi.cz>
X-X-Sender: <devik@devix>
To: Pavel Machek <pavel@suse.cz>
cc: Robert Love <rml@tech9.net>, Chris Meadors <clubneon@hereintown.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: gcc 3.0.2/kernel details (-O issue)
In-Reply-To: <20011222215457.A118@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0112230027060.12151-100000@devix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > optimization introduce are accepted.  Removing the optimization may
> > break those expectations.  Thus the kernel requires it.
>
> Huh? Those expectations are *bugs*.
>
> Kernel will not link without optimalizations because it *needs*
> inlining. Any else dependency is a *bug*.

Pavel, thanks for your reply. I already started to be afraid that
kernel code makes such strange expectations.
Inlining. Yes it explains a lot. It is the difference between -O
and -O2.
BTW the kernel compiles and links without inlining (with -O). It
just doesn't work ;-) Interestingly enough I have had the bad habit
of using -O as compile speed up factor for pretty long time while
working on 2.2.x ..

devik

