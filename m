Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286396AbRL0Rpv>; Thu, 27 Dec 2001 12:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286394AbRL0Rot>; Thu, 27 Dec 2001 12:44:49 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:63570 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S286390AbRL0Ro3>; Thu, 27 Dec 2001 12:44:29 -0500
Message-ID: <000701c18ed8$73f2b2d0$0801a8c0@Stev.org>
From: "James Stevenson" <mistral@stev.org>
To: "Stephan von Krawczynski" <skraw@ithnet.com>
Cc: <jlladono@pie.xtec.es>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3C285B40.91A83EC7@jep.dhis.org><001a01c18d77$a9e92ca0$0801a8c0@Stev.org> <20011226173307.34e25fe6.skraw@ithnet.com>
Subject: Re: 2.4.x kernels, big ide disks and old bios
Date: Thu, 27 Dec 2001 13:14:43 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > my workaround:
> >
> > dont set the jumper on the disk to make it look smaller.
> > this however will stop it working in the bios so you need to
> > disable the disk in the bios completly and turn off the ide
> > auto detection process in the bios this is because it will
> > probably hang if you try to use it :)
> >
> > linux will then pick the disk up from the ide controller.
>
> I tried this one some time ago, and had to find out, that I was not able
to
> write to the upper cylinders of the disk. You can check this out _before_
using
> the drive via dd from /dev/zero to your /dev/drive and look at the
results.

it seems to work fine for me.
could it be possible that the chipset that you are using does not support
disks bigger than 32GB ?


