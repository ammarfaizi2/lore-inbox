Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317440AbSGEMd6>; Fri, 5 Jul 2002 08:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317443AbSGEMd5>; Fri, 5 Jul 2002 08:33:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21187 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317440AbSGEMdz>;
	Fri, 5 Jul 2002 08:33:55 -0400
Date: Fri, 5 Jul 2002 14:36:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: venom@sns.it, linux-kernel@vger.kernel.org
Subject: Re: IBM Desktar disk problem?
Message-ID: <20020705123618.GA19690@suse.de>
References: <Pine.LNX.4.43.0207051217160.8506-100000@cibs9.sns.it> <Pine.LNX.4.43.0207051217160.8506-100000@cibs9.sns.it> <5.1.0.14.2.20020705114704.00b06a10@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020705114704.00b06a10@pop.cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05 2002, Anton Altaparmakov wrote:
> At 11:40 05/07/02, Jens Axboe wrote:
> >On Fri, Jul 05 2002, venom@sns.it wrote:
> >>
> >> HI,
> >> I was trying kernel 2.5 with TCQ enabled.
> >> I tried it on three Desktar disk (manufactured in Thailand
> >> in february 2001) model dtla 305020.
> >>
> >> All three disk died after some week, without
> >> any signal of being dying.
> >> I was starting to suspect about an HW problem.
> >>
> >> With 2.4 kernels, no tcq, they could work
> >> without any problem for almost 8 months, but now,
> >> I moved those disk to test systems to test tcq support
> >> and all died badly. This is not an heat problem, since
> >> thay staty in a CED conditioned at 18C.
> >
> >This is a puzzling report. I wouldn't recommend that anyone use tcq in
> >2.5 actually, since even I do not know what state it is currently in. I
> >would seriously recommend 2.4 + tcq patches instead.
> >
> >That said, are your disks completely dead now? As in they do not work
> >with a regular 2.4 kernel anymore?!
> 
> It is puzzling indeed, especially since I am running with TCQ enabled ever 
> since you introduced it and my disk is still alive an kicking. It being a 
> Deathstar, too.

Good to know, I'm glad it works for you :-)

> On of my Deathstars actually broke (before TCQ came about though!) but 
> after upgrading the firmware on it and powercycling it fixed itself and has 
> been working just fine ever since.
> 
> Perhaps something worth trying on those broken disks, too?

Might be a good idea, I did the same thing on my DTLA as well.

-- 
Jens Axboe

