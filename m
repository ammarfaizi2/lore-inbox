Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbTBAKvs>; Sat, 1 Feb 2003 05:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264799AbTBAKvs>; Sat, 1 Feb 2003 05:51:48 -0500
Received: from ts46-03-qds26.cbn.wa.charter.com ([68.116.27.27]:36737 "EHLO
	furcntrl.khat-fox.com") by vger.kernel.org with ESMTP
	id <S264790AbTBAKvr>; Sat, 1 Feb 2003 05:51:47 -0500
Date: Sat, 1 Feb 2003 03:01:24 -0800 (PST)
From: Chris Bradford <lkml-read@khat-fox.com>
To: Tomas Szepe <szepe@pinerecords.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Current Status of Module Utilities for 2.5 Kernels?
In-Reply-To: <20030201081352.GQ12286@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.52.0302010235200.18691@furcntrl.khat-fox.com>
References: <Pine.LNX.4.52.0301312304210.22442@furcntrl.khat-fox.com>
 <20030201081352.GQ12286@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 Feb 2003, Tomas Szepe wrote:

> > [lkml-read@khat-fox.com]
> >
> > I'm using Slackware 9.0 beta as my distribution, which uses gcc 3.2.1 as
> > its C compiler.  My problems started when I noted that kernel 2.4 is not
> > compilable by gcc v3.x.
>
> gcc-3.2.1 compiles 2.4.20 (at least) just fine.
> I can confirm that standard sw90 development packages are ok.
>
Yes, I finally was able to get 2.4.20 to build for me.  Turns out that I
had to massage the build configuration a little bit first.  Reminds me of
a few fernels that wouldn't build *unless* SMP was enabled in the config.
SMP on a single CPU machine?  Yes, I like wasting 400K by putting in a
feature that I won't actually be using.
> > gcc 3.x.  My upgrade produced another hitch, I was unable to use modules.
> > My video card, which uses an nVidia TNT2, is of limited usefulness without
> > the ability to load modules.
> >
> > Is there a work-around for my problems?
>
> Yes, you need to read the archives prior to posting a question
> to see if another 50 people haven't posted the same one before.
>
Ah, the archives.  Would these be the same archives that are both
incomplete, and scattered across three, maybe more, locations?  Kernel
Traffic is the best of the lot, and I had problems searching it.  I do a
simple search for 'modutils' and it spits out 350+K of stuff.  Stuff that
has absolutely nothing to do with the module utilities.
