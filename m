Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317469AbSGEOM4>; Fri, 5 Jul 2002 10:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317470AbSGEOM4>; Fri, 5 Jul 2002 10:12:56 -0400
Received: from molly.vabo.cz ([160.216.153.99]:3335 "EHLO molly.vabo.cz")
	by vger.kernel.org with ESMTP id <S317469AbSGEOMy>;
	Fri, 5 Jul 2002 10:12:54 -0400
Date: Fri, 5 Jul 2002 16:15:21 +0200 (CEST)
From: Tomas Konir <moje@molly.vabo.cz>
X-X-Sender: moje@moje.ich.vabo.cz
To: venom@sns.it
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBM Desktar disk problem?
In-Reply-To: <Pine.LNX.4.43.0207051524480.9092-100000@cibs9.sns.it>
Message-ID: <Pine.LNX.4.44L0.0207051606050.32493-100000@moje.ich.vabo.cz>
References: <Pine.LNX.4.43.0207051524480.9092-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2002 venom@sns.it wrote:

> On Fri, 5 Jul 2002, Jens Axboe wrote:
> 
> > Date: Fri, 5 Jul 2002 12:40:37 +0200
> > From: Jens Axboe <axboe@suse.de>
> > To: venom@sns.it
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: IBM Desktar disk problem?
> >
> > On Fri, Jul 05 2002, venom@sns.it wrote:
> > >
> > > HI,
> > > I was trying kernel 2.5 with TCQ enabled.
> > > I tried it on three Desktar disk (manufactured in Thailand
> > > in february 2001) model dtla 305020.
> > >
> > > All three disk died after some week, without
> > > any signal of being dying.
> > > I was starting to suspect about an HW problem.
> > >
> > > With 2.4 kernels, no tcq, they could work
> > > without any problem for almost 8 months, but now,
> > > I moved those disk to test systems to test tcq support
> > > and all died badly. This is not an heat problem, since
> > > thay staty in a CED conditioned at 18C.
> >
> > This is a puzzling report. I wouldn't recommend that anyone use tcq in
> > 2.5 actually, since even I do not know what state it is currently in. I
> > would seriously recommend 2.4 + tcq patches instead.
> >
> > That said, are your disks completely dead now? As in they do not work
> > with a regular 2.4 kernel anymore?!
> 
> Right now they are good just for the trash box.
> There is no way they could work, and I listen a noisy
> tic-tac frrr tic-tac from the head of the disks...
> 
> 
> I would think to an HW problem, but why all three together?
> and why exacly when I tested tcq?
> 

hi i have similar problem.
No dead disks, but after two days testing tcq patches (on 2.4). I 
got the two ATA errors (smartctl said). 
I think that it's no good to test tcq on IBM disks. My disk was without 
any problems one year. Two problems now is not normal.
For final i think, that tcq patch is not fully stable, becouse on high 
disk load i get oops and have to reboot. I have no problem when i remove 
tcq patches.
(high load i mean copy cca 20GiB between two IBM disks).


	MOJE


-- 
Tomas Konir
Brno
ICQ 25849167


