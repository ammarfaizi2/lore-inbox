Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316909AbSGEKr7>; Fri, 5 Jul 2002 06:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316969AbSGEKr6>; Fri, 5 Jul 2002 06:47:58 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:61805 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316909AbSGEKr6>; Fri, 5 Jul 2002 06:47:58 -0400
Message-Id: <5.1.0.14.2.20020705114704.00b06a10@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 05 Jul 2002 11:50:26 +0100
To: Jens Axboe <axboe@suse.de>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: IBM Desktar disk problem?
Cc: venom@sns.it, linux-kernel@vger.kernel.org
In-Reply-To: <20020705104037.GM1007@suse.de>
References: <Pine.LNX.4.43.0207051217160.8506-100000@cibs9.sns.it>
 <Pine.LNX.4.43.0207051217160.8506-100000@cibs9.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:40 05/07/02, Jens Axboe wrote:
>On Fri, Jul 05 2002, venom@sns.it wrote:
> >
> > HI,
> > I was trying kernel 2.5 with TCQ enabled.
> > I tried it on three Desktar disk (manufactured in Thailand
> > in february 2001) model dtla 305020.
> >
> > All three disk died after some week, without
> > any signal of being dying.
> > I was starting to suspect about an HW problem.
> >
> > With 2.4 kernels, no tcq, they could work
> > without any problem for almost 8 months, but now,
> > I moved those disk to test systems to test tcq support
> > and all died badly. This is not an heat problem, since
> > thay staty in a CED conditioned at 18C.
>
>This is a puzzling report. I wouldn't recommend that anyone use tcq in
>2.5 actually, since even I do not know what state it is currently in. I
>would seriously recommend 2.4 + tcq patches instead.
>
>That said, are your disks completely dead now? As in they do not work
>with a regular 2.4 kernel anymore?!

It is puzzling indeed, especially since I am running with TCQ enabled ever 
since you introduced it and my disk is still alive an kicking. It being a 
Deathstar, too.

On of my Deathstars actually broke (before TCQ came about though!) but 
after upgrading the firmware on it and powercycling it fixed itself and has 
been working just fine ever since.

Perhaps something worth trying on those broken disks, too?

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

